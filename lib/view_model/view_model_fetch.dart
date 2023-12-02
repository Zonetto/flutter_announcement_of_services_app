import 'package:announcement_of_services/components/shared/network/local/cache_helper.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:flutter/material.dart';

class ViewModelFetch extends ChangeNotifier {
  UserModel? _userDetails;

  UserModel? get getUserDetails => _userDetails;

  Future<void> fetchUserDetailsData() async {
    final UserModel? userData = await FireDatabaseServises()
        .getUserFromDB(CacheHelper.getDataString(key: 'userId')!);
    _userDetails = userData;
    notifyListeners();
  }
}
