import 'package:flutter/material.dart';
import 'tela_configuracao.dart';
import 'inserir_codigo.dart'; 

class TelaAlterarSenha extends StatefulWidget {
  const TelaAlterarSenha({super.key});

  static const cor = Color(0xFFD02670);

  @override
  State<TelaAlterarSenha> createState() => _TelaAlterarSenhaState();
}

class _TelaAlterarSenhaState extends State<TelaAlterarSenha> {
  final _senhaAntigaController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TelaAlterarSenha.cor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TelaConfiguracao()),
            );
          },
        ),
        title: const Text(
          'Pets',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F4),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alterar senha',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),

              
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Digite a senha antiga', style: TextStyle(fontSize: 13)),
              ),
              TextField(
                controller: _senhaAntigaController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Input text',
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 18),

              
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Digite a nova senha', style: TextStyle(fontSize: 13)),
              ),
              TextField(
                controller: _novaSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Input text',
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 18),

              
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Confirma nova senha', style: TextStyle(fontSize: 13)),
              ),
              TextField(
                controller: _confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Input text',
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

             
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const InserirCodigo()),
                  );
                },
                child: const Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    color: TelaAlterarSenha.cor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TelaConfiguracao()),
                        );
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: TelaAlterarSenha.cor),
                      label: const Text('Voltar',
                          style: TextStyle(color: TelaAlterarSenha.cor)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: TelaAlterarSenha.cor),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TelaConfiguracao()),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        'Confirmar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TelaAlterarSenha.cor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
  }
}
