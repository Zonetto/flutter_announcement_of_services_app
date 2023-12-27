import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text_collector.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:provider/provider.dart';

class AdvertisementForServiceInfoViewScreen extends StatefulWidget {
  const AdvertisementForServiceInfoViewScreen({super.key});

  @override
  State<AdvertisementForServiceInfoViewScreen> createState() =>
      SserviceDetailsScreenState();
}

class SserviceDetailsScreenState
    extends State<AdvertisementForServiceInfoViewScreen> {
  @override
  void initState() {
    Provider.of<ViewModelFetch>(context, listen: false)
        .fetchSpecificServerProviderData();
    super.initState();
  }

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
            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
            child: CustomImage(
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
            decoration: CustomShapeDecoration.shapeDecoration,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextCollector(
                            title: 'نوع الخِدمة',
                            subTitle: _servicesProviderModel?.serviceType ?? '',
                          ),
                          CustomTextCollector(
                            title: 'الخبرة',
                            subTitle:
                                _servicesProviderModel?.yearsOfExperience ?? '',
                          ),
                          CustomTextCollector(
                            title: 'إيام العمل',
                            subTitle:
                                "${_servicesProviderModel?.startOfWorkingDays ?? ''} ${_servicesProviderModel?.endOfWorkingDays ?? ''}",
                          ),
                          CustomTextCollector(
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
                          const CustomTextCollector(
                            title: 'التقيمات',
                            subTitle: '4.5',
                            isStar: true,
                          ),
                          const CustomTextCollector(
                            title: 'العمر',
                            subTitle: '33',
                          ),
                          CustomTextCollector(
                            title: 'ساعات العمل',
                            subTitle:
                                "${_servicesProviderModel?.startWorkingHours ?? ''} ${_servicesProviderModel?.endWorkingHours ?? ''}",
                          ),
                          CustomTextCollector(
                            title: 'الموقع',
                            subTitle: _servicesProviderModel?.location ?? '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  context: context,
                  title: 'تعديل',
                  onPressed: () async {
                    //_servicesProviderModel;
                    print(_servicesProviderModel?.endOfWorkingDays ?? '');
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
