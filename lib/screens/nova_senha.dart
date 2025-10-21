import 'package:flutter/material.dart';

class NovaSenha extends StatelessWidget {
  const NovaSenha({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD02670),
      body: Center(
        child: Container(
          width: 320,
          height: 310,
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
                  'Recuperar Senha',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Senha',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 288,
                  height: 32,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Insira sua senha',
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
                const SizedBox(height: 12),

                const Text(
                  'Confirmar senha',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 288,
                  height: 32,
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Insira sua senha',
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
                const SizedBox(height: 20),

                SizedBox(
                  width: 150,
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
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
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Avançar'),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_right_alt, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
