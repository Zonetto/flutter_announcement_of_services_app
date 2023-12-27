// import 'package:announcement_of_services/module/user_model.dart';
// import 'package:announcement_of_services/services/collections/user_collection.dart';
// import 'package:flutter/material.dart';

// import 'view_model_auth.dart';

// class ViewModelFetch extends ChangeNotifier {
//   UserModel? _userDetails;

//   UserModel? get getUserDetails => _userDetails;

//   Future<void> fetchUserDetailsData() async {
//     String userId = UserManager().userId;
//     // if (userId != null) {
//     final UserModel? userData =
//         await UserCollection().getSpecificDB(doc: userId);
//     _userDetails = userData;
//     // print("fetchUserDetailsData ${userData!.serviceProviderCollection!.get()}");
//     notifyListeners();
//     // }
//   }
// }
