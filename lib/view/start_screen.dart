import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

import '../components/custom_buttom.dart';
import 'registration_option_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: Dimensions.screenWidth(context),
              height: Dimensions.screenHeight(context) / 2,
              child: Image.asset(
                'assets/images/clients_home_appliance1.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              //height: 250,
              width: double.infinity,

              margin: const EdgeInsets.symmetric(
                horizontal: AppSize.horizontalMargin,
                // vertical: 10,
              ),
              decoration: ShapeDecoration(
                color: AppColor.screenBackGroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  const CustomText(
                    title: 'مرحباً بك في تطبيق السهولة هُنا',
                    size: FontSize.headline,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    // padding: EdgeInsets.all(30.0),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: const CustomText(
                      title:
                          'مرحباً بك في تطبيق السهولة هُنا سنتنشستنش شنتسشن سنشست شنستشنست شنتسنش سنشتسنشتسنشتس شنس تشنست نشتسنش سنشتسنشتسنش تسشسنتش سنشتس شنتسنش تسنشتس شنتسشنست نشسنشتس نشسنشتس نش تس',
                      size: FontSize.plainText,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    context: context,
                    title: 'أبدء',
                    onPressed: () {
                      navigatePushScreen(
                        context: context,
                        screen: const RegistrationOptionScreen(),
                      );
                    },
                    isSmall: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
