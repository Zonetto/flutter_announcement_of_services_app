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
  const ServiceDetailsScreen({super.key});

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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // direction: Axis.vertical,
                        children: [
                          CustomTextCollector(
                            title: 'البريد الإلكتروني',
                            subTitle: 'ahmed12@66.com',
                          ),
                          CustomTextCollector(
                            title: 'رقم الهاتف',
                            subTitle: '288744a78683',
                          ),
                        ],
                      ),
                    ),
                    //const Spacer(),
                    Column(
                      children: [
                        CustomImage(
                          imagePath: 'assets/images/woman.jpg',
                          height: AppSize.imageSizeLarg(context),
                          width: AppSize.imageSizeLarg(context),
                        ),
                        const SizedBox(height: 4.0),
                        const CustomText(
                          title: 'محمد علي كاظم',
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
                          const Expanded(
                            child: Column(
                              children: [
                                CustomTextCollector(
                                  title: 'التقيمات',
                                  subTitle: '4.5',
                                  isStar: true,
                                ),
                                CustomTextCollector(
                                  title: 'نوع الخِدمة',
                                  subTitle: 'نجارة',
                                ),
                                CustomTextCollector(
                                  title: 'سنوات الخبرة',
                                  subTitle: '4 سنوات',
                                ),
                                CustomTextCollector(
                                  title: 'إيام العمل',
                                  subTitle: 'من الأحد إلى السبت',
                                ),
                                CustomTextCollector(
                                  title: 'الموقع',
                                  subTitle: 'النجف الأشرف/ حي الحرفين',
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
                                  isSmall: true,
                                ),
                                const CustomTextCollector(
                                  title: 'سعر الخِدمة',
                                  subTitle: 'تبدأ من 50 ألف للمتر الواحد',
                                ),
                                const CustomTextCollector(
                                  title: 'العمر',
                                  subTitle: '33',
                                ),
                                const CustomTextCollector(
                                  title: 'ساعات العمل',
                                  subTitle: 'من 9 صباحاً إلى 9 مساءً',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //const Spacer(),
                CustomButton(
                  context: context,
                  title: 'طلب الخِدمة',
                  onPressed: () {},
                  //isSmall: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
