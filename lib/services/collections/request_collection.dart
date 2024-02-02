import 'package:announcement_of_services/module/request_details_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_collection.dart';

class RequestCollection extends FireDatabaseServises {
  String? _doc;
  CollectionReference? _newCollection;
  DocumentReference? doc;
  RequestCollection() {
    _newCollection = firestore.collection(CollectionDB.requestCollection);
  }

  @override
  Future addInfoDB({String? doc, required Map<String, dynamic> info}) async {
    Result result = Error();
    await _newCollection!
        .doc(doc!)
        .set(info)
        .whenComplete(() => result = Success());
    return result;
  }

  DocumentReference getRequestDocReference() {
    return _newCollection!.doc(_doc);
  }

  @override
  Future getSpecificDB({required String doc}) {
    throw UnimplementedError();
  }

  @override
  Future updateInfoDB(
      {required String? doc, required Map<String, dynamic> info}) {
    return _newCollection!.doc(doc).update(info);
  }

  Future<List<RequestDetailsModel>> getWithServicesProviderDetails() async {
    try {
      List<RequestDetailsModel> requestDetailsList = [];
      QuerySnapshot requestSnapshot =
          await _newCollection!.orderBy('request_date', descending: true).get();

      for (QueryDocumentSnapshot requestDoc in requestSnapshot.docs) {
        Map<String, dynamic> requestData =
            requestDoc.data() as Map<String, dynamic>;
        DocumentReference serviceProviderId =
            requestData['service_provider_doc'];
        DocumentReference userID = requestData['user_doc'];
        UserDetailsModel? userCollectionDoc =
            await UserCollection().fetchSpecifiDB();
        UserDetailsModel? serviceProviderCollectionDoc =
            await UserCollection().fetchSpecifiDB(doc: serviceProviderId.id);
        RequestDetailsModel requestDetails =
            RequestDetailsModel.fromJsonServiceProvider(
          requestData,
          userCollectionDoc: userCollectionDoc,
          servicesProvider: serviceProviderCollectionDoc,
        );
        if (userID.id == UserManager().userId) {
          requestDetailsList.add(requestDetails);
        }
        // print(requestDetails);
      }

      return requestDetailsList;
    } catch (e) {
      // Handle errors
      print('Error fetching request with user details: $e');
      throw e;
    }
  }

  Future<List<RequestDetailsModel>> getWithUserDetails(
      {bool? isServiceProvider = false}) async {
    try {
      List<RequestDetailsModel> requestDetailsList = [];
      QuerySnapshot requestSnapshot =
          await _newCollection!.orderBy('request_date', descending: true).get();

      for (QueryDocumentSnapshot requestDoc in requestSnapshot.docs) {
        Map<String, dynamic> requestData =
            requestDoc.data() as Map<String, dynamic>;
        DocumentReference serviceProviderId =
            requestData['service_provider_doc'];
        DocumentReference userID = requestData['user_doc'];
        UserDetailsModel? userCollectionDoc =
            await UserCollection().fetchSpecifiDB(doc: userID.id);
        UserDetailsModel? serviceProviderCollectionDoc =
            await UserCollection().fetchSpecifiDB();
        RequestDetailsModel requestDetails =
            RequestDetailsModel.fromJsonServiceProvider(
          requestData,
          userCollectionDoc: userCollectionDoc,
          servicesProvider: serviceProviderCollectionDoc,
        );

        if (serviceProviderId.id == UserManager().userId) {
          requestDetailsList.add(requestDetails);
        }
      }

      return requestDetailsList;
    } catch (e) {
      // Handle errors
      print('Error fetching request with user details: $e');
      throw e;
    }
  }
}
