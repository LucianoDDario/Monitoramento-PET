import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/models/usuario.dart';


class BancoService {
  final FirebaseFirestore _banco = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String mensagemErro = '';

  static final instance = BancoService();

  String? get _uid => _auth.currentUser?.uid;

  Future<void> criarUsuario(Usuario usuario) async{
    try{
      await _banco
      .collection('usuarios')
      .doc(usuario.uid)
      .set(usuario.toMap());
    }catch (e){
      print('Erro ao criar o usuário: $e');
      rethrow;
    }
  } 

  Stream<Usuario?> streamUsuarioLogado(){
    if(_uid == null) return Stream.value(null);

    return _banco.collection('usuarios').doc(_uid).snapshots().map((doc){
      if(doc.exists && doc.data() != null){
        return Usuario.fromMap(doc.data()!);
      }
      return null;
    });
  }
}