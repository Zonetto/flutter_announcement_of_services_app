import 'dart:math';

import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/module/auth_model.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view/complex_screen.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
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
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  bool _isObscureText = true;
  bool _loodaing = false;
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
                CustomTextFormFiled(
                  context: context,
                  readOnly: _loodaing ? true : false,
                  controller: _emailController,
                  headline: 'عنوان البريد الألكتروني',
                  hintText: 'إدخل البريد الألكتروني',
                  textInputType: TextInputType.emailAddress,
                  valid: (String? value) {
                    return ValidTextForm().email(value);
                  },
                  icon: const Icon(Icons.person),
                ),
                CustomTextFormFiled(
                  context: context,
                  isPassword: true,
                  obscureText: _isObscureText,
                  onPressedPassword: () {
                    setState(() {
                      _isObscureText = !_isObscureText;
                    });
                  },
                  controller: _passwordController,
                  readOnly: _loodaing ? true : false,
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
          CustomButton(
            isLoad: _loodaing,
            context: context,
            title: 'تسجيل الدخول',
            onPressed: () async {
              //  try {
              if (!_sigInFormKey.currentState!.validate()) {
                return;
              }
              setState(() {
                _loodaing = true;
              });
              _sigInFormKey.currentState!.save();
              final String email = _emailController.text.trim();
              final String password = _passwordController.text.trim();
              _authData = AuthModel(
                email: email,
                password: password,
              ); //"noor12@gmail.com";
              //final bool auth = await provider.logIn(_authData!);
               //await Future.delayed(const Duration(seconds: 3));
              final auth = await provider.logIn(_authData!);
              // print("aaaaa $auth");
              if (auth is Success) {
                print(
                    "auth.code ${auth.code}: ${auth.response}"); //noor@gmail.com
                // ignore: use_build_context_synchronously
                navigatePushScreen(
                    context: context, screen: const ComplexScreen());
              } //} else {
              // ignore: use_build_context_synchronously
              if (auth is Error) {
                setState(() {
                  _loodaing = false;
                });
               // print("auth.code ${auth.code}: ${auth.errorResponse}");
                // ignore: use_build_context_synchronously
                styledScaffoldMessenger(
                  context: context,
                  message: 'تأكد من البريد الألكتروني أو كلمة المرور',
                  color: AppColor.buttonColorRed,
                );
              }
              // }
              // } else {
              //   // ignore: use_build_context_synchronously
              //  // print('No');
              // styledScaffoldMessenger(
              //   context: context,
              //   message: 'تأكد من البريد الألكتروني و كلمة المرور',
              //   color: AppColor.buttonColorRed,
              // );
              // }
              // } catch (e) {
              //   print("fsfsf ${e.toString()}");
              // }
            },
          ),
        ],
      ),
    );
  }
}






 


// import this Package in pubspec.yaml file
// dependencies:
// 
//   progress_state_button: ^1.0.2



// class MyCustomWidget extends StatefulWidget {
//   @override
//   _MyCustomWidgetState createState() => _MyCustomWidgetState();
// }

// class _MyCustomWidgetState extends State<MyCustomWidget> {
//   ButtonState stateOnlyText = ButtonState.idle;
//   ButtonState stateTextWithIcon = ButtonState.idle;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ProgressButton.icon(iconedButtons: {
//           ButtonState.idle: IconedButton(
//               text: 'Send',
//               icon: const Icon(Icons.send, color: Colors.white),
//               color: Colors.deepPurple.shade500,
//               ),
//           ButtonState.loading:
//               IconedButton(text: 'Loading', color: Colors.deepPurple.shade700),
//           ButtonState.fail: IconedButton(
//               text: 'Failed',
//               icon: const Icon(Icons.cancel, color: Colors.white),
//               color: Colors.red.shade300,
//               ),
//           ButtonState.success: IconedButton(
//               text: 'Success',
//               icon: const Icon(
//                 Icons.check_circle,
//                 color: Colors.white,
//               ),
//               color: Colors.green.shade400)
//         }, onPressed: onPressedIconWithText, state: stateTextWithIcon),
//       ),
//     );
//   }

//   void onPressedIconWithText() {
//     switch (stateTextWithIcon) {
//       case ButtonState.idle:
//         stateTextWithIcon = ButtonState.loading;
//         Future.delayed(
//           const Duration(seconds: 1),
//           () {
//             setState(
//               () {
//                 stateTextWithIcon = Random.secure().nextBool()
//                     ? ButtonState.success
//                     : ButtonState.fail;
//               },
//             );
//           },
//         );

//         break;
//       case ButtonState.loading:
//         break;
//       case ButtonState.success:
//         stateTextWithIcon = ButtonState.idle;
//         break;
//       case ButtonState.fail:
//         stateTextWithIcon = ButtonState.idle;
//         break;
//     }
//     setState(
//       () {
//         stateTextWithIcon = stateTextWithIcon;
//       },
//     );
//   }
// }



