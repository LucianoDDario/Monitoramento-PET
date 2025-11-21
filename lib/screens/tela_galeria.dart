import 'package:flutter/material.dart';

class TelaGaleria extends StatefulWidget {
  const TelaGaleria({super.key});
  static const cor = Color(0xFFD02670);

  @override
  State<TelaGaleria> createState() => _TelaGaleriaState();
}

class _TelaGaleriaState extends State<TelaGaleria> {
  bool modoSelecao = false;
  final Set<int> selecionadas = {};

  void alternarSelecao(int index) {
    setState(() {
      if (selecionadas.contains(index)) {
        selecionadas.remove(index);
      } else {
        selecionadas.add(index);
      }
    });
  }

  void confirmarExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Você tem certeza que deseja apagar 25 fotos?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Essa ação não pode ser desfeita!',
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.red),
              elevation: 0,
            ),
            onPressed: () {
              setState(() {
                selecionadas.clear();
                modoSelecao = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Apagar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TelaGaleria.cor,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 60,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Pets.png',
                  width: 22,
                  height: 22,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.pets, size: 22, color: Colors.black),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Galeria',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: TelaGaleria.cor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Row(
                            children: [
                              Text(
                                'Voltar',
                                style: TextStyle(
                                  color: TelaGaleria.cor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_back, color: TelaGaleria.cor, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 40),
                            backgroundColor: Colors.white,
                            foregroundColor: TelaGaleria.cor,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            side: const BorderSide(color: TelaGaleria.cor),
                          ),
                          child: const Text('Adicionar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              modoSelecao = !modoSelecao;
                              selecionadas.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 40),
                            backgroundColor: Colors.white,
                            foregroundColor: TelaGaleria.cor,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            side: const BorderSide(color: TelaGaleria.cor),
                          ),
                          child: Text(modoSelecao ? 'Cancelar' : 'Selecionar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (modoSelecao && selecionadas.isEmpty)
                      const Text(
                        'Selecione as fotos que deseja excluir',
                        style: TextStyle(color: Colors.black54),
                      ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8, 
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          final selecionada = selecionadas.contains(index);
                          return GestureDetector(
                            onTap: () {
                              if (modoSelecao) {
                                alternarSelecao(index);
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F2F7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                if (selecionada)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.check_circle,
                                          color: Colors.white, size: 30),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (modoSelecao && selecionadas.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.download, size: 18),
                              label: const Text('Baixar'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: TelaGaleria.cor,
                                side: const BorderSide(color: TelaGaleria.cor),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: confirmarExclusao,
                              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.white),
                              label: const Text('Apagar', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TelaGaleria.cor,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
        ],
      ),
    );
  }
}
