import 'package:cloud_firestore/cloud_firestore.dart';

import 'service_provider_model.dart';

class UserModel {
  String? userId;
  String? role;
  DocumentReference? serviceProviderCollection;
  final int call;
  final String dateOfBirth;
  final String email;
  String password;
  final String fullName;
  String? image;
  final String isServiceProvider;

  UserModel({
    this.userId,
    this.role,
    this.serviceProviderCollection,
    required this.call,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    required this.fullName,
    this.image,
    required this.isServiceProvider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      role: json["role"],
      serviceProviderCollection: json["service_provider_collection"],
      call: json["call"],
      dateOfBirth: json["date_of_birth"],
      email: json["email"],
      password: json["password"],
      fullName: json["full_name"],
      image: json["image"],
      isServiceProvider: json["is_service_provider"],
    );
  }
  toJson() {
    return {
      "userId": userId,
      "role": role,
      "service_provider_collection": serviceProviderCollection,
      "call": call,
      "date_of_birth": dateOfBirth,
      "email": email,
      "password": password,
      "full_name": fullName,
      "image": image,
      "is_service_provider": isServiceProvider,
    };
  }

  Future<ServicesProviderModel?> getServiceProviderModel() async {
    if (serviceProviderCollection != null) {
      DocumentSnapshot<Object?> snapshot =
          await serviceProviderCollection!.get();
      if (snapshot.exists) {
        return ServicesProviderModel.fromDocumentSnapshot(snapshot);
      }
    }
    return null; // Handle the case when serviceProviderCollection is null or document does not exist
  }
}
