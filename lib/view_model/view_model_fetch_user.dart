import 'dart:async';

import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:flutter/material.dart';

import 'view_model_auth.dart';

class ViewModelFetch extends ChangeNotifier {
  final String _doc = UserManager().userId;
  UserModel? _userDetails;
  ServicesProviderModel? _servicesProviderLst;
  List<UserDetailsModel> _userAllDetails = [];

  UserModel? get getUserDetails => _userDetails;
  List<UserDetailsModel> get getAllUserDetails => _userAllDetails;
  ServicesProviderModel? get getServicesProviderLst => _servicesProviderLst;

  Future<void> fetchSpecificUserDetailsData() async {
    _userDetails ??= null;
    final UserModel? userData = await UserCollection().getSpecificDB(doc: _doc);
    _userDetails = userData;
    notifyListeners();
  }

  Future<void> fetchAllUserDetailsData({String? query}) async {
    final List<UserDetailsModel>? userAllDetails =
        await UserCollection().fetchAllDB(query: 'بناء');
    _userAllDetails = userAllDetails ?? [];
    notifyListeners();
  }

  Future<void> fetchSpecificServerProviderData() async {
    final ServicesProviderModel? servicesProviderLst =
        await ServicesProviderCollection().getSpecificDB(doc: _doc);
    _servicesProviderLst = servicesProviderLst;
    notifyListeners();
  }
}
