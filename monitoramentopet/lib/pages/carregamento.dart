import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaCarregamento extends StatefulWidget {
  const TelaCarregamento({super.key});

  @override
  State<TelaCarregamento> createState() => _TelaCarregamentoState();
}

class _TelaCarregamentoState extends State<TelaCarregamento> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xFFD02670),
        body: Center(
         child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/Dog-walker.svg', width: 159, height: 159),
            SizedBox(height: 8),
            Text('Pets',
            style: TextStyle(
              fontSize: 54,
              color: Colors.white
            ),)
          ],
         )
         
        )
          
        );
  }
}