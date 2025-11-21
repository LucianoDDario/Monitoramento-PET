import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela_veterinario.dart';
import 'lista_veterinarios_proximos.dart'; // 1. IMPORT ADICIONADO

class TelaAdicionarVeterinario extends StatefulWidget {
  const TelaAdicionarVeterinario({super.key});

  @override
  State<TelaAdicionarVeterinario> createState() =>
      _TelaAdicionarVeterinarioState();
}

class _TelaAdicionarVeterinarioState extends State<TelaAdicionarVeterinario> {
  static const cor = Color(0xFFD02670);
  
  bool _mostrarFormulario = false;

  // Decoração dos campos (Fundo cinza, sem borda)
  InputDecoration get _dec => const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Color(0xFFF5F5F5), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none, 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      );

  Widget _tituloCampo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 4),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 14, 
            color: Color(0xFF666666),
          ),
        ),
      );

  // --- BOTÃO ESTILO FIGMA ---
  Widget _botaoOpcao({required String texto, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: cor, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              texto,
              style: const TextStyle(color: cor, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const Icon(Icons.arrow_forward, color: cor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTelaEscolha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCabecalhoInterno(),
        const SizedBox(height: 24),
        
        // 2. BOTÃO AGORA NAVEGA PARA A LISTA DE GPS
        _botaoOpcao(
          texto: 'Veterinários próximos',
          onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListaVeterinariosProximos()),
            );
          },
        ),
        
        _botaoOpcao(
          texto: 'Inserir veterinário manualmente',
          onPressed: () {
            setState(() {
              _mostrarFormulario = true;
            });
          },
        ),

        const Spacer(),

        _buildBotoesNavegacao(
          onVoltar: () => Navigator.pop(context),
          textoBotaoAcao: 'Avançar',
          onAcao: () {},
        ),
      ],
    );
  }

  Widget _buildFormularioManual() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCabecalhoInterno(),
        const SizedBox(height: 20),

        _tituloCampo('Nome (Clínica ou veterinário)'),
        TextField(
          decoration: _dec.copyWith(hintText: 'Dra Mariana'),
        ),
        
        const SizedBox(height: 12),
        _tituloCampo('Cidade'),
        TextField(
          decoration: _dec.copyWith(hintText: 'Piracicaba'),
        ),
        
        const SizedBox(height: 12),
        _tituloCampo('Bairro'),
        TextField(
          decoration: _dec.copyWith(hintText: 'Santa Terezinha'),
        ),
        
        const SizedBox(height: 12),
        _tituloCampo('Rua'),
        TextField(
          decoration: _dec.copyWith(hintText: 'Manoel de Barros Ferraz 177'),
        ),
        
        const SizedBox(height: 24),
        const Spacer(),

        _buildBotoesNavegacao(
          onVoltar: () {
            setState(() {
              _mostrarFormulario = false;
            });
          },
          textoBotaoAcao: 'Adicionar',
          onAcao: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaVeterinario()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBotoesNavegacao({
    required VoidCallback onVoltar,
    required VoidCallback onAcao,
    required String textoBotaoAcao,
  }) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onVoltar,
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Voltar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: cor,
              side: const BorderSide(color: cor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAcao,
            icon: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            label: Text(textoBotaoAcao, style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: cor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCabecalhoInterno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Adicionar Veterinário',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Pet Yuumi',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Garante a barra de status correta
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
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
            height: 60,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Pets.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.pets, color: Colors.black),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Pets',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Container(
              color: cor,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16), 
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white, 
                      ),
                      padding: const EdgeInsets.all(20),
                      child: IntrinsicHeight(
                        child: _mostrarFormulario 
                            ? _buildFormularioManual() 
                            : _buildTelaEscolha(),
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