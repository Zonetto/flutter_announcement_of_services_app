import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

TextEditingController controller = TextEditingController();

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        const CustomText(
          title: 'مرحباً بعودتك',
          fontWeight: FontWeight.bold,
          size: FontSize.headline,
        ),
        const Spacer(),
        Column(
          children: [
            CustomTextFormFiled(
              context: context,
              controller: controller,
              headline: 'عنوان البريد الألكتروني',
              hintText: 'إدخل أسم المستخدم',
              textInputType: TextInputType.name,
              valid: (val) {},
              icon: const Icon(Icons.person),
            ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            CustomTextFormFiled(
              context: context,
              controller: controller,
              headline: 'كلمة المرور',
              hintText: 'إدخل كلمة المرور',
              textInputType: TextInputType.visiblePassword,
              valid: (val) {},
              icon: const Icon(Icons.password_outlined),
            ),
          ],
        ),
        const Spacer(),
        CustomButton(
          context: context,
          title: 'تسجيل الدخول',
          onPressed: () {},
        ),
      ],
    );
  }
}
