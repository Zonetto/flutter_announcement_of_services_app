import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:flutter/material.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.horizontalMargin,
            vertical: AppSize.verticalMargin,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const Spacer(),
                Column(
                  children: [
                    Container(
                      width: Dimensions.screenWidth(context) / 2.5,
                      height: Dimensions.screenWidth(context) / 2.5,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/clients_home_appliance1.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: OvalBorder(),
                        shadows: [
                          BoxShadow(
                            color: AppColor.shadowColor,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                    const CustomText(
                      title: 'ضع صورة',
                      size: FontSize.subtitle,
                    ),
                    CustomTextFormFiled(
                      context: context,
                      controller: controller,
                      headline: 'أسم المستخدم',
                      hintText: 'إدخل أسم المستخدم',
                      textInputType: TextInputType.name,
                      valid: (value) {},
                      icon: const Icon(Icons.photo),
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                    context: context, title: 'أستمر', onPressed: () {}),
                const SizedBox(height: 10),
                CustomButton(
                  context: context,
                  title: 'تخطي',
                  onPressed: () {},
                  textColor: AppColor.colorTextButtonGreen,
                  backGroundColor: AppColor.buttonColorGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
