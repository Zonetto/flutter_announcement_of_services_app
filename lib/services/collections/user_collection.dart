import 'dart:async';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection extends FireDatabaseServises {
  CollectionReference? newCollection;
  UserCollection() {
    newCollection = firestore.collection(CollectionDB.userCollection);
  }
  @override
  Future addInfoDB({String? doc, required Map<String, dynamic> info}) {
    return newCollection!.doc(doc).set(info);
  }

  Stream<UserModel>? stateIsServiceProvider() {
    return firestore
        .collection(CollectionDB.userCollection)
        .doc(UserManager().userId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      UserModel isServiceprovider = UserModel.fromJson(snapshot.data() ?? {});
      return isServiceprovider;
    });
  }

  Stream<List<UserDetailsModel>> getAllServiceProviderData_admin() {
    try {
      StreamController<List<UserDetailsModel>> controller =
          StreamController<List<UserDetailsModel>>();

      firestore.collection(CollectionDB.userCollection).snapshots().listen(
          (QuerySnapshot<Map<String, dynamic>> snapshot) async {
        List<UserDetailsModel> userList = [];

        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in snapshot.docs) {
          Map<String, dynamic>? userData = document.data();

          if (userData.isNotEmpty) {
            UserModel userModel = UserModel.fromJson(userData);
            if (userModel.serviceProviderCollection != null) {
              ServicesProviderModel? servicesProviderModel =
                  await userModel.getServiceProviderModel();
              if (servicesProviderModel != null) {
                UserDetailsModel userDetailsModel =
                    UserDetailsModel.fromJson(userData, servicesProviderModel!);
                userList.add(userDetailsModel);
              }
            }
          }
        }

        controller.add(userList);
      }, onError: (error) {
        print('Firestore error: $error');
        controller.addError(error); // Pass the error through the stream
      });

      return controller.stream;
    } catch (e) {
      print('Unexpected error: $e');
      return const Stream.empty(); // or handle the error accordingly
    }
  }

  Stream<List<UserDetailsModel>> getchAllServiceProviderData() {
    try {
      StreamController<List<UserDetailsModel>> controller =
          StreamController<List<UserDetailsModel>>();

      firestore.collection(CollectionDB.userCollection).snapshots().listen(
          (QuerySnapshot<Map<String, dynamic>> snapshot) async {
        List<UserDetailsModel> userList = [];

        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in snapshot.docs) {
          Map<String, dynamic>? userData = document.data();

          if (userData.isNotEmpty) {
            UserModel userModel = UserModel.fromJson(userData);
            if (userModel.serviceProviderCollection != null) {
              ServicesProviderModel? servicesProviderModel =
                  await userModel.getServiceProviderModel();

              if (userModel.isServiceProvider == serviceProviderAccept) {
                UserDetailsModel userDetailsModel =
                    UserDetailsModel.fromJson(userData, servicesProviderModel!);
                userList.add(userDetailsModel);
              }
            }
          }
        }

        controller.add(userList);
      }, onError: (error) {
        print('Firestore error: $error');
        controller.addError(error); // Pass the error through the stream
      });

      return controller.stream;
    } catch (e) {
      print('Unexpected error: $e');
      return const Stream.empty(); // or handle the error accordingly
    }
  }

  @override
  Future updateInfoDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) {
    return newCollection!.doc(doc).update(info);
  }

  getUserReference() {
    // final String userId = UserManager().userId;
    return newCollection!.doc().toString();
  }

  @override
  Future<UserModel?> getSpecificDB({required String doc}) async {
    print("getFromDB userId $doc");
    try {
      DocumentSnapshot snapshot = await newCollection!.doc(doc).get();
      if (snapshot.exists) {
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;
        UserModel userModel = UserModel.fromJson(userData!);
        return userModel;
      }
      return null;
    } catch (e) {
      print('Firestore error: $e');
      return null; // or handle the error accordingly
    }
  }

  Future<List<UserDetailsModel>?>? fetchAllDB({required String query}) async {
    try {
      QuerySnapshot<Object?> snapshot = await newCollection!.get();

      List<UserDetailsModel> userList = [];

      for (QueryDocumentSnapshot<Object?> document in snapshot.docs) {
        Map<String, dynamic>? userData =
            document.data() as Map<String, dynamic>?;

        if (userData != null) {
          UserModel userModel = UserModel.fromJson(userData);
          if (userModel.serviceProviderCollection != null) {
            ServicesProviderModel? servicesProviderModel =
                await userModel.getServiceProviderModel();
            if (servicesProviderModel!.serviceType.contains(query)) {
              UserDetailsModel userDetailsModel =
                  UserDetailsModel.fromJson(userData, servicesProviderModel);
              userList.add(userDetailsModel);
            }
          }
        }
      }

      return userList;
    } catch (e) {
      print('Firestore error: $e');
      return null; // or handle the error accordingly
    }
  }
}
