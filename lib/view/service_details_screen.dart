import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_collector.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final int call;
  final String dateOfBirth;
  final String email;
  final String fullName;
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
  final String image;
  const ServiceDetailsScreen({
    super.key,
    required this.call,
    required this.dateOfBirth,
    required this.email,
    required this.fullName,
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
    required this.image,
  });

  @override
  State<ServiceDetailsScreen> createState() => SserviceDetailsScreenState();
}

class SserviceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSize.padding,
          child: Container(
            padding: AppSize.nternalMargin,
            //height: 250,
            // margin: const EdgeInsets.only(bottom: 24.0),
            width: Dimensions.screenWidth(context),
            height: Dimensions.screenHeight(context),
            decoration: CustomShapeDecoration.shapeDecoration,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // direction: Axis.vertical,
                        children: [
                          CustomTextCollector(
                            title: 'البريد الإلكتروني',
                            subTitle: widget.email,
                          ),
                          CustomTextCollector(
                            title: 'رقم الهاتف',
                            subTitle: widget.call.toString(),
                          ),
                        ],
                      ),
                    ),
                    //const Spacer(),
                    Column(
                      children: [
                        CustomImage(
                          imagePathNetwork: widget.image,
                          height: AppSize.imageSizeLarg(context),
                          width: AppSize.imageSizeLarg(context),
                        ),
                        const SizedBox(height: 4.0),
                        CustomText(
                          title: widget.fullName,
                          size: FontSize.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CustomTextCollector(
                                  title: 'التقيمات',
                                  subTitle: widget.stars.toString(),
                                  isStar: true,
                                ),
                                CustomTextCollector(
                                  title: 'نوع الخِدمة',
                                  subTitle: widget.serviceType,
                                ),
                                CustomTextCollector(
                                  title: 'سنوات الخبرة',
                                  subTitle: widget.yearsOfExperience,
                                ),
                                CustomTextCollector(
                                  title: 'إيام العمل',
                                  subTitle:
                                      'من ${widget.startOfWorkingDays} إلى ${widget.endOfWorkingDays}',
                                ),
                                CustomTextCollector(
                                  title: 'الموقع',
                                  subTitle: widget.address,
                                ),
                              ],
                            ),
                          ),
                          // const Spacer(),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 10.0),
                                CustomButton(
                                  context: context,
                                  title: 'تقييم',
                                  onPressed: () {},
                                  width: Dimensions.screenWidth(context) / 2,
                                ),
                                CustomTextCollector(
                                  title: 'سعر الخِدمة',
                                  subTitle: widget.servisePrice.toString(),
                                ),
                                CustomTextCollector(
                                  title: 'العمر',
                                  subTitle: widget.dateOfBirth,
                                ),
                                CustomTextCollector(
                                  title: 'ساعات العمل',
                                  subTitle:
                                      'من ${widget.startWorkingHours} إلى ${widget.endWorkingHours}',
                                ),
                                CustomTextCollector(
                                  title: 'أقرب نقطة',
                                  subTitle: widget.location,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  context: context,
                  title: 'طلب الخِدمة',
                  onPressed: () {},
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
