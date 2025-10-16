import 'package:flutter/material.dart';
class Cadastro extends StatelessWidget {
 const Cadastro({super.key});
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xFFD02670),
     body: Center(
       child: Container(
         width: 320,
         height: 540,
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
                 'Cadastro',
                 style: TextStyle(fontSize: 28, color: Colors.black),
               ),
               const SizedBox(height: 8),
               const Text(
                 'Insira suas informações para realizar o cadastro',
                 style: TextStyle(fontSize: 14, color: Color(0xFF525252)),
               ),
               
               const SizedBox(height: 12),

               const Text('Nome completo', style: TextStyle(fontSize: 14, color: Colors.black)),
               const SizedBox(height: 6),
               SizedBox(
                 width: 288,
                 height: 32,
                 child: TextField(
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration(
                     hintText: 'Insira seu nome',
                     isDense: true,
                     filled: true,
                     fillColor: Color(0xFFF5F5F5),
                     border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                   ),
                 ),
               ),
               const SizedBox(height: 16),
               
               const Text('E-mail', style: TextStyle(fontSize: 14, color: Colors.black)),
               const SizedBox(height: 6),
               SizedBox(
                 width: 288,
                 height: 32,
                 child: TextField(
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration(
                     hintText: 'Insira seu e-mail',
                     isDense: true,
                     filled: true,
                     fillColor: Color(0xFFF5F5F5),
                     border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                   ),
                 ),
               ),
               const SizedBox(height: 16),

               const Text('Senha', style: TextStyle(fontSize: 14, color: Colors.black)),
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
                     border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                   ),
                 ),
               ),
               const SizedBox(height: 16),

               const Text('Confirmar senha', style: TextStyle(fontSize: 14, color: Colors.black)),
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
                     border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                   ),
                 ),
               ),
               const SizedBox(height: 25),
               
               Row(
                 children: [
                  
                   SizedBox(
                     width: 139,
                     height: 32,
                     child: OutlinedButton(
                       onPressed: () {
                         Navigator.pop(context); 
                       },
                       style: OutlinedButton.styleFrom(
                         foregroundColor: const Color(0xFFD02670),
                         backgroundColor: Colors.white,
                         side: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.zero,
                         ),
                         padding: EdgeInsets.zero,
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: const [
                           
                           Text('Voltar           '),
                           Icon(Icons.arrow_back, size: 20),
                           SizedBox(width: 20),
                           
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(width: 10),
                   
                   SizedBox(
                     width: 139,
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
                         children: const [
                           Text('Avançar'),
                           SizedBox(width: 30),
                           Icon(Icons.arrow_right_alt, size: 26),
                         ],
                       ),
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