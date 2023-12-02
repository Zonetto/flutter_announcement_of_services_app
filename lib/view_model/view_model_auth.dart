import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:announcement_of_services/components/shared/network/local/cache_helper.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/services/fire_storage_servises.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class Token {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? get getUserId => _userId;
  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
}

class ViewModelAuth extends Token with ChangeNotifier {
  Timer? _authTimer;
  bool isLoad = true;

  UserModel? _userDetails;

  UserModel? get getUserDetails => _userDetails;
  FireStorageServises fireStorageServises = FireStorageServises();
  bool? get isAuth => token != null;

  Future<bool> _authenticate({
    required String email,
    required String password,
    UserModel? user,
    required String urlSegment,
    File? photo,
  }) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAte23mrZFcs16b_FufGlGesH_TCP7zPBc";

    try {
      var res = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final Map<String, dynamic> resData = json.decode(res.body);
      if (resData['error'] != null) {
        print("${resData['error']['message']}");
        throw "${resData['error']['message']}";
      }
      _token = resData['email'];
      _userId = resData['localId'];
      _expiryDate =
          DateTime.now().add(Duration(hours: int.parse(resData['expiresIn'])));
      _autoLogout();
      if (urlSegment == "signUp") {
        fireStorageServises.init();
        fireStorageServises.upload(photo!);
        String? downloadUrl = await fireStorageServises.getImageUrl();

        user!.image = downloadUrl;
        user.userId = resData['localId'];
        FireDatabaseServises().addUserInfoDB(_userId!, user.toJson());
      }

      notifyListeners();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: const Duration(seconds: 5),
      //     backgroundColor: AppColor.colorTextButtonGreen,
      //     content: Text(
      //       "You are logged in with an account: $_token",
      //       textAlign: TextAlign.center,
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontSize: 14.0,
      //       ),
      //     ),
      //   ),
      // );

      // CacheHelper.init();
      await CacheHelper.putDataString(key: 'token', value: _token);
      await CacheHelper.putDataString(key: 'userId', value: _userId);
      await CacheHelper.putDataString(
          key: 'expiryDate', value: _expiryDate!.toIso8601String());
    } catch (e) {
      return false;
      // rethrow;
    }
    return true;
  }

  Future<bool> tryAuthLogin() async {
    await CacheHelper.init();
    final String? expiryDateString =
        CacheHelper.getDataString(key: 'expiryDate');

    if (expiryDateString == null) {
      return false;
    }

    final DateTime expiryDate = DateTime.parse(expiryDateString);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _expiryDate = expiryDate;
    _token = CacheHelper.getDataString(key: 'token') ?? "";
    _userId = CacheHelper.getDataString(key: 'userId') ?? "";
    _autoLogout();
    notifyListeners();

    return true;
  }

  Future<bool> signUp(
    UserModel authUser,
    File? photo,
  ) async {
    final bool auth = await _authenticate(
      email: authUser.email,
      password: authUser.password,
      user: authUser,
      urlSegment: "signUp",
      photo: photo,
    );
    print(auth);
    if (!auth) {
      return false;
    }
    return true;
  }

  Future<bool> logIn(AuthModel authUser) async {
    final bool auth = await _authenticate(
      email: authUser.email,
      password: authUser.password,
      urlSegment: "signInWithPassword",
    );
    print(auth);
    if (!auth) {
      return false;
    }
    return true;
  }

  void logOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer =
        Timer(Duration(hours: timeToExpiry), logOut); // 2400 = 100 days
  }
}
