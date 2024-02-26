import 'dart:async';

import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:flutter/material.dart';

import 'view_model_auth.dart';

class ViewModelFetch extends ChangeNotifier {
  String? _doc;
  UserModel? _userDetails;

  ServicesProviderModel? _servicesProviderLst;
  set setServicesProviderLst(ServicesProviderModel? servicesProviderLst) =>
      _servicesProviderLst = servicesProviderLst;

  List<UserDetailsModel> _userAllDetails = [];
  List<UserDetailsModel> _allServiceProviderLst = [];

  UserModel? get getUserDetails => _userDetails;
  List<UserDetailsModel> get getAllUserDetails => _userAllDetails;
  List<UserDetailsModel> get getAllServiceProviderLst => _allServiceProviderLst;
  ServicesProviderModel? get getServicesProviderLst => _servicesProviderLst;

  Future<void> fetchSpecificUserDetailsData() async {
    _doc = UserManager().userId;
    _userDetails = null;
    final UserModel? userData =
        await UserCollection().getSpecificDB(doc: _doc!);
    _userDetails = userData;
    notifyListeners();
  }

  Future<bool> fetchAllUserDetailsData({required String query}) async {
    _userAllDetails.clear();
    final List<UserDetailsModel>? userAllDetails =
        await UserCollection().fetchAllDB(query: query);
    _userAllDetails = userAllDetails ?? [];
    notifyListeners();
    if (_userAllDetails.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<bool> fetchFlitterDetailsData({
    String? queryServiceType,
    String? queryRating,
    String? queryAddress,
    String? queryYearsOfExperience,
  }) async {
    _userAllDetails.clear();
    final List<UserDetailsModel>? userAllDetails =
        await UserCollection().fetchFlitterDB(
      queryServiceType: queryServiceType,
      queryRating: queryRating,
      queryAddress: queryAddress,
      queryYearsOfExperience: queryYearsOfExperience,
    );
    _userAllDetails = userAllDetails ?? [];
    notifyListeners();
    if (_userAllDetails.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> updateRatingDB({
    required String? doc,
    required Map<String, dynamic> info,
  }) async {
    await ServicesProviderCollection().updateRatingDB(doc: doc, info: info);
    notifyListeners();
  }

  Future<void> fetchSpecificServerProviderData() async {
    _doc = UserManager().userId;
    final ServicesProviderModel? servicesProviderLst =
        await ServicesProviderCollection().getSpecificDB(doc: _doc!);
    _servicesProviderLst = servicesProviderLst;
    // fetchSpecificUserDetailsData();
    notifyListeners();
  }

  Future<void> fetchAllServiceProviderData() async {
    _allServiceProviderLst.clear();
    final List<UserDetailsModel>? userAllDetails =
        await UserCollection().getAllServiceProviderData();
    _allServiceProviderLst = userAllDetails ?? [];
    //  print("llll ${_allServiceProviderLst.length}");
    notifyListeners();
  }
}
