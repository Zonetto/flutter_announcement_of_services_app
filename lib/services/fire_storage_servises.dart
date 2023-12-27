import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

String _bucket = 'gs://flutterhomeservice-73056.appspot.com';

class FireStorageServises {
  Reference? _referenceRoot;
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instanceFor(bucket: _bucket);

  final Uuid _uid = const Uuid();

  FireStorageServises() {
    _referenceRoot =
        _firebaseStorage.ref().child('Images').child("${_uid.v1()}.png");
  }
  init() {}

  Future<void> upload(File selectedImage) async {
    try {
      UploadTask uploadTask = _referenceRoot!.putFile(selectedImage);
      await uploadTask;
      print("Upload successful");
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }

  Future<String?> getImageUrl() async {
    // await Future.delayed(const Duration(seconds: 3));
    try {
      String downloadUrl = await _referenceRoot!.getDownloadURL();
      print("convertUrl successful");
      print("downloadUrl: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error getting download URL: $e");
      return null;
    }
  }

  Future<String?> uploadAndGetImageToFirebaseStorage(File selectedImage) async {
    await upload(selectedImage);
    await Future.delayed(const Duration(seconds: 2));
    return getImageUrl();
  }
}
