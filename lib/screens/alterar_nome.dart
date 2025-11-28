import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TelaAlterarNome extends StatefulWidget {
  const TelaAlterarNome({super.key});

  static const cor = Color(0xFFD02670);

  @override
  State<TelaAlterarNome> createState() => _TelaAlterarNomeState();
}

class _TelaAlterarNomeState extends State<TelaAlterarNome> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomeController.text = _auth.currentUser?.displayName ?? '';
  }

  Future<void> _alterarNome() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = _auth.currentUser;
        if (user != null && user.email != null) {
          final cred = EmailAuthProvider.credential(
            email: user.email!,
            password: _senhaController.text,
          );

          await user.reauthenticateWithCredential(cred);
          await user.updateDisplayName(_nomeController.text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nome alterado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'wrong-password') {
          message = 'A senha está incorreta.';
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
      backgroundColor: TelaAlterarNome.cor,
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
                  'Alterar nome',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Nome', style: TextStyle(fontSize: 13)),
                ),
                TextFormField(
                  controller: _nomeController,
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
                      return 'Por favor, digite o nome.';
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
                            color: TelaAlterarNome.cor),
                        label: const Text(
                          'Voltar',
                          style: TextStyle(color: TelaAlterarNome.cor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: TelaAlterarNome.cor),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _alterarNome,
                        icon:
                            const Icon(Icons.arrow_forward, color: Colors.white),
                        label: const Text(
                          'Confirmar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TelaAlterarNome.cor,
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
