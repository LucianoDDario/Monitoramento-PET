import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'telainicial.dart'; // Import para voltar para a Home corretamente

class TelaCadastroPet extends StatefulWidget {
  const TelaCadastroPet({super.key});
  static const cor = Color(0xFFD02670);

  @override
  State<TelaCadastroPet> createState() => _TelaCadastroPetState();
}

class _TelaCadastroPetState extends State<TelaCadastroPet> {
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  
  // Controladores para pegar os textos digitados
  final _nomeController = TextEditingController();
  final _especieController = TextEditingController();
  final _racaController = TextEditingController();
  final _dataNascController = TextEditingController();
  final _pesoController = TextEditingController();

  String? _sexo;
  String? _castrado;
  File? _fotoPet;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    // Limpa a memória quando a tela fecha
    _nomeController.dispose();
    _especieController.dispose();
    _racaController.dispose();
    _dataNascController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  // --- LÓGICA DE UI (Front-end) ---

  InputDecoration get _dec => const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      );

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1990),
      lastDate: now,
      builder: (c, child) => Theme(
        data: Theme.of(c).copyWith(
          colorScheme: const ColorScheme.light(primary: TelaCadastroPet.cor),
        ),
        child: child!,
      ),
    );
    if (d != null) {
      // Formata a data para o padrão brasileiro
      _dataNascController.text =
          '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => _fotoPet = File(image.path));
      }
    } catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
    }
  }

  // --- LÓGICA DE DADOS (O "Backend" vai aqui depois) ---
  
  void _salvarPet() {
    // 1. Valida se os campos obrigatórios estão preenchidos
    // if (_formKey.currentState!.validate()) { ... }

    // 2. Aqui entra a lógica de salvar no Banco de Dados (Firebase/SQLite)
    // Por enquanto, apenas simulamos e voltamos para a tela inicial
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pet salvo com sucesso! (Simulação)')),
    );

    // Navega de volta para a Tela Inicial recarregando tudo
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaInicial()),
      (route) => false, // Remove todas as telas anteriores da pilha
    );
  }

  Widget _tituloCampo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 8),
        child: Text(t, style: const TextStyle(fontSize: 14, color: Colors.black)),
      );

  Widget _radio(String label, String val, String? grupo, void Function(String?) f) =>
      Expanded(
        child: RadioListTile<String>(
          dense: true,
          value: val,
          groupValue: grupo,
          onChanged: f,
          activeColor: TelaCadastroPet.cor,
          title: Text(label, style: const TextStyle(fontSize: 14)),
          contentPadding: EdgeInsets.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    // Garante barra de status correta
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: TelaCadastroPet.cor, // Fundo Rosa
      body: Column(
        children: [
          // Área segura do topo
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          // Header
          Container(
            height: 60,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Pets.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 24),
                ),
                const SizedBox(width: 10),
                const Text('Pets',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ],
            ),
          ),

          // Área Branca com o Formulário
          Expanded(
            child: Container(
              color: TelaCadastroPet.cor,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Adicionar novo pet',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: TelaCadastroPet.cor,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // --- FOTO ---
                            Center(
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                    image: _fotoPet != null 
                                      ? DecorationImage(
                                          image: FileImage(_fotoPet!), 
                                          fit: BoxFit.cover
                                        )
                                      : null,
                                  ),
                                  child: _fotoPet == null
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.add_a_photo, color: Colors.grey),
                                            SizedBox(height: 4),
                                            Text('Foto', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                          ],
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            _tituloCampo('Nome'),
                            TextFormField(
                              controller: _nomeController,
                              decoration: _dec.copyWith(hintText: 'Nome do pet'),
                            ),

                            _tituloCampo('Data de nascimento'),
                            TextFormField(
                              controller: _dataNascController,
                              readOnly: true,
                              onTap: _pickDate,
                              decoration: _dec.copyWith(
                                hintText: '00/00/0000',
                                suffixIcon: const Icon(Icons.calendar_today, size: 18),
                              ),
                            ),

                            _tituloCampo('Peso (kg)'),
                            TextFormField(
                              controller: _pesoController,
                              keyboardType: TextInputType.number,
                              decoration: _dec.copyWith(hintText: 'Ex: 12.5'),
                            ),

                            _tituloCampo('Espécie'),
                            TextFormField(
                              controller: _especieController,
                              decoration: _dec.copyWith(hintText: 'Cachorro, Gato...'),
                            ),

                            _tituloCampo('Raça'),
                            TextFormField(
                              controller: _racaController,
                              decoration: _dec.copyWith(hintText: 'Vira-lata, Siamês...'),
                            ),

                            const SizedBox(height: 12),
                            const Text('Sexo', style: TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                _radio('Fêmea', 'F', _sexo, (v) => setState(() => _sexo = v)),
                                _radio('Macho', 'M', _sexo, (v) => setState(() => _sexo = v)),
                              ],
                            ),

                            const SizedBox(height: 12),
                            const Text('Castrado?', style: TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                _radio('Sim', 'S', _castrado, (v) => setState(() => _castrado = v)),
                                _radio('Não', 'N', _castrado, (v) => setState(() => _castrado = v)),
                              ],
                            ),
                            
                            const SizedBox(height: 30),

                            // --- BOTÕES DE AÇÃO ---
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.arrow_back, size: 18),
                                    label: const Text('Voltar'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: TelaCadastroPet.cor,
                                      side: const BorderSide(color: TelaCadastroPet.cor),
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _salvarPet, // Chama a função preparada para o backend
                                    icon: const Icon(Icons.save, size: 18, color: Colors.white),
                                    label: const Text(
                                      'Salvar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TelaCadastroPet.cor,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}