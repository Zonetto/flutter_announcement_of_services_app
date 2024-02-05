import 'package:announcement_of_services/components/dropdown_widget.dart';
import 'package:announcement_of_services/components/request_user_widget.dart';
import 'package:announcement_of_services/components/text_form_field_widget.dart';
import 'package:announcement_of_services/module/request_details_model.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/alert_dialog.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/utils/fill_dropdown_items.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';

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

List<String> wrkingHoursLst = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
];
List<RequestDetailsModel> _requestDetailsList = [];
String? _selectWorkingHours;
final TextEditingController _dateController = TextEditingController();
final TextEditingController _timeController = TextEditingController();
List<DropdownMenuItem<String>>? dropdownItemsWorkingHours;
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
    dropdownItemsWorkingHours = fillDropdownItems(wrkingHoursLst);
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
          //const SizedBox(height: 10),
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
                  onPressedAccepted: () async {
                    _dateController.clear();
                    _timeController.clear();
                    String? date;
                    String? time;
                    await alertDialog(
                      title: ' تاريخ مباشرة العمل للعميل \'${user.fullName}\'',
                      acceptedTitle: 'قبول الطلب',
                      widget: SizedBox(
                        height: Dimensions.screenHeight(context) / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormFieldWidget(
                              context: context,
                              controller: _dateController,
                              headline: 'تاريخ مباشرة العمل',
                              hintText: 'إدخل تاريخ',
                              textInputType: TextInputType.number,
                              readOnly: true,
                              onTab: () async {
                                date = await datePicker(context: context);
                                _dateController.text = date ?? '';
                              },
                              icon: const Icon(Icons.date_range_outlined),
                            ),
                            TextFormFieldWidget(
                              context: context,
                              controller: _timeController,
                              headline: 'وقت مباشرة العمل',
                              hintText: 'إدخل وقت',
                              textInputType: TextInputType.number,
                              readOnly: true,
                              onTab: () async {
                                time = await timePicker(context: context);
                                _timeController.text = time ?? '';
                              },
                              icon: const Icon(Icons.access_time_outlined),
                            ),
                          ],
                        ),
                      ),
                      context: context,
                      onPressed: () {
                        if (_timeController.text.isNotEmpty &&
                            _dateController.text.isNotEmpty) {
                          provider.updateInfoStatuse(
                            doc: requestDetails.requesId!,
                            info: {
                              "status": REQUEST_ACCEPTED,
                              "date": date!,
                              "time": time!,
                            },
                          );
                          styledScaffoldMessenger(
                            context: context,
                            message: 'تم تعين المباشرة بنجاح',
                            color: AppColor.green,
                          );
                          Navigator.pop(context);
                        } else {
                          styledScaffoldMessenger(
                            context: context,
                            message: 'لا يمكن ترك الحقول فارغة',
                            color: AppColor.buttonColorRed,
                          );
                        }
                      },
                    );
                  },
                  onPressedUnaccrpted: () async {
                    await alertDialog(
                      title: 'رفض الطلب',
                      acceptedTitle: 'رفض الطلب',
                      content:
                          'هل انت متأكد من رفض طلب العميل \'${user.fullName}\'',
                      context: context,
                      onPressed: () {
                        provider.updateInfoStatuse(
                          doc: requestDetails.requesId!,
                          info: {
                            "status": REQUEST_UNACCEPTED,
                          },
                        );
                        styledScaffoldMessenger(
                          context: context,
                          message: 'تم رفض الطلب بنجاح',
                          color: AppColor.buttonColorRed,
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  onPressedDone: () async {
                    String? workingHours;
                    _selectWorkingHours = null;
                    await alertDialog(
                      title: 'عدد ساعات العمل للعميل \'${user.fullName}\'',
                      acceptedTitle: 'تم الانتهاء',
                      widget: SizedBox(
                        height: Dimensions.screenHeight(context) / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownStringWidget(
                              hintText: 'عدد ساعات العمل',
                              width: Dimensions.screenWidth(context),
                              context: context,
                              value: _selectWorkingHours,
                              onChanged: (value) {
                                setState(() {
                                  workingHours = value;
                                  _selectWorkingHours = workingHours;
                                });
                                return null;
                              },
                              items: dropdownItemsWorkingHours!,
                            ),
                          ],
                        ),
                      ),
                      context: context,
                      onPressed: () {
                        if (_selectWorkingHours != null) {
                          provider.updateInfoStatuse(
                            doc: requestDetails.requesId!,
                            info: {
                              "status": REQUEST_ACCEPTED,
                              "working_hours": workingHours,
                            },
                          );
                          styledScaffoldMessenger(
                            context: context,
                            message: 'تم الانتهاء من العمل بنجاح',
                            color: AppColor.green,
                          );
                          Navigator.pop(context);
                        } else {
                          styledScaffoldMessenger(
                            context: context,
                            message: 'لا يمكن ترك الحقول فارغة',
                            color: AppColor.buttonColorRed,
                          );
                        }
                      },
                    );
                    provider.updateInfoStatuse(
                        doc: requestDetails.requesId!,
                        info: {
                          "status": REQUEST_DONE,
                        });
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
