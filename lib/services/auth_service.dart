import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


final AuthService authService = AuthService();

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> login({
    required String email,
    required String senha,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<UserCredential> criarConta({
    required String email,
    required String senha,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> sair() async {
    await firebaseAuth.signOut();
  }

  Future<void> mudarSenhaEsquecida({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> mudarNome({required String nome}) async {
    await currentUser!.updateDisplayName(nome);
  }

  Future<void> mudarSenhaExistente({
    required String senhaAtual,
    required String novaSenha,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: senhaAtual,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(novaSenha);
  }
}
