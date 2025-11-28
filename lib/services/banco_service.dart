import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/models/consulta.dart';
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
        .map((snapshot) {
      final pets = <Pet>[];
      for (final doc in snapshot.docs) {
        try {
          pets.add(Pet.fromMap(doc.data(), doc.id));
        } catch (e) {
          print('Erro ao fazer o parse do pet ${doc.id}: $e');
        }
      }
      return pets;
    });
  }

  Future<void> deletarPet(String idPet) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(idPet)
          .delete();
    } catch (e) {
      print('Erro ao deletar o pet: $e');
      rethrow;
    }
  }

  Future<void> editarPet(Pet pet) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(pet.id)
          .update(pet.toMap());
    } catch (e) {
      print('Erro ao editar o pet: $e');
      rethrow;
    }
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
    if (_uid == null) {
      return Stream.value([]);
    }
    return _banco
        .collection('usuarios')
        .doc(_uid)
        .collection('pets')
        .doc(petId)
        .collection('vacinas')
        .orderBy('dataAplicacao', descending: true)
        .snapshots()
        .map((snapshot) {
      final vacinas = <Vacina>[];
      for (final doc in snapshot.docs) {
        try {
          vacinas.add(Vacina.fromMap(doc.data(), doc.id));
        } catch (e) {
          print('Erro ao fazer o parse da vacina ${doc.id}: $e');
        }
      }
      return vacinas;
    });
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

  Future<void> cadastrarConsulta(String petId, Consulta consulta) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(petId)
          .collection('consultas')
          .add(consulta.toMap());
    } catch (e) {
      print('Erro ao cadastrar consulta: $e');
      rethrow;
    }
  }

  Stream<List<Consulta>> getConsultasDoPet(String petId) {
    if (_uid == null) {
      return Stream.value([]);
    }
    return _banco
        .collection('usuarios')
        .doc(_uid)
        .collection('pets')
        .doc(petId)
        .collection('consultas')
        .orderBy('data', descending: true)
        .snapshots()
        .map((snapshot) {
      final consultas = <Consulta>[];
      for (final doc in snapshot.docs) {
        try {
          consultas.add(Consulta.fromMap(doc.data(), doc.id));
        } catch (e) {
          print('Erro ao fazer o parse da consulta ${doc.id}: $e');
        }
      }
      return consultas;
    });
  }

  Future<void> deletarConsulta(String petId, String consultaId) async {
    try {
      await _banco
          .collection('usuarios')
          .doc(_uid)
          .collection('pets')
          .doc(petId)
          .collection('consultas')
          .doc(consultaId)
          .delete();
    } catch (e) {
      print('Erro ao deletar consulta: $e');
      rethrow;
    }
  }
}
