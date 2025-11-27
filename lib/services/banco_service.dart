import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/usuario.dart';
import 'package:projeto/models/vacina.dart';

final BancoService bancoService = BancoService();

class BancoService {
  final FirebaseFirestore _banco = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String mensagemErro = '';

  String? get _uid => _auth.currentUser?.uid;

  Future<void> criarUsuario(Usuario usuario) async {
    try {
      await _banco.collection('usuarios').doc(usuario.uid).set(usuario.toMap());
    } catch (e) {
      print('Erro ao criar o usuário: $e');
      rethrow;
    }
  }

  Stream<Usuario?> streamUsuarioLogado() {
    if (_uid == null) return Stream.value(null);

    return _banco.collection('usuarios').doc(_uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return Usuario.fromMap(doc.data()!);
      }
      return null;
    });
  }

  Future<void> cadastrarPet(Pet pet) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .add(pet.toMap());
    } catch (e) {
      print('Erro ao criar o pet: $e');
      rethrow;
    }
  }

  Stream<List<Pet>> getPetsDoUsuario(String uid) {
    return _banco
        .collection('usuarios')
        .doc(uid)
        .collection('pets')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Pet.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> deletarPet(String idPet) async {
    await _banco
        .collection('usuarios')
        .doc(_uid)
        .collection('pets')
        .doc(idPet)
        .delete();
  }

  Future<void> editarPet(Pet pet) async {
    await _banco
        .collection('usuarios')
        .doc(_uid)
        .collection('pets')
        .doc(pet.id)
        .update(pet.toMap());
  }

  Future<void> cadastrarVacina(String petId, Vacina vacina) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(petId)
          .collection('vacinas')
          .add(vacina.toMap());
    } catch (e) {
      print('Erro ao cadastrar vacina: $e');
      rethrow;
    }
  }

  Stream<List<Vacina>> getVacinasDoPet(String petId) {
    return _banco
        .collection('usuarios')
        .doc(_uid)
        .collection('pets')
        .doc(petId)
        .collection('vacinas')
        .orderBy('dataAplicacao', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Vacina.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> editarVacina(String petId, Vacina vacina) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(petId)
          .collection('vacinas')
          .doc(vacina.id)
          .update(vacina.toMap());
    } catch (e) {
      print('Erro ao editar vacina: $e');
      rethrow;
    }
  }

  Future<void> deletarVacina(String petId, String vacinaId) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(petId)
          .collection('vacinas')
          .doc(vacinaId)
          .delete();
    } catch (e) {
      print('Erro ao deletar vacina: $e');
      rethrow;
    }
  }
}
