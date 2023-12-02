import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/complex_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

final GlobalKey<FormState> _sigInFormKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelAuth>(context, listen: false);
    AuthModel _authData;
    return Form(
      key: _sigInFormKey,
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
            onPressed: () async {
              final String email = _emailController.text.trim();
              final String password = _passwordController.text.trim();
              _authData = AuthModel(
                email: email,
                password: password,
              ); //"noor12@gmail.com";
              final auth = await provider.logIn(_authData);
              if (auth) {
                navigatePushScreen(context: context, screen: ComplexScreen());
              }
            },
          ),
        ],
      ),
    );
  }
}
