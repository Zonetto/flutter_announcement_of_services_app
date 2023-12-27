import 'package:announcement_of_services/module/post_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCollection extends FireDatabaseServises {
  CollectionReference? newCollection;
  PostCollection() {
    newCollection = firestore.collection(CollectionDB.postCollection);
  }
  @override
  Future addInfoDB({String? doc, required Map<String, dynamic> info}) {
    return firestore
        .collection(CollectionDB.servicesProviderCollection)
        .doc(doc)
        .collection(CollectionDB.postCollection)
        .add(info);
  }

  @override
  Future updateInfoDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) {
    return newCollection!.doc(doc).update(info);
  }

  getUserReference() {
    return newCollection!.doc().set({}).toString();
  }

  @override
  Future<PostModel?> getSpecificDB({required String doc}) async {
    DocumentSnapshot snapshot = await newCollection!.doc(doc).get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      PostModel userModel = PostModel.fromJson(userData!);
      return userModel;
    }
    return null;
  }
}
