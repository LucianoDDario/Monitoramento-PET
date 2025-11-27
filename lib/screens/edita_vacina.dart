import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/vacina.dart';
import 'package:projeto/services/banco_service.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import 'tela_vacina.dart';

class TelaEditarVacina extends StatefulWidget {
  final Pet pet;
  final Vacina vacina;
  const TelaEditarVacina({super.key, required this.pet, required this.vacina});

  static const cor = Color(0xFFD02670);

  @override
  State<TelaEditarVacina> createState() => _TelaEditarVacinaState();
}

class _TelaEditarVacinaState extends State<TelaEditarVacina> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _vetController = TextEditingController();
  final _dataController = TextEditingController();
  final _proximaDataController = TextEditingController();

  DateTime? _dataAplicacao;
  DateTime? _proximaData;

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.vacina.nome;
    _vetController.text = widget.vacina.veterinario;

    _dataAplicacao = widget.vacina.dataAplicacao.toDate();
    _dataController.text = DateFormat('dd/MM/yyyy').format(_dataAplicacao!);

    if (widget.vacina.proximaData != null) {
      _proximaData = widget.vacina.proximaData!.toDate();
      _proximaDataController.text = DateFormat('dd/MM/yyyy').format(_proximaData!);
    }
  }

  InputDecoration get _dec => const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );

  Widget _tituloCampo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(t, style: const TextStyle(fontSize: 14, color: Colors.black)),
      );

  Future<void> _pickDate(bool isProximaData) async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: (isProximaData ? _proximaData : _dataAplicacao) ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (c, child) => Theme(
        data: Theme.of(c).copyWith(
          colorScheme: const ColorScheme.light(primary: TelaEditarVacina.cor),
        ),
        child: child!,
      ),
    );

    if (d != null) {
      setState(() {
        if (isProximaData) {
          _proximaData = d;
          _proximaDataController.text = DateFormat('dd/MM/yyyy').format(d);
        } else {
          _dataAplicacao = d;
          _dataController.text = DateFormat('dd/MM/yyyy').format(d);
        }
      });
    }
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      final vacinaAtualizada = Vacina(
        id: widget.vacina.id,
        nome: _nomeController.text,
        veterinario: _vetController.text,
        dataAplicacao: Timestamp.fromDate(_dataAplicacao!),
        proximaData: _proximaData != null ? Timestamp.fromDate(_proximaData!) : null,
      );

      await bancoService.editarVacina(widget.pet.id!, vacinaAtualizada);

      Navigator.pushAndRemoveUntil(
          context,
          NoAnimationPageRoute(
            builder: (context) => TelaVacina(pet: widget.pet),
          ),
          (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TelaEditarVacina.cor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Colors.white,
            ),
            Container(
              height: 75,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Pets.png', width: 26, height: 26),
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
                        'Editar vacina',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: TelaEditarVacina.cor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pet - ${widget.pet.nome}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _tituloCampo('Nome'),
                      TextFormField(
                        controller: _nomeController,
                        decoration: _dec.copyWith(hintText: 'Antirrábica'),
                        validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 12),
                      _tituloCampo('Veterinário'),
                      TextFormField(
                        controller: _vetController,
                        decoration: _dec.copyWith(hintText: 'Dr. João'),
                        validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 12),
                      _tituloCampo('Data de aplicação'),
                      TextFormField(
                        controller: _dataController,
                        readOnly: true,
                        onTap: () => _pickDate(false),
                        decoration: _dec.copyWith(
                          hintText: '00/00/0000',
                          suffixIcon: const Icon(Icons.calendar_today, size: 18),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 12),
                      _tituloCampo('Data da próxima vacina (Opcional)'),
                      TextFormField(
                        controller: _proximaDataController,
                        readOnly: true,
                        onTap: () => _pickDate(true),
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
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back, size: 18),
                              label: const Text('Voltar'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: TelaEditarVacina.cor,
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
                              onPressed: _salvar,
                              icon: const Icon(
                                Icons.save,
                                size: 20,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Salvar',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TelaEditarVacina.cor,
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
      ),
    );
  }
}
