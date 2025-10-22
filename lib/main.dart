import 'package:firebase_core/firebase_core.dart';
import 'package:projeto/auth_layout.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/recuperar_senha.dart';
import 'screens/inserir_codigo.dart';
import 'screens/nova_senha.dart';
import 'screens/cadastro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/carregamento',
      home: AuthLayout(),
      routes: {
        '/login': (_) => const TelaLogin(),
        '/recuperar_senha': (_) => RecuperarSenha(),
        '/inserir_codigo': (_) => const InserirCodigo(),
        '/nova_senha': (_) => const NovaSenha(),
        '/cadastro': (_) => TelaCadastro(),
      },
    );
  }
}
