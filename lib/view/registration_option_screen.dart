import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/form/create_account_form.dart';
import 'package:announcement_of_services/components/form/sign_in_form.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

class RegistrationOptionScreen extends StatefulWidget {
  const RegistrationOptionScreen({super.key});

  @override
  State<RegistrationOptionScreen> createState() =>
      _RegistrationOptionScreenState();
}

bool isSignIn = false;

class _RegistrationOptionScreenState extends State<RegistrationOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSize.padding,
          child: Column(
            children: [
              AppSize.sizedBoxHeight,
              Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      context: context,
                      title: 'تسجيل دخول',
                      backGroundColor: isSignIn
                          ? AppColor.buttonColorGrey
                          : AppColor.buttonColorGreen,
                      textColor: isSignIn
                          ? AppColor.colorTextButtonGreen
                          : AppColor.colorTextButtonWhite,
                      onPressed: () {
                        setState(() {
                          isSignIn = false;
                        });
                        // print('object');
                        // checkSignIn();
                      },
                      width: Dimensions.screenWidth(context) / 2,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ButtonWidget(
                      context: context,
                      title: 'إنشاء حساب',
                      backGroundColor: !isSignIn
                          ? AppColor.buttonColorGrey
                          : AppColor.buttonColorGreen,
                      textColor: !isSignIn
                          ? AppColor.colorTextButtonGreen
                          : AppColor.colorTextButtonWhite,
                      onPressed: () {
                        setState(() {
                          isSignIn = true;
                        });
                        // checkSignIn();
                      },
                      width: Dimensions.screenWidth(context) / 2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                alignment: Alignment.centerRight,
                child: TextWidget(
                  title: isSignIn ? 'سجل الأن' : 'مرحباً بعودتك',
                  fontWeight: FontWeight.bold,
                  size: FontSize.headline,
                ),
              ),
              Expanded(
                child:
                    isSignIn ? const CreateAccountForm() : const SignInForm(),
              ),
              AppSize.sizedBoxHeight,
            ],
          ),
        ),
      ),
    );
  }
}
