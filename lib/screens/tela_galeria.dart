import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/services/storage_service.dart';

class TelaGaleria extends StatefulWidget {
  final Pet pet;
  const TelaGaleria({super.key, required this.pet});
  static const cor = Color(0xFFD02670);

  @override
  State<TelaGaleria> createState() => _TelaGaleriaState();
}

class _TelaGaleriaState extends State<TelaGaleria> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;
  bool _modoSelecao = false;
  final Set<String> _selecionadas = {};

  String get uid => _auth.currentUser!.uid;
  DocumentReference get _petDocRef => _firestore
      .collection('usuarios')
      .doc(uid)
      .collection('pets')
      .doc(widget.pet.id);

  void _alternarSelecao(String url) {
    setState(() {
      if (_selecionadas.contains(url)) {
        _selecionadas.remove(url);
      } else {
        _selecionadas.add(url);
      }
    });
  }

  Future<void> _adicionarFotos() async {
    if (_isLoading) return;

    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final newImageUrls =
          await storageService.uploadFotosGaleria(pickedFiles, widget.pet.id!);

      if (newImageUrls.isEmpty) {
        throw Exception('Ocorreu um erro no upload das imagens.');
      }

      await _petDocRef.update({
        'galeriaUrls': FieldValue.arrayUnion(newImageUrls),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fotos adicionadas!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar fotos: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          'Apagar ${_selecionadas.length} foto(s)?',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Essa ação não pode ser desfeita!',
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.red),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(context);
              _excluirFotos();
            },
            child: const Text('Apagar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _excluirFotos() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      await _petDocRef.update({
        'galeriaUrls': FieldValue.arrayRemove(_selecionadas.toList()),
      });

      for (String url in _selecionadas) {
        await storageService.deletarFotoPorUrl(url);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fotos excluídas!')),
      );

      setState(() {
        _selecionadas.clear();
        _modoSelecao = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir fotos: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TelaGaleria.cor,
      body: Column(
        children: [
          _appBar(),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: TelaGaleria.cor, width: 27),
                  left: BorderSide(color: TelaGaleria.cor, width: 10),
                  right: BorderSide(color: TelaGaleria.cor, width: 10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 16),
                    _botoesAcao(),
                    const SizedBox(height: 10),
                    if (_modoSelecao && _selecionadas.isEmpty)
                      const Text(
                        'Selecione as fotos que deseja excluir',
                        style: TextStyle(color: Colors.black54),
                      ),
                    const SizedBox(height: 10),
                    _gridFotos(),
                    if (_modoSelecao && _selecionadas.isNotEmpty)
                      _botoesExclusao(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() => Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 10),
        child: Row(
          children: [
            Image.asset('assets/images/Pets.png', width: 22, height: 22,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.pets, size: 22, color: Colors.black)),
            const SizedBox(width: 8),
            const Text('Pets', style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      );

  Widget _header() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Galeria',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: TelaGaleria.cor)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(children: [
              Text('Voltar',
                  style: TextStyle(
                      color: TelaGaleria.cor, fontWeight: FontWeight.w600)),
              SizedBox(width: 4),
              Icon(Icons.arrow_back, color: TelaGaleria.cor, size: 18),
            ]),
          ),
        ],
      );

  Widget _botoesAcao() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _adicionarFotos,
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 40),
                backgroundColor: Colors.white,
                foregroundColor: TelaGaleria.cor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                side: const BorderSide(color: TelaGaleria.cor)),
            child: const Text('Adicionar'),
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              _modoSelecao = !_modoSelecao;
              _selecionadas.clear();
            }),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 40),
                backgroundColor: Colors.white,
                foregroundColor: TelaGaleria.cor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                side: const BorderSide(color: TelaGaleria.cor)),
            child: Text(_modoSelecao ? 'Cancelar' : 'Selecionar'),
          ),
        ],
      );

  Widget _gridFotos() => Expanded(
        child: Stack(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: _petDocRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return const Center(child: Text('Nenhuma foto na galeria.'));
                }
                final pet = Pet.fromMap(
                    snapshot.data!.data() as Map<String, dynamic>,
                    snapshot.data!.id);
                final urls = pet.galeriaUrls;

                if (urls.isEmpty) {
                  return const Center(
                      child: Text('Adicione a primeira foto do seu pet!'));
                }

                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8),
                  itemCount: urls.length,
                  itemBuilder: (context, index) {
                    final url = urls[index];
                    final selecionada = _selecionadas.contains(url);
                    return GestureDetector(
                      onTap: () {
                        if (_modoSelecao) _alternarSelecao(url);
                      },
                      child: Stack(fit: StackFit.expand, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(url, fit: BoxFit.cover,
                              loadingBuilder: (_, child, progress) =>
                                  progress == null
                                      ? child
                                      : Container(
                                          color: const Color(0xFFF4F2F7),
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                                  color: TelaGaleria.cor)))),
                        ),
                        if (selecionada)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: Icon(Icons.check_circle,
                                    color: Colors.white, size: 30)),
                          ),
                      ]),
                    );
                  },
                );
              },
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),
          ],
        ),
      );

  Widget _botoesExclusao() => Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Baixar'),
              style: OutlinedButton.styleFrom(
                  foregroundColor: TelaGaleria.cor,
                  side: const BorderSide(color: TelaGaleria.cor),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _confirmarExclusao,
              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.white),
              label: const Text('Apagar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: TelaGaleria.cor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            ),
          ),
        ],
      );
}
