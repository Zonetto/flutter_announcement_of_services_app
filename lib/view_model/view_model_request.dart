import 'package:announcement_of_services/module/request_details_model.dart';
import 'package:announcement_of_services/services/collections/request_collection.dart';
import 'package:flutter/material.dart';

class ViewModelRequest extends ChangeNotifier {
  final RequestCollection _requestCollection = RequestCollection();
  List<RequestDetailsModel> _requestDetails = [];
  List<RequestDetailsModel> get getRequestDetails => _requestDetails;
  List<RequestDetailsModel> _requestProviderDetails = [];
  List<RequestDetailsModel> get getRequestProviderDetails =>
      _requestProviderDetails;

  Future<void> updateInfoStatuse({
    required String doc,
    required String status,
  }) async {
    _requestCollection.updateInfoDB(doc: doc, info: {"status": status});
    fetchWithUserDetails();
  }

  Future<void> fetchWithUserDetails() async {
    final List<RequestDetailsModel> requestDetailsList;
    requestDetailsList = await _requestCollection.getWithUserDetails();
    _requestDetails = requestDetailsList;
    notifyListeners();
  }

  Future<void> fetchWithServicesProviderDetails() async {
    final List<RequestDetailsModel> requestProviderDetails;
    requestProviderDetails =
        await _requestCollection.getWithServicesProviderDetails();
    _requestProviderDetails = requestProviderDetails;
    notifyListeners();
  }

  Future<void> isServiceProvider(bool isServiceProvider) async {
    if (isServiceProvider) {
      fetchWithUserDetails();
    } else {
      fetchWithServicesProviderDetails();
    }
    notifyListeners();
  }
}
