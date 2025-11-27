import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final StorageService storageService = StorageService();

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<String?> uploadFotoPet(File file) async {
    if (_uid == null) return null;

    try {
      String nomeArquivo = DateTime.now().millisecondsSinceEpoch.toString();

      Reference ref = _storage.ref().child('pets').child(_uid!).child('$nomeArquivo.jpg');

      UploadTask task = ref.putFile(file);
      await task;
      return await ref.getDownloadURL();
    } catch (e) {
      print('Erro no upload da imagem: $e');
      rethrow;
    }
  }

  Future<List<String>> uploadFotosGaleria(
      List<XFile> files, String petId) async {
    if (_uid == null) return [];

    List<String> downloadUrls = [];

    try {
      for (var file in files) {
        String nomeArquivo = DateTime.now().millisecondsSinceEpoch.toString();
        

        Reference ref = _storage
            .ref()
            .child('pets')
            .child(_uid!)
            .child(petId)
            .child('gallery')
            .child('$nomeArquivo.jpg');

        UploadTask task = ref.putFile(File(file.path));
        await task;
        final url = await ref.getDownloadURL();
        downloadUrls.add(url);
      }
      return downloadUrls;
    } catch (e) {
      print('Erro no upload das imagens da galeria: $e');
      rethrow;
    }
  }

  Future<void> deletarFotoPorUrl(String url) async {
    if (url.isEmpty) return;
    try {
      await _storage.refFromURL(url).delete();
    } catch (e) {
      print('Erro ao deletar foto: $e');
      // Não propaga o erro para não impedir a exclusão de outras fotos
    }
  }
}
