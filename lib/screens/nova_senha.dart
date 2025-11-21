import 'package:flutter/material.dart';

class NovaSenha extends StatefulWidget {
  const NovaSenha({super.key});

  @override
  State<NovaSenha> createState() => _NovaSenhaEstado();
}

class _NovaSenhaEstado extends State<NovaSenha> {
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  bool mostrarSenha = false;
  bool mostrarConfirmarSenha = false;

  @override
  void dispose() {
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  void avancar() {
    if (senhaController.text == confirmarSenhaController.text &&
        senhaController.text.isNotEmpty) {
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não conferem.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD02670),
      body: Center(
        child: Container(
          width: 320,
          height: 340,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/Pets.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (context, erro, pilha) =>
                          const Icon(Icons.pets, size: 24),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Pets',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Recuperar Senha',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                const SizedBox(height: 8),

                const Text('Senha',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                const SizedBox(height: 6),
                SizedBox(
                  width: 288,
                  height: 32,
                  child: TextField(
                    controller: senhaController,
                    obscureText: !mostrarSenha,
                    decoration: InputDecoration(
                      hintText: 'Insira sua senha',
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border:
                          const OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      suffixIcon: IconButton(
                        icon: Icon(
                          mostrarSenha ? Icons.visibility : Icons.visibility_off,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            mostrarSenha = !mostrarSenha;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text('Confirmar senha',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                const SizedBox(height: 6),
                SizedBox(
                  width: 288,
                  height: 32,
                  child: TextField(
                    controller: confirmarSenhaController,
                    obscureText: !mostrarConfirmarSenha,
                    decoration: InputDecoration(
                      hintText: 'Insira sua senha novamente',
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border:
                          const OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      suffixIcon: IconButton(
                        icon: Icon(
                          mostrarConfirmarSenha
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            mostrarConfirmarSenha = !mostrarConfirmarSenha;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 32,
                  child: ElevatedButton(
                    onPressed: avancar,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFD02670),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Avançar'),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_right_alt, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
