import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
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
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> _alterarSenha() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = _auth.currentUser;
        if (user != null && user.email != null) {
          final cred = EmailAuthProvider.credential(
            email: user.email!,
            password: _senhaAntigaController.text,
          );

          await user.reauthenticateWithCredential(cred);
          await user.updatePassword(_novaSenhaController.text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senha alterada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'wrong-password') {
          message = 'A senha antiga está incorreta.';
        } else if (e.code == 'weak-password') {
          message = 'A nova senha é muito fraca.';
        } else {
          message = 'Ocorreu um erro. Tente novamente.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
            Navigator.pop(context);
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
          child: Form(
            key: _formKey,
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
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a senha antiga.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Digite a nova senha', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a nova senha.';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Confirma nova senha', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme a nova senha.';
                    }
                    if (value != _novaSenhaController.text) {
                      return 'As senhas não coincidem.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      NoAnimationPageRoute(builder: (_) => const InserirCodigo()),
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
                          Navigator.pop(context);
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
                        onPressed: _alterarSenha,
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
      ),
    );
  }
}
