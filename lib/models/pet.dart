class Pet {
  final String? id;
  final String uid;
  final String nome;
  final String raca;
  final String? fotoPerfilPetUrl;
  final int idade;
  final String sexo;
  final String especie;
  final String dataNascimento;
  final String castrado;

  Pet({
    this.id,
    required this.uid,
    required this.nome,
    required this.raca,
    this.fotoPerfilPetUrl,
    required this.idade,
    required this.sexo,
    required this.especie,
    required this.dataNascimento,
    required this.castrado
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'raca': raca,
      'fotoPerfilPetUrl': fotoPerfilPetUrl,
      'idade': idade,
      'sexo': sexo,
      'especie': especie,
      'dataNascimento': dataNascimento,
      'castrado': castrado
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map, String id) {
    return Pet(
      id: id,
      uid: map['uid'] as String,
      nome: map['nome'] as String,
      raca: map['raca'] as String,
      fotoPerfilPetUrl: map['fotoPerfilPetUrl'] as String?,
      idade: map['idade'] as int,
      sexo: map['sexo'] as String,
      especie: map['especie'] as String,
      dataNascimento: map['dataNascimento'] as String,
      castrado: map['castrado'] as String
    );
  }
}
