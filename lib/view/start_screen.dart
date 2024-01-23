import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
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
      backgroundColor: AppColor.white,
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
              decoration: CustomShapeDecoration.shapeDecoration(
                context,
                color: AppColor.white,
              ),
              child: Column(
                children: [
                  FittedBox(
                    child: TextWidget(
                      title: 'ابحث، احجز، احصل على الخدمة',
                      size: Dimensions.screenWidth(context) * 0.08,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkShadeText,
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(30.0),
                    //  color: AppColor.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: TextWidget(
                        title:
                            'تطبيقنا يوفر اتصالًا فوريًا بين مقدمي الخدمات المحترفين والأفراد الباحثين عن الخدمات. ابحث، احجز، واحصل على مجموعة متنوعة من الخدمات بسهولة وفعالية. انضم إلينا لتجربة تواصل فريدة تلبي احتياجاتك بكل يسر وسرعة.',
                        size: FontSize.plainText(context),
                        alignment: TextAlign.center,
                        color: AppColor.darkShadeText),
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
