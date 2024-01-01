import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesProviderCollection extends FireDatabaseServises {
  String? _doc;
  CollectionReference? _newCollection;

  DocumentReference? doc;
  ServicesProviderCollection() {
    _newCollection =
        firestore.collection(CollectionDB.servicesProviderCollection);
  }

  @override
  Future<Result> addInfoDB(
      {String? doc, required Map<String, dynamic> info}) async {
    Result result = Error();
    await _newCollection!
        .doc(doc!)
        .set(info)
        .whenComplete(() => result = Success());
    return result;
  }

  DocumentReference getServiceProviderDocReference() {
    return _newCollection!.doc(_doc);
  }

  Future updateRatingDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) {
    return _newCollection!.doc(doc).update(info);
  }

  @override
  Future<ServicesProviderModel?> getSpecificDB({required String doc}) async {
    try {
      UserModel? userModel = await UserCollection().getSpecificDB(doc: doc);
      if (userModel != null) {
        ServicesProviderModel? servicesProviderModel =
            await userModel.getServiceProviderModel();
        return servicesProviderModel!;
      }
      return null;
    } catch (e) {
      print('Firestore error: $e');
    }
    return null;
  }

  @override
  Future<Result> updateInfoDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) async {
    Result result = Error();
    await _newCollection!
        .doc(doc)
        .update(info)
        .whenComplete(() => result = Success());
    return result;
  }
}
