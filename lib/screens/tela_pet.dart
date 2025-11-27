import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/screens/tela_consulta.dart';
import 'package:projeto/screens/tela_galeria.dart';
import 'package:projeto/screens/tela_medicamento.dart';
import 'package:projeto/screens/tela_vacina.dart';
import 'package:projeto/screens/tela_veterinario.dart';
import 'package:projeto/services/banco_service.dart';
import 'package:projeto/services/storage_service.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import 'telainicial.dart';
import 'editar_pet.dart';

const _brand = Color(0xFFD02670);
const _cardBg = Color(0xFFF3F3F4);
const _grey = Color(0xFF525252);

class TelaPet extends StatefulWidget {
  final Pet pet;

  const TelaPet({super.key, required this.pet});

  @override
  State<TelaPet> createState() => _TelaPetState();
}

class _TelaPetState extends State<TelaPet> {
  Future<void> deletar() async {
    try {
      if (widget.pet.fotoPerfilPetUrl != null &&
          widget.pet.fotoPerfilPetUrl!.isNotEmpty) {
        await storageService.deletarFotoPorUrl(widget.pet.fotoPerfilPetUrl!);
      }

      await bancoService.deletarPet(widget.pet.id!);

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        NoAnimationPageRoute(builder: (context) => const TelaInicial()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Erro ao deletar: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao deletar o pet.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final nomeTutor = user?.displayName ?? user?.email ?? 'Voce';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(Icons.pets, size: 20),
                  SizedBox(width: 8),
                  Text('Pets', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      // --- AQUI ESTÁ O SEGREDO ---
                      // Define que a altura mínima é a altura total disponível na tela
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Container(
                        width: double.infinity,
                        color: _brand, // Agora o rosa vai até o fim
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Linha com "Meu pet" e botão "Voltar"
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Meu pet',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: _brand,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) =>
                                              const TelaInicial(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 18,
                                      color: _brand,
                                    ),
                                    label: const Text(
                                      'Voltar',
                                      style: TextStyle(
                                        color: _brand,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: _brand,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Container(
                                decoration: BoxDecoration(
                                  color: _cardBg,
                                  border: Border.all(
                                    color: const Color(0xFFE3E3E3),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 86,
                                      height: 86,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0xFFE0E0E0),
                                        ),
                                      ),
                                      child:
                                          widget.pet.fotoPerfilPetUrl != null &&
                                                  widget
                                                      .pet
                                                      .fotoPerfilPetUrl!
                                                      .isNotEmpty
                                              ? Image.network(
                                                  widget.pet.fotoPerfilPetUrl!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (c, o, s) =>
                                                      const Icon(
                                                        Icons.pets,
                                                        size: 28,
                                                        color: _grey,
                                                      ),
                                                )
                                              : const Icon(
                                                  Icons.photo,
                                                  size: 28,
                                                  color: _grey,
                                                ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.pet.nome,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          const Text(
                                            'Tutor',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: _grey,
                                            ),
                                          ),
                                          Text(
                                            nomeTutor,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: _grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              NoAnimationPageRoute(
                                                builder: (context) =>
                                                    TelaEditarPet(pet: widget.pet),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: _grey,
                                          ),
                                        ),
                                        const SizedBox(height: 45),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      12,
                                                    ),
                                                  ),
                                                  title: const Text(
                                                    'Tem certeza que deseja excluir este pet?',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Essa ação não pode ser desfeita.',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        side:
                                                            const BorderSide(
                                                          color: Colors
                                                              .red,
                                                        ),
                                                        elevation: 0,
                                                      ),
                                                      onPressed: () {
                                                        deletar();
                                                      },
                                                      child: const Text(
                                                        'Apagar',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            Icons.delete_outline,
                                            size: 20,
                                            color: _grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0EFF4),
                                  border: Border.all(
                                    color: const Color(0xFFE3E3E3),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  12,
                                  12,
                                  8,
                                ),
                                child: Column(
                                  children: [
                                    _LinhaDupla(
                                      esqTitulo: 'Raça',
                                      esqValor: widget.pet.raca,
                                      dirTitulo: 'Espécie',
                                      dirValor: widget.pet.especie,
                                    ),
                                    _LinhaDupla(
                                      esqTitulo: 'Idade',
                                      esqValor: widget.pet.idade.toString(),
                                      dirTitulo: 'Nascimento',
                                      dirValor: widget.pet.dataNascimento,
                                    ),
                                    _LinhaDupla(
                                      esqTitulo: 'Sexo',
                                      esqValor: widget.pet.sexo,
                                      dirTitulo: 'Observação',
                                      dirValor: '-',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              _ActionItem(
                                label: 'Veterinários',
                                onTap: () => Navigator.push(
                                  context,
                                  NoAnimationPageRoute(
                                    builder: (context) =>
                                        TelaVeterinario(pet: widget.pet),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _ActionItem(
                                label: 'Vacinas',
                                onTap: () => Navigator.push(
                                  context,
                                  NoAnimationPageRoute(
                                    builder: (context) =>
                                        TelaVacina(pet: widget.pet),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _ActionItem(
                                label: 'Medicamentos',
                                onTap: () => Navigator.push(
                                  context,
                                  NoAnimationPageRoute(
                                    builder: (context) =>
                                        TelaMedicamento(pet: widget.pet),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _ActionItem(
                                label: 'Consultas',
                                onTap: () => Navigator.push(
                                  context,
                                  NoAnimationPageRoute(
                                    builder: (context) =>
                                        TelaConsulta(pet: widget.pet),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _ActionItem(
                                label: 'Galeria',
                                onTap: () => Navigator.push(
                                  context,
                                  NoAnimationPageRoute(
                                    builder: (context) =>
                                        TelaGaleria(pet: widget.pet),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinhaDupla extends StatelessWidget {
  final String esqTitulo, esqValor, dirTitulo, dirValor;

  const _LinhaDupla({
    required this.esqTitulo,
    required this.esqValor,
    required this.dirTitulo,
    required this.dirValor,
  });

  @override
  Widget build(BuildContext context) {
    Text t(String s) =>
        Text(s, style: const TextStyle(fontSize: 12, color: _grey));
    Text v(String s) => Text(
          s,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [t(esqTitulo), const SizedBox(height: 20), v(esqValor)],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [t(dirTitulo), const SizedBox(height: 12), v(dirValor)],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _brand),
          foregroundColor: _brand,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}
