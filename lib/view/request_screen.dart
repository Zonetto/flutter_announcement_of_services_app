import 'package:announcement_of_services/components/request_user_widget.dart';
import 'package:announcement_of_services/module/request_details_model.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';

import 'package:announcement_of_services/view_model/view_model_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service_details_screen.dart';

class RequestScreen extends StatefulWidget {
  final bool isServiceProvider;
  const RequestScreen({super.key, this.isServiceProvider = false});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

List<RequestDetailsModel> _requestDetailsList = [];

void initList(BuildContext context, bool isServiceProvider) {
  final watch = context.watch<ViewModelRequest>();
  if (isServiceProvider) {
    _requestDetailsList = watch.getRequestDetails;
  } else {
    _requestDetailsList = watch.getRequestProviderDetails;
  }
}

isServiceProvider(BuildContext context, bool isServiceProvider) {
  final provider = Provider.of<ViewModelRequest>(context, listen: false);
  if (isServiceProvider) {
    provider.fetchWithUserDetails();
  } else {
    provider.fetchWithServicesProviderDetails();
  }
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelRequest>(context, listen: false);
    const String isNotServiceProvider = 'ليس مزود خِدمة';
    final bool isServiceProvider = widget.isServiceProvider;
    initList(context, widget.isServiceProvider);
    return RefreshIndicator(
      onRefresh: () => provider.isServiceProvider(
        isServiceProvider,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _requestDetailsList.length,
              itemBuilder: (context, index) {
                final RequestDetailsModel requestDetails =
                    _requestDetailsList[index];
                final UserDetailsModel? user = isServiceProvider
                    ? requestDetails.userCollectionDoc
                    : requestDetails.serviceProviderDoc;

                final UserDetailsModel? serviceProvider = isServiceProvider
                    ? requestDetails.userCollectionDoc
                    : requestDetails.serviceProviderDoc;

                final ServicesProviderModel? servicesProviderModel =
                    isServiceProvider
                        ? user?.servicesProviderModel
                        : serviceProvider?.servicesProviderModel;

                return RequestUserWidget(
                  userDetailsModel: user!,
                  requestDetailsModel: requestDetails,
                  isServiceProvider: isServiceProvider ? true : false,
                  onPressedAccepted: () {
                    provider.updateInfoStatuse(
                      doc: requestDetails.requesId!,
                      status: REQUEST_ACCEPTED,
                    );
                  },
                  onPressedUnaccrpted: () {
                    provider.updateInfoStatuse(
                      doc: requestDetails.requesId!,
                      status: REQUEST_UNACCEPTED,
                    );
                  },
                  onPressedDone: () {
                    provider.updateInfoStatuse(
                      doc: requestDetails.requesId!,
                      status: REQUEST_DONE,
                    );
                  },
                  onTap: () {
                    navigateToScreen(
                      context: context,
                      screen: ServiceDetailsScreen(
                        call: user.call,
                        isRequest: true,
                        dateOfBirth: user.dateOfBirth,
                        email: user.email,
                        serviceProviderCollection: user.userId,
                        title: servicesProviderModel?.desc,
                        stars: servicesProviderModel?.stars.toString() ??
                            isNotServiceProvider,
                        address: servicesProviderModel?.address ??
                            isNotServiceProvider,
                        startOfWorkingDays:
                            servicesProviderModel?.startOfWorkingDays ??
                                isNotServiceProvider,
                        endOfWorkingDays:
                            servicesProviderModel?.endOfWorkingDays ??
                                isNotServiceProvider,
                        startWorkingHours:
                            servicesProviderModel?.startWorkingHours ??
                                isNotServiceProvider,
                        endWorkingHours:
                            servicesProviderModel?.endWorkingHours ??
                                isNotServiceProvider,
                        fullName: user.fullName,
                        image: user.profileImage,
                        location: servicesProviderModel?.location ??
                            isNotServiceProvider,
                        serviceType: servicesProviderModel?.serviceType ??
                            isNotServiceProvider,
                        servisePrice: servicesProviderModel?.servisePrice ??
                            isNotServiceProvider,
                        yearsOfExperience:
                            servicesProviderModel?.yearsOfExperience ??
                                isNotServiceProvider,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
