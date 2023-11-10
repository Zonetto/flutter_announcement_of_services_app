import 'package:announcement_of_services/components/form/create_account_form.dart';
import 'package:announcement_of_services/components/form/sign_in_form.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

import '../components/custom_buttom.dart';

class RegistrationOptionScreen extends StatefulWidget {
  const RegistrationOptionScreen({super.key});

  @override
  State<RegistrationOptionScreen> createState() =>
      _RegistrationOptionScreenState();
}

bool isSignIn = false;
bool isLogOut = true;

class _RegistrationOptionScreenState extends State<RegistrationOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.horizontalMargin,
            vertical: AppSize.verticalMargin,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
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
                      isSmall: true,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: CustomButton(
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
                      isSmall: true,
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    isSignIn ? const CreateAccountForm() : const SignInForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
