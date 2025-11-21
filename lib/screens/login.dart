import 'package:flutter/material.dart';
class TelaLogin extends StatefulWidget {
 const TelaLogin({super.key});
 @override
 State<TelaLogin> createState() => _TelaLoginState();
}
        class _TelaLoginState extends State<TelaLogin> {
 TextEditingController get _emailController => TextEditingController();
 final _senhaController = TextEditingController();
 bool _obscure = true;
  @override
 void dispose() {
   _emailController.dispose();
   _senhaController.dispose();
   super.dispose();
 }
  @override
 Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: const Color(0xFFD02670),
    body: Center(
    child: Container(
    width: 320,
    height: 434,
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
                 'Login',
                 style: TextStyle(fontSize: 28, color: Colors.black),
               ),
               const SizedBox(height: 8),
               const Text(
                 'Insira suas credenciais para realizar o login',
                 style: TextStyle(fontSize: 14, color: Color(0xFF525252)),
               ),
               const SizedBox(height: 12),
              
               const Text('E-mail',
                   style: TextStyle(fontSize: 14, color: Colors.black)),
               const SizedBox(height: 6),
               SizedBox(
                 width: 288,
                 height: 32,
                 child: TextField(
                   controller: _emailController,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration(
                     hintText: 'Insira seu e-mail',
                     isDense: true,
                     filled: true,
                     fillColor: Color(0xFFF5F5F5),
                     border:
                         OutlineInputBorder(borderRadius: BorderRadius.zero),
                     contentPadding:
                         EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                   ),
                 ),
               ),
               const SizedBox(height: 12),
               
               const Text('Senha',
                   style: TextStyle(fontSize: 14, color: Colors.black)),
               const SizedBox(height: 6),
               SizedBox(
                 width: 288,
                 height: 32,
                 child: TextField(
                 controller: _senhaController,
                 obscureText: _obscure,
                 decoration: InputDecoration(
                 hintText: 'Insira sua senha',
                 isDense: true,
                 filled: true,
                 fillColor: const Color(0xFFF5F5F5),
                  border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero),
                  contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 6),
                  suffixIconConstraints:
                    const BoxConstraints(minHeight: 32, minWidth: 32),
                  suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => setState(() {
                     _obscure = !_obscure; 
                          }),
                      icon: Icon(
                     _obscure
                          ? Icons.visibility_off 
                          : Icons.visibility,     
                          size: 18,
                         ),
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
                       Text('Entrar'),
                       SizedBox(width: 6),
                       Icon(Icons.arrow_right_alt, size: 18),
                     ],
                   ),
                 ),
               ),
               const SizedBox(height: 1),
               
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   TextButton(
                     onPressed: () {
                       Navigator.pushNamed(context, '/cadastro');
                     },
                       style: TextButton.styleFrom(
                       padding: EdgeInsets.zero,
                       alignment: Alignment.centerLeft,
                       foregroundColor: const Color(0xFFD02670),
                     ),
                     child: const Text(
                       'Cadastre-se',
                       style: TextStyle(fontSize: 16),
                     ),
                   ),
                   TextButton(
                     onPressed: () {
                       Navigator.pushNamed(context, '/recuperar_senha');
                     },
                       style: TextButton.styleFrom(
                       padding: EdgeInsets.zero,
                       alignment: Alignment.centerLeft,
                       foregroundColor: const Color(0xFFD02670),
                     ),
                     child: const Text(
                       'Esqueceu sua senha?',
                       style: TextStyle(fontSize: 16),
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