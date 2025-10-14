import 'package:flutter/material.dart';
class TelaCarregamento extends StatefulWidget {
 const TelaCarregamento({super.key});
 @override
 State<TelaCarregamento> createState() => _TelaCarregamentoState();
}
class _TelaCarregamentoState extends State<TelaCarregamento> {
 @override
 void initState() {
   super.initState();
   Future.delayed(const Duration(seconds: 2), () { 
     if (!mounted) return;
     Navigator.pushReplacementNamed(context, '/login'); 
   });
 }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xFFD02670),
     body: Center(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Image.asset(
             'assets/images/Dog-walker.png',
             width: 159,
             height: 159,
           ),
           const SizedBox(height: 20),
           const Text(
             'Pets',
             style: TextStyle(
               fontSize: 54,
               color: Colors.white,
             ),
           ),
         ],
       ),
     ),
   );
 }
}