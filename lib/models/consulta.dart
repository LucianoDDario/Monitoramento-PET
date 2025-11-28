import 'package:cloud_firestore/cloud_firestore.dart';

class Consulta {
  final String? id;
  final String descricao;
  final DateTime data;
  final String hora;
  final String nomeLocal;
  final String cidade;
  final String bairro;
  final String rua;

  Consulta({
    this.id,
    required this.descricao,
    required this.data,
    required this.hora,
    required this.nomeLocal,
    required this.cidade,
    required this.bairro,
    required this.rua,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'data': Timestamp.fromDate(data),
      'hora': hora,
      'nomeLocal': nomeLocal,
      'cidade': cidade,
      'bairro': bairro,
      'rua': rua,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map, String id) {
    return Consulta(
      id: id,
      descricao: map['descricao'] ?? '',
      data: (map['data'] as Timestamp).toDate(),
      hora: map['hora'] ?? '',
      nomeLocal: map['nomeLocal'] ?? '',
      cidade: map['cidade'] ?? '',
      bairro: map['bairro'] ?? '',
      rua: map['rua'] ?? '',
    );
  }
}
