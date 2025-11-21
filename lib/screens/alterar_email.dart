import 'package:flutter/material.dart';
import 'tela_configuracao.dart';

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TelaConfiguracao()),
            );
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
              TextField(
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
              ),
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Confirmar e-mail', style: TextStyle(fontSize: 13)),
              ),
              TextField(
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
              ),
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Senha', style: TextStyle(fontSize: 13)),
              ),
              TextField(
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
    );
  }
}
