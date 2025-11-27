import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/screens/carregamento.dart';
import 'package:projeto/screens/login.dart';
import 'package:projeto/screens/telainicial.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const TelaCarregamento();
        }

        if (snapshot.hasData) {
          return const TelaInicial();
        }

        return const TelaLogin();
      },
    );
  }
}
