import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:monitoramentopet/pages/carregamento.dart';
import 'package:monitoramentopet/pages/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexSansTextTheme()
      ),
      home: const TelaLogin()
    );
  }
}