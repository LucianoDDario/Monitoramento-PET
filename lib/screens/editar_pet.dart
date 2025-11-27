import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/services/banco_service.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import 'telainicial.dart';

class TelaEditarPet extends StatefulWidget {
  final Pet pet;

  const TelaEditarPet({super.key, required this.pet});

  static const cor = Color(0xFFD02670);

  @override
  State<TelaEditarPet> createState() => _TelaEditarPetState();
}

class _TelaEditarPetState extends State<TelaEditarPet> {
  final _form = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _especieController = TextEditingController();
  final _racaController = TextEditingController();
  final _dataNascController = TextEditingController();
  String? _sexo, _castrado, _file;

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.pet.nome;
    _especieController.text = widget.pet.especie;
    _racaController.text = widget.pet.raca;
    _dataNascController.text = widget.pet.dataNascimento;
    _sexo = widget.pet.sexo;
    _castrado = widget.pet.castrado;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _especieController.dispose();
    _racaController.dispose();
    _dataNascController.dispose();
    super.dispose();
  }

  InputDecoration get _dec => const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1990),
      lastDate: now,
      helpText: 'Data de nascimento',
      builder: (c, child) => Theme(
        data: Theme.of(c).copyWith(
          colorScheme: const ColorScheme.light(primary: TelaEditarPet.cor),
        ),
        child: child!,
      ),
    );
    if (d != null) {
      _dataNascController.text =
          '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
      setState(() {});
    }
  }

  Future<void> _salvar() async {
    if (_form.currentState!.validate()) {
      final petAtualizado = Pet(
        id: widget.pet.id,
        uid: widget.pet.uid,
        nome: _nomeController.text,
        raca: _racaController.text,
        especie: _especieController.text,
        dataNascimento: _dataNascController.text,
        sexo: _sexo!,
        castrado: _castrado!,
        idade: widget.pet.idade, // A idade não é editável aqui
        fotoPerfilPetUrl: widget.pet.fotoPerfilPetUrl, // A foto não é editável aqui
      );
      await bancoService.editarPet(petAtualizado);
      Navigator.pushAndRemoveUntil(
        context,
        NoAnimationPageRoute(builder: (context) => const TelaInicial()),
        (route) => false,
      );
    }
  }

  Widget _tituloCampo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(t, style: const TextStyle(fontSize: 14, color: Colors.black)),
      );

  Widget _radio(
    String label,
    String val,
    String? grupo,
    void Function(String?) f,
  ) =>
      RadioListTile<String>(
        dense: true,
        value: val,
        groupValue: grupo,
        onChanged: f,
        title: Text(label, style: const TextStyle(fontSize: 14)),
        contentPadding: EdgeInsets.zero,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const _NoStretchBehavior(),
          child: Column(
            children: [
              Container(
                height: 68,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Pets.png',
                      width: 22,
                      height: 22,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.pets, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Pets',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Container(
                    color: TelaEditarPet.cor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Editar pet',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: TelaEditarPet.cor,
                              ),
                            ),
                            const SizedBox(height: 14),
                            _tituloCampo('Nome'),
                            TextFormField(
                              controller: _nomeController,
                              decoration: _dec.copyWith(
                                hintText: 'Digite o nome do bichinho',
                              ),
                            ),
                            const SizedBox(height: 12),
                            _tituloCampo('Data de nascimento'),
                            TextFormField(
                              controller: _dataNascController,
                              readOnly: true,
                              onTap: _pickDate,
                              decoration: _dec.copyWith(
                                hintText: '00/00/0000',
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _tituloCampo('Sexo'),
                            _radio(
                              'Fêmea',
                              'Fêmea',
                              _sexo,
                              (v) => setState(() => _sexo = v),
                            ),
                            _radio(
                              'Macho',
                              'Macho',
                              _sexo,
                              (v) => setState(() => _sexo = v),
                            ),
                            const SizedBox(height: 6),
                            _tituloCampo('Espécie'),
                            TextFormField(
                              controller: _especieController,
                              decoration: _dec.copyWith(
                                hintText: 'Digite a espécie do bichinho',
                              ),
                            ),
                            const SizedBox(height: 12),
                            _tituloCampo('Raça'),
                            TextFormField(
                              controller: _racaController,
                              decoration: _dec.copyWith(
                                hintText: 'Digite a raça do bichinho',
                              ),
                            ),
                            const SizedBox(height: 12),
                            _tituloCampo('Castrado'),
                            _radio(
                              'Sim',
                              'S',
                              _castrado,
                              (v) => setState(() => _castrado = v),
                            ),
                            _radio(
                              'Não',
                              'N',
                              _castrado,
                              (v) => setState(() => _castrado = v),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Insira uma foto de perfil para o seu bichinho (Opcional)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'São suportados arquivos .jpg e .png',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 36,
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    setState(() => _file = 'foto.png'),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Adicionar'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: TelaEditarPet.cor,
                                  ),
                                  foregroundColor: TelaEditarPet.cor,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_file != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _file!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          setState(() => _file = null),
                                      icon: const Icon(Icons.close, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => Navigator.of(context).pop(),
                                    icon: const Icon(Icons.arrow_back, size: 18),
                                    label: const Text('Voltar'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: TelaEditarPet.cor,
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color(0xFFBDBDBD),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _salvar,
                                    icon: const Icon(Icons.arrow_forward,
                                        size: 20, color: Colors.white),
                                    label: const Text(
                                      'Confirmar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TelaEditarPet.cor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoStretchBehavior extends ScrollBehavior {
  const _NoStretchBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();

  @override
  Widget buildOverscrollIndicator(
    BuildContext c,
    Widget child,
    ScrollableDetails d,
  ) =>
      child;
}
