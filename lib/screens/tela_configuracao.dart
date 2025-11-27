import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/utils/no_animation_page_route.dart';
import '../auth_layout.dart';
import 'alterar_nome.dart';
import 'alterar_email.dart';
import 'alterar_senha.dart';

class TelaConfiguracao extends StatelessWidget {
  const TelaConfiguracao({super.key});

  static const cor = Color(0xFFD02670);
  static const fundoCard = Color(0xFFF3F3F4);

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      NoAnimationPageRoute(builder: (context) => const AuthLayout()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Image.asset(
                    'assets/images/Pets.png',
                    width: 22,
                    height: 22,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.pets, size: 22),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Pets',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: cor,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Configurações',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _botao(context, 'Alterar nome', const TelaAlterarNome()),
                      const SizedBox(height: 16),
                      _botao(context, 'Alterar e-mail', const TelaAlterarEmail()),
                      const SizedBox(height: 16),
                      _botao(context, 'Alterar senha', const TelaAlterarSenha()),
                      const Spacer(),
                      _logoutBotao(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botao(BuildContext context, String texto, Widget destino) {
    return SizedBox(
      height: 38,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            NoAnimationPageRoute(builder: (_) => destino),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: cor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          foregroundColor: cor,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(texto),
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _logoutBotao(BuildContext context) {
    return SizedBox(
      height: 38,
      child: OutlinedButton(
        onPressed: () => _logout(context),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: cor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          foregroundColor: cor,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sair'),
            Icon(Icons.exit_to_app, size: 18),
          ],
        ),
      ),
    );
  }
}
