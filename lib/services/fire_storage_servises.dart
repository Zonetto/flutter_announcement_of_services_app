import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStorageServises {
  Reference? reference;

  init() {
    reference = FirebaseStorage.instanceFor(
      bucket: 'gs://flutterhomeservice-73056.appspot.com',
    ).ref().child('Images').child("${const Uuid().v1()}.png");
  }

  Future<void> upload(File selectedImage) async {
    try {
      UploadTask uploadTask = reference!.putFile(selectedImage);
      await uploadTask;
      print("Upload successful");
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }

  Future<String?> getImageUrl() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      String downloadUrl = await reference!.getDownloadURL();
      print("convertUrl successful");
      print("downloadUrl: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error getting download URL: $e");
      return null;
    }
  }
}
