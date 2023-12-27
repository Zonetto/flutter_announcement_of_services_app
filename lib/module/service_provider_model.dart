import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesProviderModel {
  final String? serviceProviderId;
  final String desc;
  final String serviceType;
  final String yearsOfExperience;
  final String startOfWorkingDays;
  final String endOfWorkingDays;
  final String startWorkingHours;
  final String endWorkingHours;
  final String servisePrice;
  final String address;
  final String location;
  final int stars;
  final String? image;

  ServicesProviderModel({
    this.serviceProviderId,
    required this.desc,
    required this.serviceType,
    required this.yearsOfExperience,
    required this.startOfWorkingDays,
    required this.endOfWorkingDays,
    required this.startWorkingHours,
    required this.endWorkingHours,
    required this.servisePrice,
    required this.address,
    required this.location,
    required this.stars,
    this.image,
  });

  factory ServicesProviderModel.fromDocumentSnapshot(
      DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ServicesProviderModel.fromJson(data);
  }

  factory ServicesProviderModel.fromJson(Map<String, dynamic> json) {
    return ServicesProviderModel(
      serviceProviderId: json['serviceProviderId'],
      desc: json['desc'],
      serviceType: json['serviceType'],
      yearsOfExperience: json['yearsOfExperience'],
      startOfWorkingDays: json['startOfWorkingDays'],
      endOfWorkingDays: json['endOfWorkingDays'],
      startWorkingHours: json['startWorkingHours'],
      endWorkingHours: json['endWorkingHours'],
      servisePrice: json['servisePrice'],
      address: json['address'],
      location: json['location'],
      stars: json['stars'],
      image: json['image'],
    );
  }

  toJson() {
    return {
      "serviceProviderId": serviceProviderId,
      "desc": desc,
      "serviceType": serviceType,
      "yearsOfExperience": yearsOfExperience,
      "startOfWorkingDays": startOfWorkingDays,
      "endOfWorkingDays": endOfWorkingDays,
      "startWorkingHours": startWorkingHours,
      "endWorkingHours": endWorkingHours,
      "servisePrice": servisePrice,
      "address": address,
      "location": location,
      "stars": stars,
      "image": image,
    };
  }

  factory ServicesProviderModel.fromDocumentReference1(
      DocumentReference servicesProviderRef) {
    // Fetch the data from the DocumentReference and construct ServicesProviderModel
    // You can use get() or snapToFuture depending on your Flutter and Firebase versions
    // Example using get():
    return ServicesProviderModel.fromJson(
      servicesProviderRef.get() as Map<String, dynamic>,
    );
  }
}
