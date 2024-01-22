import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/image_widget.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/components/text_collector_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final int call;
  final String dateOfBirth;
  final String email;
  final VoidCallback? onPressedRating;
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
  final String stars;
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
    this.onPressedRating,
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
            margin: const EdgeInsets.symmetric(vertical: 10),
            //height: 250,
            // margin: const EdgeInsets.only(bottom: 24.0),
            width: Dimensions.screenWidth(context),
            height: Dimensions.screenHeight(context),
            decoration: CustomShapeDecoration.shapeDecoration(context),
            child: Column(
              children: [
                AppSize.sizedBoxHeight,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // direction: Axis.vertical,
                        children: [
                          TextCollectorWidget(
                            title: 'البريد الإلكتروني',
                            subTitle: widget.email,
                          ),
                          TextCollectorWidget(
                            title: 'رقم الهاتف',
                            subTitle: "0${widget.call.toString()}",
                          ),
                        ],
                      ),
                    ),
                    //const Spacer(),
                    Column(
                      children: [
                        ImageWidget(
                          imagePathNetwork: widget.image,
                          height: AppSize.imageSizeLarg(context),
                          width: AppSize.imageSizeLarg(context),
                        ),
                        const SizedBox(height: 4.0),
                        TextWidget(
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
                                TextCollectorWidget(
                                  title: 'التقيمات',
                                  subTitle: widget.stars,
                                  isStar: true,
                                ),
                                TextCollectorWidget(
                                  title: 'نوع الخِدمة',
                                  subTitle: widget.serviceType,
                                ),
                                TextCollectorWidget(
                                  title: 'سنوات الخبرة',
                                  subTitle: widget.yearsOfExperience,
                                ),
                                TextCollectorWidget(
                                  title: 'إيام العمل',
                                  subTitle:
                                      'من ${widget.startOfWorkingDays} إلى ${widget.endOfWorkingDays}',
                                ),
                                TextCollectorWidget(
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
                                ButtonWidget(
                                  context: context,
                                  title: 'تقييم',
                                  onPressed: widget.onPressedRating,
                                  width: Dimensions.screenWidth(context) / 2,
                                ),
                                TextCollectorWidget(
                                  title: 'سعر الخِدمة',
                                  subTitle: widget.servisePrice.toString(),
                                ),
                                TextCollectorWidget(
                                  title: 'العمر',
                                  subTitle: calculateAge((widget.dateOfBirth))
                                      .toString(), // widget.dateOfBirth,
                                ),
                                TextCollectorWidget(
                                  title: 'ساعات العمل',
                                  subTitle:
                                      'من ${widget.startWorkingHours} إلى ${widget.endWorkingHours}',
                                ),
                                TextCollectorWidget(
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
                ButtonWidget(
                  context: context,
                  title: 'طلب الخِدمة',
                  onPressed: () {
                    // ignore: deprecated_member_use
                    launch("tel: +964${widget.call}");
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int calculateAge(String birthYear) {
  int currentYear = DateTime.now().year;
  int currentYear1 = convertStringToDate(birthYear);

  int age = currentYear - currentYear1;

  return age;
}

int convertStringToDate(String dateString) {
  List<String> dateParts = dateString.split('/');
  int year = int.parse(dateParts[2]);

  return year;
}
