import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/services/auth_service.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenha();
}

class _RecuperarSenha extends State<RecuperarSenha> {
  final TextEditingController _emailController = TextEditingController();
  String mensagemErro = '';

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void recuperarSenha() async {
    try {
      await authService.value.mudarSenhaEsquecida(email: _emailController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        mensagemErro = e.message ?? 'Existe um erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD02670),
      body: Center(
        child: Container(
          width: 320,
          height: 290,
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
                      errorBuilder: (context, error, stack) =>
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
                  'Recuperar senha',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Digite seu e-mail  para recuperar a senha',
                  style: TextStyle(fontSize: 14, color: Color(0xFF525252)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'E-mail',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 288,
                  height: 32,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Insira seu e-mail',
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    SizedBox(
                      width: 139,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD02670),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFFBDBDBD),
                            width: 1,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Voltar           '),
                            Icon(Icons.arrow_back, size: 20),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    SizedBox(
                      width: 139,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () {
                          recuperarSenha();
                        },
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
                          children: const [
                            Text('Enviar'),
                            SizedBox(width: 30),
                            Icon(Icons.arrow_right_alt, size: 26),
                          ],
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
    );
  }
}
