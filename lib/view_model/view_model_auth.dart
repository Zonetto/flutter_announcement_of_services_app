import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:announcement_of_services/components/shared/network/local/cache_helper.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_storage_servises.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'app_status.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  late String userId;

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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FireStorageServises fireStorageServises = FireStorageServises();
  bool? get isAuth => token != null;
  Response? _res;
  Future<Result> _authenticate({
    required String email,
    required String password,
    UserModel? user,
    required String urlSegment,
    File? photo,
  }) async {
    final fullUrl = "$basUrl/accounts:$urlSegment?$key";

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

      // if (urlSegment == "signInWithPassword") {
      //   firebaseAuth.signInWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );
      // }

      final Map<String, dynamic> resData = json.decode(_res!.body);
      final String uid = resData['localId'];

      //firebaseAuth.currentUser!.uid.toString(); //resData['localId'];

      if (resData['error'] != null) {
        print("${resData['error']['message']}");
        throw "${resData['error']['message']}";
      }
      // _token = resData['email'];
      _userId = uid;
      UserManager().userId = uid;
      _expiryDate =
          DateTime.now().add(Duration(hours: int.parse(resData['expiresIn'])));
      _autoLogout();
      if (urlSegment == "signUp") {
        //  await fireStorageServises.upload(photo!);
        // firebaseAuth.createUserWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );
        String? downloadUrl = await fireStorageServises
            .uploadAndGetImageToFirebaseStorage(photo!);
        user!.image = downloadUrl;
        user.userId = _userId;
        await Future.delayed(const Duration(seconds: 3));
        UserCollection().addInfoDB(doc: uid, info: user.toJson());
      }

      notifyListeners();
      //   await CacheHelper.putDataString(key: 'token', value: _token);
      await CacheHelper.putDataString(key: 'userId', value: _userId);
      await CacheHelper.putDataString(
          key: 'expiryDate', value: _expiryDate!.toIso8601String());
      return Success(code: _res!.statusCode, response: resData);
    } catch (e) {
      return Error(code: _res!.statusCode, errorResponse: e.toString());
      //return false;
      // rethrow;
    }

    // return true;
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
    // print(auth);
    // if (!auth) {
    //   return false;
    // }
    return auth;
  }

  Future<Result> logIn(AuthModel authUser) async {
    // try {
    final auth = await _authenticate(
      email: authUser.email,
      password: authUser.password,
      urlSegment: "signInWithPassword",
    );
    return auth;
    //  } catch (e) {}

    //print(auth);
    // if (!auth) {
    //   return false;
    // }
    // return true;
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
    // final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
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
