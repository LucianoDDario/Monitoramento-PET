import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/models/pet.dart';
import 'tela_medicamento.dart';

class TelaAdicionarMedicamento extends StatelessWidget {
  final Pet pet;
  const TelaAdicionarMedicamento({super.key, required this.pet});
  static const cor = Color(0xFFD02670);

  InputDecoration get _dec => const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );

  Widget _tituloCampo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          t,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: cor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          Container(
            height: 80,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Pets.png',
                  width: 26,
                  height: 26,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adicionar medicamento',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: cor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pet - ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _tituloCampo('Nome'),
                    TextField(
                      decoration: _dec.copyWith(hintText: 'Vermífugo'),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Período'),
                    TextField(
                      decoration: _dec.copyWith(hintText: '8 em 8h'),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Data de início'),
                    TextField(
                      readOnly: true,
                      decoration: _dec.copyWith(
                        hintText: '00/00/0000',
                        suffixIcon: const Icon(Icons.calendar_today, size: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Data de término'),
                    TextField(
                      readOnly: true,
                      decoration: _dec.copyWith(
                        hintText: '00/00/0000',
                        suffixIcon: const Icon(Icons.calendar_today, size: 18),
                      ),
                    ),
                    const SizedBox(height: 22), 
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaMedicamento(pet: pet),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_back, size: 18),
                            label: const Text('Voltar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: cor,
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFBDBDBD)),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaMedicamento(pet: pet),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.save,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Adicionar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
