import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/image_widget.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/components/text_collector_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:flutter/material.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:provider/provider.dart';

import 'advertisement_for_service_screen.dart';

class AdvertisementForServiceInfoScreen extends StatefulWidget {
  const AdvertisementForServiceInfoScreen({super.key});

  @override
  State<AdvertisementForServiceInfoScreen> createState() =>
      SserviceDetailsScreenState();
}

class SserviceDetailsScreenState
    extends State<AdvertisementForServiceInfoScreen> {
  ServicesProviderModel? _servicesProviderModel;

  @override
  Widget build(BuildContext context) {
    try {
      _servicesProviderModel =
          context.watch<ViewModelFetch>().getServicesProviderLst;
    } catch (e) {}

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
            child: ImageWidget(
              imagePathNetwork: _servicesProviderModel?.image,
              width: Dimensions.screenWidth(context),
              height: 120,
              radius: 15,
            ),
          ),
          Container(
            padding: AppSize.nternalMargin,
            width: Dimensions.screenWidth(context),
            //  height: Dimensions.screenHeight(context) - 50,
            decoration: CustomShapeDecoration.shapeDecoration(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextCollectorWidget(
                            title: 'نوع الخِدمة',
                            subTitle: _servicesProviderModel?.serviceType ?? '',
                          ),
                          TextCollectorWidget(
                            title: 'الخبرة',
                            subTitle:
                                _servicesProviderModel?.yearsOfExperience ?? '',
                          ),
                          TextCollectorWidget(
                            title: 'إيام العمل',
                            subTitle:
                                "${_servicesProviderModel?.startOfWorkingDays ?? ''} ${_servicesProviderModel?.endOfWorkingDays ?? ''}",
                          ),
                          TextCollectorWidget(
                            title: 'سعر الخِدمة',
                            subTitle: _servicesProviderModel?.servisePrice
                                    .toString() ??
                                '',
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Expanded(
                      child: Column(
                        children: [
                          TextCollectorWidget(
                            title: 'التقيمات',
                            subTitle:
                                _servicesProviderModel?.stars.toString() ??
                                    '0.0',
                            isStar: true,
                          ),
                          const TextCollectorWidget(
                            title: 'العمر',
                            subTitle: '33',
                          ),
                          TextCollectorWidget(
                            title: 'ساعات العمل',
                            subTitle:
                                "${_servicesProviderModel?.startWorkingHours ?? ''} ${_servicesProviderModel?.endWorkingHours ?? ''}",
                          ),
                          TextCollectorWidget(
                            title: 'الموقع',
                            subTitle: _servicesProviderModel?.location ?? '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  context: context,
                  title: 'تعديل',
                  onPressed: () async {
                    //_servicesProviderModel;
                    // await Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => AdvertisementForServiceScreen(
                    //       servicesProviderModel: _servicesProviderModel,
                    //     ),
                    //   ),
                    //   // (route) => false,
                    // );

                    navigateToScreen(
                      context: context,
                      screen: AdvertisementForServiceScreen(
                        servicesProviderModel: _servicesProviderModel,
                      ),
                    );
                    // print(_servicesProviderModel?.endOfWorkingDays ?? '');
                  },
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
