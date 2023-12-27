import 'package:cloud_firestore/cloud_firestore.dart';

import 'service_provider_model.dart';

class UserDetailsModel {
  final String userId;
  final int call;
  final String dateOfBirth;
  final String email;
  final String fullName;
  final String profileImage;
  final String isServiceProvider;
  final ServicesProviderModel servicesProviderModel;

  UserDetailsModel({
    required this.userId,
    required this.call,
    required this.dateOfBirth,
    required this.email,
    required this.fullName,
    required this.profileImage,
    required this.isServiceProvider,
    required this.servicesProviderModel,
  });

  factory UserDetailsModel.fromDocumentSnapshot(
    DocumentSnapshot<Object?> snapshot,
  ) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Extract ServicesProviderModel data from the DocumentReference
    DocumentReference servicesProviderRef = data["service_provider_collection"];
    ServicesProviderModel servicesProviderModel =
        ServicesProviderModel.fromDocumentReference1(servicesProviderRef);

    return UserDetailsModel.fromJson(data, servicesProviderModel);
  }

  factory UserDetailsModel.fromJson(
      Map<String, dynamic> json, ServicesProviderModel servicesProviderModel) {
    return UserDetailsModel(
      userId: json["userId"],
      call: json["call"],
      dateOfBirth: json["date_of_birth"],
      email: json["email"],
      fullName: json["full_name"],
      isServiceProvider: json["is_service_provider"],
      profileImage: json["image"],
      servicesProviderModel: servicesProviderModel,
    );
  }
}
