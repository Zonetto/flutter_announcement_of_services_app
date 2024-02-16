import 'package:announcement_of_services/components/request_service_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/request_model.dart';
import 'package:announcement_of_services/services/collections/request_collection.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view/lodaing_screen.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestServiceForm extends StatefulWidget {
  final String fullName;
  final String serviceTitle;
  final String imagePath;
  final DocumentReference userid;
  final DocumentReference servicesProviderId;
  final TextEditingController descController;
  final ValidCallback? valid;
  const RequestServiceForm({
    super.key,
    required this.fullName,
    required this.serviceTitle,
    required this.imagePath,
    required this.descController,
    this.valid,
    required this.userid,
    required this.servicesProviderId,
  });

  @override
  State<RequestServiceForm> createState() => _RequestServiceFormState();
}

final GlobalKey<FormState> _requestServiceKey = GlobalKey<FormState>();
final TextEditingController _descController = TextEditingController();
bool _lodaing = false;

class _RequestServiceFormState extends State<RequestServiceForm> {
  @override
  void dispose() {
    _requestServiceKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _requestServiceKey,
      child: Column(
        children: [
          RequestServiceWidget(
            isLoading: false,
            descController: _descController,
            fullName: widget.fullName,
            imagePath: widget.imagePath,
            serviceTitle: widget.serviceTitle,
            // servicesProviderId: widget.servicesProviderId,
            // userid: widget.userid,
            valid: (String? value) {
              return ValidTextForm().emptyText(value);
            },
            onPressedRequest: !_lodaing
                ? () async {
                    if (!_requestServiceKey.currentState!.validate()) {
                      return;
                    }
                    final String title = widget.serviceTitle;
                    _requestServiceKey.currentState!.save();
                    setState(() {
                      _lodaing = true;
                    });
                    RequestCollection requestCollection = RequestCollection();
                    Result result;
                    final DocumentReference servicesProviderId =
                        widget.servicesProviderId;
                    final DocumentReference userId = widget.userid;
                    final DocumentReference requestId =
                        requestCollection.getRequestDocReference();

                    RequestModel requestInfoModel = RequestModel(
                      requestId: requestId.id,
                      userCollectionCollection: userId,
                      serviceProviderCollection: servicesProviderId,
                      desc: _descController.text.trim(),
                      date: '',
                      time: '',
                      requestDate: DateTime.now().toString(),
                    );

                    result = await requestCollection.addInfoDB(
                      doc: requestId.id,
                      info: requestInfoModel.toJson(),
                    );

                    if (result is Success) {
                      _descController.clear();
                      styledScaffoldMessenger(
                        context: context,
                        message: 'تم طلب خدمة $title بنجاح',
                        color: AppColor.green,
                      );
                      setState(() {
                        _lodaing = false;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    if (result is Error) {
                      setState(() {
                        _lodaing = false;
                      });
                      print(result.errorResponse);
                    }
                  }
                : () {},
          ),
          _lodaing
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(title: 'رجاءًا انتظر قليلاً'),
                    SizedBox(width: 10),
                    LoadingScreen(),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
