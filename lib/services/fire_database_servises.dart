import 'package:announcement_of_services/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabaseServises {
  Future addUserInfoDB(String userId, Map<String, dynamic> userInfo) {
    return FirebaseFirestore.instance
        .collection('user_tbl')
        .doc(userId)
        .set(userInfo);
  }

  Future<UserModel?> getUserFromDB(String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("user_tbl")
        .doc(userId)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      UserModel userModel = UserModel.fromJson(userData!);
      return userModel;
    }
    return null;
  }
}
