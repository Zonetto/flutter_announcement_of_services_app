import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/text_form_field_widget.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view/bottom_navigation_bar_screen.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _sigInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscureText = true;
  bool _loading = false;
  AuthModel? _authData;
  @override
  void dispose() {
    _sigInFormKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelAuth>(context, listen: false);
    return Form(
      key: _sigInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                TextFormFieldWidget(
                  context: context,
                  readOnly: _loading ? true : false,
                  controller: _emailController,
                  headline: 'عنوان البريد الألكتروني',
                  hintText: 'إدخل البريد الألكتروني',
                  textInputType: TextInputType.emailAddress,
                  valid: (String? value) {
                    return ValidTextForm().email(value);
                  },
                  icon: const Icon(Icons.person),
                ),
                TextFormFieldWidget(
                  context: context,
                  isPassword: true,
                  obscureText: _isObscureText,
                  onPressedPassword: () {
                    setState(() {
                      _isObscureText = !_isObscureText;
                    });
                  },
                  controller: _passwordController,
                  readOnly: _loading ? true : false,
                  headline: 'كلمة المرور',
                  hintText: 'إدخل كلمة المرور',
                  textInputType: TextInputType.visiblePassword,
                  valid: (String? value) {
                    return ValidTextForm().password(value);
                  },
                  icon: const Icon(Icons.password_outlined),
                ),
              ],
            ),
          ),
          ButtonWidget(
            isLoad: _loading,
            context: context,
            title: 'تسجيل الدخول',
            onPressed: () async {
              //  try {
              if (!_sigInFormKey.currentState!.validate()) {
                return;
              }
              setState(() {
                _loading = true;
              });
              _sigInFormKey.currentState!.save();
              final String email = _emailController.text.trim();
              final String password = _passwordController.text.trim();
              _authData = AuthModel(
                email: email,
                password: password,
              ); //"noor12@gmail.com";

              final auth = await provider.logIn(_authData!);
              // print("aaaaa $auth");
              if (auth is Success) {
                // print("auth.code ${auth.code}: ${auth.response}");
                // ignore: use_build_context_synchronously
                navigateAndReplaceScreen(
                  context: context,
                  screen: const BottomNavigationBarScreen(),
                );
              } //} else {
              // ignore: use_build_context_synchronously
              if (auth is Error) {
                 print(auth.code);
                print(auth.errorResponse);
                setState(() {
                  _loading = false;
                });
                // ignore: use_build_context_synchronously
                styledScaffoldMessenger(
                  context: context,
                  message: 'تأكد من البريد الألكتروني أو كلمة المرور',
                  color: AppColor.buttonColorRed,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
