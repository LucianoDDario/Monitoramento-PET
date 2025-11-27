import 'package:cloud_firestore/cloud_firestore.dart';

class Vacina {
  final String? id;
  final String nome;
  final String veterinario;
  final Timestamp dataAplicacao;
  final Timestamp? proximaData;

  Vacina({
    this.id,
    required this.nome,
    required this.veterinario,
    required this.dataAplicacao,
    this.proximaData,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'veterinario': veterinario,
      'dataAplicacao': dataAplicacao,
      'proximaData': proximaData,
    };
  }

  factory Vacina.fromMap(Map<String, dynamic> map, String id) {
    return Vacina(
      id: id,
      nome: map['nome'] ?? '',
      veterinario: map['veterinario'] ?? '',
      dataAplicacao: map['dataAplicacao'] as Timestamp,
      proximaData: map['proximaData'] as Timestamp?,
    );
  }
}
