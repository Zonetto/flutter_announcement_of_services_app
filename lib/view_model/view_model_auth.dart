import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:announcement_of_services/components/shared/network/local/cache_helper.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_storage_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app_status.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  String? userId;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();
}

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
//  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FireStorageServises fireStorageServises = FireStorageServises();
  bool? get isAuth => token != null;
  http.Response? _res;
  Future<Result> _authenticate({
    required String email,
    required String password,
    UserModel? user,
    required String urlSegment,
    File? photo,
  }) async {
    final fullUrl = "$baseUrl/accounts:$urlSegment?$key";
    try {
      _res = await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      if (_res != null) {
        final Map<String, dynamic> resData = json.decode(_res!.body);
        if (resData['error'] != null) {
          print("${resData['error']['message']}");
          throw "${resData['error']['message']}";
        }
        final String uid = resData['localId'];
        print("5");
        _userId = uid;
        UserManager().userId = uid;
        _expiryDate = DateTime.now()
            .add(Duration(hours: int.parse(resData['expiresIn'])));
        _autoLogout();
        if (urlSegment == "signUp") {
          UserCollection userCollection = UserCollection();
          String? downloadUrl = await fireStorageServises
              .uploadAndGetImageToFirebaseStorage(photo!);
          user!.image = downloadUrl;
          user.userId = _userId;
          user.password = _hashPassword(password);
          await Future.delayed(const Duration(seconds: 1));
          userCollection.addInfoDB(doc: uid, info: user.toJson());
        }
        notifyListeners();
        await CacheHelper.putDataString(key: 'userId', value: _userId);
        await CacheHelper.putDataString(
            key: 'expiryDate', value: _expiryDate!.toIso8601String());
        return Success(code: _res!.statusCode, response: resData);
      } else {
        return Error();
      }
    } catch (e) {
      // return Error();
      UserManager().userId = null;
      // print("${_res!.statusCode}    ${e.toString()}");
      // return Error(code: _res!.statusCode, errorResponse: e.toString());
      //   if (_res != null) {
      // print("${_res!.statusCode}    ${e.toString()}");
      return Error(code: _res!.statusCode, errorResponse: e.toString());
      //}
      // return Error();
    }
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
    UserManager().userId = _userId ?? "";
    _autoLogout();
    notifyListeners();

    return true;
  }

  Future<Result> signUp(
    UserModel authUser,
    File? photo,
  ) async {
    final auth = _authenticate(
      email: authUser.email,
      password: authUser.password,
      user: authUser,
      urlSegment: "signUp",
      photo: photo,
    );
    return auth;
  }

  Future<Result> logIn(AuthModel authUser) async {
    final auth = await _authenticate(
      email: authUser.email,
      password: authUser.password,
      urlSegment: "signInWithPassword",
    );
    return auth;
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
    CacheHelper.sharedPreferences!.clear();
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

String _hashPassword(String password) {
  final Digest sha256Hash = sha256.convert(utf8.encode(password));
  return sha256Hash.toString();
}
