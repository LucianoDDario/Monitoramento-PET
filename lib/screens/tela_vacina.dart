import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/vacina.dart';
import 'package:projeto/services/banco_service.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import 'edita_vacina.dart';
import 'adiciona_vacina.dart';


class TelaVacina extends StatelessWidget {
  final Pet pet;
  const TelaVacina({super.key, required this.pet});
  static const cor = Color(0xFFD02670);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    final minBodyHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: cor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          SafeArea(
            top: false,
            child: Container(
              height: 65,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: cor, width: 20),
                  left: BorderSide(color: cor, width: 20),
                  right: BorderSide(color: cor, width: 20),
                ),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minBodyHeight),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Vacinas',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: cor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Alterado para pop para um comportamento de navegação mais natural
                                Navigator.pop(context);
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Voltar',
                                    style: TextStyle(
                                      color: cor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_back, color: cor, size: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pet - ${pet.nome}', // Nome do pet dinâmico
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- LÓGICA COM STREAMBUILDER ---
                        StreamBuilder<List<Vacina>>(
                          stream: bancoService.getVacinasDoPet(pet.id!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(color: cor));
                            }
                            if (snapshot.hasError) {
                              return const Center(child: Text('Erro ao carregar as vacinas.'));
                            }

                            final vacinas = snapshot.data ?? [];

                            return Column(
                              children: [
                                // Gera os cards de vacina dinamicamente
                                if (vacinas.isNotEmpty)
                                  ...vacinas.map((vacina) => Padding(
                                        padding: const EdgeInsets.only(bottom: 14),
                                        child: _CardVacina(pet: pet, vacina: vacina),
                                      ))
                                else
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40.0),
                                    child: Center(child: Text('Nenhuma vacina cadastrada.')),
                                  ),

                                // Botão de adicionar sempre visível no final
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) => TelaAdicionarVacina(pet: pet),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F2F7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(18),
                                      child: const Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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
    );
  }
}

// Widget do card mantido, agora recebendo a vacina
class _CardVacina extends StatelessWidget {
  final Pet pet;
  final Vacina vacina;
  const _CardVacina({required this.pet, required this.vacina});

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat('dd/MM/yyyy').format(vacina.dataAplicacao.toDate());
    final proximaDataFormatada = vacina.proximaData != null
        ? DateFormat('dd/MM/yyyy').format(vacina.proximaData!.toDate())
        : '-';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _CampoDuplo(
                  titulo: 'Nome',
                  valor: vacina.nome, // Dado dinâmico
                  alinharDireita: false,
                ),
              ),
              Row(
                children: [
                  _CampoDuplo(
                    titulo: 'Data de aplicação',
                    valor: dataFormatada, // Dado dinâmico
                    alinharDireita: true,
                  ),
                  const SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        NoAnimationPageRoute(
                          builder: (context) => TelaEditarVacina(pet: pet, vacina: vacina), // Passa a vacina
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _CampoDuplo(
                  titulo: 'Veterinário',
                  valor: vacina.veterinario, // Dado dinâmico
                  alinharDireita: false,
                ),
              ),
              Row(
                children: [
                  _CampoDuplo(
                    titulo: 'Próxima vacina',
                    valor: proximaDataFormatada, // Dado dinâmico
                    alinharDireita: true,
                  ),
                  const SizedBox(width: 60),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: const Text(
                              'Você tem certeza que deseja apagar vacina?',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            content: const Text(
                              'Essa ação não pode ser desfeita!',
                              style: TextStyle(color: Colors.black54),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.red),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  // Lógica de deleção correta
                                  bancoService.deletarVacina(pet.id!, vacina.id!); 
                                  Navigator.pop(context);
                                },
                                child: const Text('Apagar', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget _CampoDuplo mantido exatamente igual
class _CampoDuplo extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool alinharDireita;

  const _CampoDuplo({
    required this.titulo,
    required this.valor,
    required this.alinharDireita,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alinharDireita ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          valor,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
