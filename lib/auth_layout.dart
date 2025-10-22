import 'package:flutter/material.dart';
import 'package:projeto/screens/carregamento.dart';
import 'package:projeto/screens/home.dart';
import 'package:projeto/screens/login.dart';
import 'package:projeto/services/auth_service.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.paginaNaoConectada});

  final Widget? paginaNaoConectada;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = TelaCarregamento();
            } else if (snapshot.hasData) {
              widget = const Home();
            } else {
              widget = paginaNaoConectada ?? TelaLogin();
            }
            return widget;
          },
        );
      },
    );
  }
}
