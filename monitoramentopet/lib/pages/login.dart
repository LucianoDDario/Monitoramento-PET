import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
 State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final email = TextEditingController();
  final senha = TextEditingController();
  bool carregando = false;
  
  @override
 
  void dispose() {
   email.dispose();
   senha.dispose();
   super.dispose();
 }
 @override
Widget build(BuildContext context) {
 return Scaffold(
   body: Center(
     child: Padding(
       padding: const EdgeInsets.all(20),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           const Text(
             'Login',
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.bold,
             ),
           ),
           const SizedBox(height: 16),
           TextField(
             controller: email,
             decoration: const InputDecoration(
               labelText: 'E-mail',
             ),
           ),
           const SizedBox(height: 12),
           TextField(
             controller: senha,
             obscureText: true,
             decoration: const InputDecoration(
               labelText: 'Senha',
             ),
           ),
           const SizedBox(height: 20),
           ElevatedButton(
             onPressed: carregando
                 ? null
                 : () {
                     setState(() => carregando = true);
                     Future.delayed(const Duration(seconds: 800), () {
                       if (mounted) setState(() => carregando = false);
                     });
                   },
             child: carregando
                 ? const SizedBox(
                     width: 20,
                     height: 20,
                     child: CircularProgressIndicator(strokeWidth: 2),
                   )
                 : const Text('Entrar'),
           ),
         ],
       ),
      ),
    ),
  );
 }
}