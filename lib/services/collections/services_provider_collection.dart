import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
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
  Future addInfoDB({String? doc, required Map<String, dynamic> info}) async {
    _doc = _newCollection!.doc().id;
    return await _newCollection!.doc(_doc!).set(info);
  }

  DocumentReference getServiceProviderDocReference() {
    return _newCollection!.doc(_doc);
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
  Future updateInfoDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) async {
    return _newCollection!.doc(doc).update(info);
  }
}
