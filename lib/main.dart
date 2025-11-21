import 'package:flutter/material.dart';
import 'screens/carregamento.dart';
import 'screens/login.dart';
import 'screens/recuperar_senha.dart';
import 'screens/inserir_codigo.dart';
import 'screens/nova_senha.dart';
import 'screens/cadastro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/nova_senha',
      routes: {
        '/carregamento': (_) => const TelaCarregamento(),
        '/login': (_) => const TelaLogin(),
        '/recuperar_senha': (_) => const RecuperarSenha(),
        '/inserir_codigo': (_) => const InserirCodigo(),
        '/nova_senha': (_) => const NovaSenha(),
        '/cadastro': (_) => const Cadastro(),
      },
    );
  }
}
