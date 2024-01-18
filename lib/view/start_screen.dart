import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';
import 'registration_option_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: Dimensions.screenWidth(context),
                height: Dimensions.screenHeight(context) / 2,
                child: Image.asset(
                  'assets/images/clients_home_appliance1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: AppSize.nternalMargin,
              //height: 250,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: CustomShapeDecoration.shapeDecoration(context),
              child: Column(
                children: [
                  FittedBox(
                    child: TextWidget(
                      title: 'مرحباً بك في تطبيق السهولة هُنا',
                      size: Dimensions.screenWidth(context) * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(30.0),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: const TextWidget(
                      title:
                          'مرحباً بك في تطبيق السهولة هُنا سنتنشستنش شنتسشن سنشست شنستشنست شنتسنش سنشتسنشتسنشتس شنس تشنست نشتسنش سنشتسنشتسنش تسشسنتش سنشتس شنتسنش تسنشتس شنتسشنست نشسنشتس نشسنشتس نش تس',
                      size: FontSize.plainText,
                      alignment: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ButtonWidget(
                    context: context,
                    title: 'أبدء',
                    onPressed: () {
                      navigateToScreen(
                        context: context,
                        screen: const RegistrationOptionScreen(),
                      );
                    },
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
