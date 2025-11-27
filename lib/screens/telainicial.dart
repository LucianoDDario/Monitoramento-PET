import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/services/banco_service.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import 'tela_configuracao.dart';
import 'tela_pet.dart';
import 'adiciona_pet.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  static const cor = Color(0xFFD02670);
  static const fundoCard = Color(0xFFF3F3F4);
  static const cinzaTexto = Color(0xFF525252);

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CABEÇALHO (Mantido igual) ---
            Container(
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
                        const Icon(Icons.pets, size: 22),
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

            // --- CORPO DA TELA ---
            Expanded(
              child: Container(
                width: double.infinity,
                color: cor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Meus pets',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: cor,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings, color: cor),
                            onPressed: () {
                              Navigator.push(
                                context,
                                NoAnimationPageRoute(
                                  builder: (context) =>
                                      const TelaConfiguracao(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // --- AQUI ENTRA O STREAM BUILDER ---
                      Expanded(
                        child: StreamBuilder<List<Pet>>(
                          stream: bancoService.getPetsDoUsuario(uid),
                          builder: (context, snapshot) {
                            // 1. Tratamento de erro ou carregando
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(color: cor));
                            }

                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text("Erro ao carregar pets"));
                            }

                            // 2. Pega a lista de pets (se for nula, usa lista vazia)
                            final listaPets = snapshot.data ?? [];

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.55,
                              ),
                              // O tamanho é a qtde de pets + 1 (o card de adicionar)
                              itemCount: listaPets.length + 1,
                              itemBuilder: (context, index) {
                                // --- CARD DE ADICIONAR (Sempre o último) ---
                                if (index == listaPets.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) =>
                                              const TelaCadastroPet(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 216, 216, 216),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 216, 216, 216),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final pet = listaPets[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      NoAnimationPageRoute(
                                        builder: (context) => TelaPet(pet: pet),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: fundoCard,
                                      border: Border.all(
                                        color: const Color(0xFFE3E3E3),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Imagem do Pet
                                        Container(
                                          height: 120,
                                          width: double.infinity,
                                          color: Colors.grey.shade300,
                                          child: _imagemPet(pet
                                              .fotoPerfilPetUrl), // Função auxiliar abaixo
                                        ),
                                        const SizedBox(height: 10),
                                        // Nome do Pet
                                        Text(
                                          pet.nome,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),

                                        // Chips com dados reais
                                        _infoChip(
                                            Icons.calendar_today_outlined,
                                            '${pet.idade ?? "?"} anos'),
                                        const SizedBox(height: 6),
                                        _infoChip(Icons.pets, pet.raca ?? '-'),
                                        const SizedBox(height: 6),
                                        _infoChip(Icons.transgender,
                                            pet.sexo ?? '-'),
                                        const SizedBox(height: 6),
                                        _infoChip(Icons.category,
                                            pet.especie ?? '-'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para exibir a imagem (Arquivo local ou URL)
  Widget _imagemPet(String? path) {
    if (path == null || path.isEmpty) {
      return const Icon(Icons.photo, color: Colors.white70, size: 45);
    }
    // Se for URL da web (Firebase Storage)
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover);
    }
    // Se for arquivo local (salvo no dispositivo)
    return Image.file(File(path), fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.error));
  }

  static Widget _infoChip(IconData icon, String text) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: cinzaTexto),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11.5, color: cinzaTexto),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
