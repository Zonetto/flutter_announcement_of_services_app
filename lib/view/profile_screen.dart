import 'package:announcement_of_services/components/custom_buttom_ink.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_collector.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: AppSize.nternalMargin,
          //height: 250,
          margin: const EdgeInsets.only(bottom: 24.0),
          width: double.infinity,
          decoration: CustomShapeDecoration.shapeDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Column(
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
                  CustomTextCollector(
                    title: 'التقيمات',
                    subTitle: '4.5',
                    isStar: true,
                  ),
                ],
              ),
              const Spacer(),
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
        ),
        CustomButtonInk(
          context: context,
          title: 'الوضع',
          icon: Icons.mode_night_outlined,
          onTap: () {},
          isImage: false,
        ),
        CustomButtonInk(
          context: context,
          title: 'حول التطبيق',
          icon: Icons.info_outlined,
          onTap: () {},
          isImage: false,
        ),
        CustomButtonInk(
          context: context,
          title: 'اتصل بنا',
          icon: Icons.local_phone_outlined,
          onTap: () {},
          isImage: false,
        ),
      ],
    );
  }
}
