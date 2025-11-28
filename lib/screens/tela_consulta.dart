import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/consulta.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/services/banco_service.dart';
import 'tela_pet.dart';
import 'adiciona_consulta.dart';

class TelaConsulta extends StatelessWidget {
  final Pet pet;

  const TelaConsulta({super.key, required this.pet});

  static const cor = Color(0xFFD02670);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    final minBodyHeight =
        MediaQuery.of(context).size.height -
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
                  top: BorderSide(color: cor, width: 8),
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
                              'Consultas',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: cor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaPet(pet: pet),
                                  ),
                                );
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
                          'Pet - ${pet.nome}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder<List<Consulta>>(
                          stream: bancoService.getConsultasDoPet(pet.id!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return const Center(child: Text('Erro ao carregar as consultas.'));
                            }
                            final consultas = snapshot.data ?? [];
                            if (consultas.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Text('Nenhuma consulta cadastrada.'),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TelaAdicionarConsulta(pet: pet),
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
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children:[
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: consultas.length,
                                  itemBuilder: (context, index) {
                                    final consulta = consultas[index];
                                    return _CardConsulta(pet: pet, consulta: consulta);
                                  },
                                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TelaAdicionarConsulta(pet: pet),
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

class _CardConsulta extends StatelessWidget {
  final Pet pet;
  final Consulta consulta;

  const _CardConsulta({required this.pet, required this.consulta});

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat('dd/MM/yyyy').format(consulta.data);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CampoSimples(titulo: 'Descrição', valor: consulta.descricao),
          const SizedBox(height: 8),
          _CampoSimples(titulo: 'Data', valor: dataFormatada),
          const SizedBox(height: 8),
          _CampoSimples(titulo: 'Hora', valor: consulta.hora),
          const SizedBox(height: 8),
          _CampoSimples(
            titulo: 'Nome (Clínica ou veterinário)',
            valor: consulta.nomeLocal,
          ),
          const SizedBox(height: 8),
          _CampoSimples(titulo: 'Cidade', valor: consulta.cidade),
          const SizedBox(height: 8),
          _CampoSimples(titulo: 'Bairro', valor: consulta.bairro),
          const SizedBox(height: 8),
          _CampoSimples(titulo: 'Rua', valor: consulta.rua),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text(
                        'Você tem certeza que deseja apagar consulta?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.red),
                            elevation: 0,
                          ),
                          onPressed: () {
                            bancoService.deletarConsulta(pet.id!, consulta.id!);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Apagar',
                            style: TextStyle(color: Colors.red),
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
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CampoSimples extends StatelessWidget {
  final String titulo;
  final String valor;

  const _CampoSimples({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
