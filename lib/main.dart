import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projeto/auth_layout.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:projeto/screens/alterar_email.dart';
import 'screens/carregamento.dart';
import 'screens/login.dart';
import 'screens/recuperar_senha.dart';
import 'screens/inserir_codigo.dart';
import 'screens/nova_senha.dart';
import 'screens/cadastro.dart';
import 'screens/telainicial.dart';
import 'screens/adiciona_pet.dart';
import 'screens/tela_configuracao.dart';
import 'screens/alterar_nome.dart';
import 'screens/alterar_senha.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pets',
      initialRoute: '/carregamento',
      home: AuthLayout(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      routes: {
        '/carregamento': (_) => const TelaCarregamento(),
        '/login': (_) => const TelaLogin(),
        '/recuperar_senha': (_) => const RecuperarSenha(),
        '/inserir_codigo': (_) => const InserirCodigo(),
        '/nova_senha': (_) => const NovaSenha(),
        '/cadastro': (_) => const TelaCadastro(),
        '/telainicial': (_) => const TelaInicial(),
        '/adiciona_pet': (_) => const TelaCadastroPet(),
        'tela_configuracao': (_) => const TelaConfiguracao(),
        '/alterar_nome': (_) => const TelaAlterarNome(),
        '/alterar_senha': (_) => const TelaAlterarSenha(),
        '/alterar_email': (_) => const TelaAlterarEmail(),
      },
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const TelaInicial()),
    );
  }
}
