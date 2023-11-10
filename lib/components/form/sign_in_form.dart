import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

final GlobalKey<FormState> _personFormKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomTextFormFiled(
                  context: context,
                  controller: _emailController,
                  headline: 'عنوان البريد الألكتروني',
                  hintText: 'إدخل البريد الألكتروني',
                  textInputType: TextInputType.name,
                  valid: (val) {},
                  icon: const Icon(Icons.person),
                ),
                CustomTextFormFiled(
                  context: context,
                  controller: _passwordController,
                  headline: 'كلمة المرور',
                  hintText: 'إدخل كلمة المرور',
                  textInputType: TextInputType.visiblePassword,
                  valid: (val) {},
                  icon: const Icon(Icons.password_outlined),
                ),
              ],
            ),
          ),
          CustomButton(
            context: context,
            title: 'تسجيل الدخول',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
