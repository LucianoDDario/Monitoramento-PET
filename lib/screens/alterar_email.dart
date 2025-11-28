import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TelaAlterarEmail extends StatefulWidget {
  const TelaAlterarEmail({super.key});

  static const cor = Color(0xFFD02670);

  @override
  State<TelaAlterarEmail> createState() => _TelaAlterarEmailState();
}

class _TelaAlterarEmailState extends State<TelaAlterarEmail> {
  final _emailController = TextEditingController();
  final _confirmarEmailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = _auth.currentUser?.email ?? '';
  }

  Future<void> _alterarEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = _auth.currentUser;
        if (user != null && user.email != null) {
          final cred = EmailAuthProvider.credential(
            email: user.email!,
            password: _senhaController.text,
          );

          await user.reauthenticateWithCredential(cred);
          await user.verifyBeforeUpdateEmail(_emailController.text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Um e-mail de confirmação foi enviado para o novo endereço.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'wrong-password') {
          message = 'A senha está incorreta.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Este e-mail já está em uso.';
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
      backgroundColor: TelaAlterarEmail.cor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/Pets.png',
              width: 26,
              height: 26,
            ),
            const SizedBox(width: 8),
            const Text(
              'Pets',
              style: TextStyle(color: Colors.black),
            ),
          ],
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
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alterar e-mail',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('E-mail', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
                  controller: _emailController,
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
                      return 'Por favor, digite o e-mail.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Confirmar e-mail', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
                  controller: _confirmarEmailController,
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
                      return 'Por favor, confirme o e-mail.';
                    }
                    if (value != _emailController.text) {
                      return 'Os e-mails não coincidem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Senha', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
                  controller: _senhaController,
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
                      return 'Por favor, digite a senha.';
                    }
                    return null;
                  },
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
                            color: TelaAlterarEmail.cor),
                        label: const Text('Voltar',
                            style: TextStyle(color: TelaAlterarEmail.cor)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: TelaAlterarEmail.cor),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _alterarEmail,
                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                        label: const Text(
                          'Confirmar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TelaAlterarEmail.cor,
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
