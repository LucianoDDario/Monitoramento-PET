import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;


  Future<String?> uploadFotoPet(File file) async {
    if (_uid == null) return null;

    try {

      String nomeArquivo = DateTime.now().millisecondsSinceEpoch.toString();


      Reference ref = _storage
          .ref()
          .child('pets')
          .child(_uid!)
          .child('$nomeArquivo.jpg');


      UploadTask task = ref.putFile(file);


      await task;


      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print('Erro no upload da imagem: ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro desconhecido no upload: $e');
      return null;
    }
  }
}