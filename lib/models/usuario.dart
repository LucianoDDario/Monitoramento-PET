class Usuario {
  final String uid;
  final String nome;
  final String email;
  final String? fotoPerfilUrl;

  Usuario({
    required this.uid,
    required this.nome,
    required this.email,
    this.fotoPerfilUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
      'fotoPerfilUrl': fotoPerfilUrl,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map){
    return Usuario(
    uid: map['uid'] as String, 
    nome: map['nome'] as String, 
    email: map['email'] as String,
    fotoPerfilUrl: map['fotoPerfilUrl'] as String?
    );
  }
}
