import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/models/pet.dart';
import 'tela_consulta.dart';

class TelaAdicionarConsulta extends StatefulWidget {
  final Pet pet;
  const TelaAdicionarConsulta({super.key, required this.pet});
  static const cor = Color(0xFFD02670);

  @override
  State<TelaAdicionarConsulta> createState() => _TelaAdicionarConsultaState();
}

class _TelaAdicionarConsultaState extends State<TelaAdicionarConsulta> {
  String? veterinarioSelecionado;
  DateTime? dataSelecionada;
  TimeOfDay? horaSelecionada;

  final List<String> veterinarios = [
    'Dr. João Silva',
    'Dra. Maria Oliveira',
    'Dr. Pedro Costa',
    'Dra. Ana Paula',
  ];

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

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

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );
    if (data != null) {
      setState(() {
        dataSelecionada = data;
        _dataController.text =
            "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
      });
    }
  }

  Future<void> _selecionarHora() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: horaSelecionada ?? TimeOfDay.now(),
    );
    if (hora != null) {
      setState(() {
        horaSelecionada = hora;
        _horaController.text =
            "${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: TelaAdicionarConsulta.cor,
      body: Column(
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
                      'Adicionar consulta',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: TelaAdicionarConsulta.cor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pet - Seu Pet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _tituloCampo('Descrição'),
                    TextField(
                      controller: _descricaoController,
                      decoration:
                          _dec.copyWith(hintText: 'Ex: Retorno clínico'),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Data'),
                    TextField(
                      controller: _dataController,
                      readOnly: true,
                      onTap: _selecionarData,
                      decoration: _dec.copyWith(
                        hintText: '00/00/0000',
                        suffixIcon: const Icon(Icons.calendar_today, size: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Hora'),
                    TextField(
                      controller: _horaController,
                      readOnly: true,
                      onTap: _selecionarHora,
                      decoration: _dec.copyWith(
                        hintText: '00:00',
                        suffixIcon: const Icon(Icons.access_time, size: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _tituloCampo('Veterinário'),
                    DropdownButtonFormField<String>(
                      value: veterinarioSelecionado,
                      items: veterinarios.map((v) {
                        return DropdownMenuItem(
                          value: v,
                          child: Text(v),
                        );
                      }).toList(),
                      onChanged: (valor) {
                        setState(() {
                          veterinarioSelecionado = valor;
                        });
                      },
                      decoration:
                          _dec.copyWith(hintText: 'Selecione o veterinário'),
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
                                  builder: (context) => TelaConsulta(pet: widget.pet),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_back, size: 18),
                            label: const Text('Voltar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: TelaAdicionarConsulta.cor,
                              backgroundColor: Colors.white,
                              side:
                                  const BorderSide(color: Color(0xFFBDBDBD)),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
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
                                  builder: (context) => TelaConsulta(pet: widget.pet),
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
                              backgroundColor: TelaAdicionarConsulta.cor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
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
