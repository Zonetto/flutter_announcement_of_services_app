import 'package:announcement_of_services/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRepository {
 final _db = FirebaseFirestore.instance;
  Future<bool> createUser1(UserModel userModel) async {
    bool success = false;
    final doc = FirebaseFirestore.instance.collection('user_tbl').doc('ahhh-3');
    // success = true;
    // success = false;
    await doc.set(userModel.toJson()).whenComplete(
      () {
        const SnackBar(
          content: Text('success'),
        );

        success = true;
      },
    ).catchError((error, stackTrace) {
      const SnackBar(
        content: Text('failure'),
      );
      success = false;
      print(error);
    });

    return success;
  }

  Future<bool> createUser(UserModel userModel) async {
    bool success = false;
    await _db.collection('user_tbl').add(userModel.toJson()).whenComplete(
      () {
        const SnackBar(
          content: Text('success'),
        );

        success = true;
      },
    ).catchError((error, stackTrace) {
      const SnackBar(
        content: Text('failure'),
      );
      success = false;
      print(error);
    });
    return success;
  }
}
