import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'service_provider_model.dart';
import 'user_details_model.dart';

class RequestModel {
  String? requestId;
  DocumentReference? serviceProviderCollection;
  DocumentReference? userCollectionCollection;
  final String desc;
  final String date;
  final String time;
  final String? workingHours;
  final String requestDate;
  String? status;

  RequestModel({
    this.requestId,
    this.userCollectionCollection,
    this.serviceProviderCollection,
    required this.date,
    required this.desc,
    required this.time,
    this.workingHours = '0',
    required this.requestDate,
    this.status = REQUEST_WAIT,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestId: json["reques_id"],
      serviceProviderCollection: json["service_provider_doc"],
      userCollectionCollection: json["user_doc"],
      desc: json["desc"],
      date: json["date"],
      time: json["time"],
      workingHours: json["working_hours"],
      requestDate: json["request_date"],
      status: json["status"],
    );
  }
  toJson() {
    return {
      "reques_id": requestId,
      "service_provider_doc": serviceProviderCollection,
      "user_doc": userCollectionCollection,
      "desc": desc,
      "date": date,
      "time": time,
      "working_hours": workingHours,
      "request_date": requestDate,
      "status": status,
    };
  }

  Future<UserDetailsModel?> getServiceProviderModel(
      ServicesProviderModel servicesProviderModel) async {
    if (serviceProviderCollection != null) {
      DocumentSnapshot<Object?> snapshot =
          await serviceProviderCollection!.get();
      if (snapshot.exists) {
        return UserDetailsModel.fromDocumentSnapshot(
            snapshot, servicesProviderModel);
      }
    }
    return null; // Handle the case when serviceProviderCollection is null or document does not exist
  }
}
