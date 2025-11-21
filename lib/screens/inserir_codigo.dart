import 'package:flutter/material.dart';

class InserirCodigo extends StatefulWidget {
  const InserirCodigo({super.key});

  @override
  State<InserirCodigo> createState() => _InserirCodigoEstado();
}

class _InserirCodigoEstado extends State<InserirCodigo> {
  void reenviar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link reenviado para o seu e-mail.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD02670),
      body: Center(
        child: Container(
          width: 320,
          height: 220,
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
                  'Recuperar senha',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Acesse o link enviado no seu e-mail',
                  style: TextStyle(fontSize: 15, color: Color(0xFF525252)),
                ),
                const SizedBox(height: 20),
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
                            Text('Voltar        '),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_back, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 139,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: reenviar,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFD02670),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Reenviar link'), SizedBox(width: 6)],
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
