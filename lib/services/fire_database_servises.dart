import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireDatabaseServises {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future addInfoDB({String? doc, required Map<String, dynamic> info});
  Future updateInfoDB({
    required String? doc,
    required Map<String, dynamic> info,
  });
  Future getSpecificDB({required String doc});
}
