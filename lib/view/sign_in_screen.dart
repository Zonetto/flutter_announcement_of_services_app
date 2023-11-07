import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/view/custom_buttom.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

bool isSignIn = false;
bool isLogOut = true;

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.horizontalMargin,
                vertical: AppSize.verticalMargin,
              ),
              child: Row(
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
            )
          ],
        ),
      ),
    );
  }
}
