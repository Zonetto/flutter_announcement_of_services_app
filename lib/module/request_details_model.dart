import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';

class RequestDetailsModel {
  String? requesId;
  UserDetailsModel? serviceProviderDoc;
  UserDetailsModel? userCollectionDoc;
  final String desc;
  final String date;
  final String time;
  final String? workingHours;
  final String requestDate;
  String? status;

  RequestDetailsModel({
    this.requesId,
    this.userCollectionDoc,
    this.serviceProviderDoc,
    required this.date,
    required this.desc,
    required this.time,
    this.workingHours,
    required this.requestDate,
    this.status = REQUEST_WAIT,
  });

  factory RequestDetailsModel.fromJsonServiceProvider(
    Map<String, dynamic> json, {
    UserDetailsModel? servicesProvider,
    UserDetailsModel? userCollectionDoc,
  }) {
    return RequestDetailsModel(
      requesId: json["reques_id"],
      serviceProviderDoc: servicesProvider,
      userCollectionDoc: userCollectionDoc,
      desc: json["desc"],
      date: json["date"],
      time: json["time"],
      workingHours: json["working_hours"],
      requestDate: json["request_date"],
      status: json["status"],
    );
  }
}
