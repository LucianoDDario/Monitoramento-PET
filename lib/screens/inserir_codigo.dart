import 'package:flutter/material.dart';

class InserirCodigo extends StatelessWidget {

  const InserirCodigo({super.key});

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
                  'Insira o código enviado no seu e-mail',
                  style: TextStyle(fontSize: 15, color: Color(0xFF525252)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      height: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
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
                              color: Color(0xFFBDBDBD), width: 1),
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/nova_senha');
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
                            Text('Confirmar'),
                            SizedBox(width: 6),
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
 
