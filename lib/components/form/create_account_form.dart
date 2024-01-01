import 'dart:io';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/pick_image.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view/complex_screen.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _logUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _callController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscureText = true;
  bool _lodaing = false;

  @override
  void dispose() {
    _logUpFormKey.currentState?.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _callController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //    _logUpFormKey.currentState?.dispose();
  //   _emailController.dispose();
  //   _fullNameController.dispose();
  //   _callController.dispose();
  //   _dateOfBirthController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.initState();
  // }
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelAuth>(context, listen: false);
    return Form(
      key: _logUpFormKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(
                    imagePathNetwork: null,
                    imagePathLocal: _selectedImage,
                    isEdit: !_lodaing ? true : false,
                    onTap: () async {
                      final XFile? selectedImage =
                          await pickImage(ImageSource.gallery);
                      setState(() {
                        if (selectedImage != null) {
                          _selectedImage = File(selectedImage.path);
                        }
                      });
                    },
                    height: AppSize.imageSizeLarg(context),
                    width: AppSize.imageSizeLarg(context),
                  ),
                  const SizedBox(height: 14.0),
                  CustomTextFormFiled(
                    context: context,
                    controller: _emailController,
                    headline: 'عنوان البريد الألكتروني',
                    hintText: 'إدخل البريد الألكتروني',
                    readOnly: _lodaing ? true : false,
                    textInputType: TextInputType.emailAddress,
                    valid: (String? value) {
                      return ValidTextForm().email(value);
                    },
                    icon: const Icon(Icons.person),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _fullNameController,
                    headline: 'الاسم',
                    hintText: 'إدخل الاسم',
                    readOnly: _lodaing ? true : false,
                    textInputType: TextInputType.name,
                    valid: (String? value) {
                      return ValidTextForm().emptyText(value);
                    },
                    icon: const Icon(Icons.person),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _callController,
                    headline: 'رقم الهاتف',
                    hintText: 'إدخل رقم الهاتف',
                    readOnly: _lodaing ? true : false,
                    textInputType: TextInputType.phone,
                    valid: (String? value) {
                      return ValidTextForm().call(value);
                    },
                    icon: const Icon(Icons.phone),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _dateOfBirthController,
                    headline: 'تاريخ الميلاد',
                    hintText: 'إدخل تاريخ ميلادك',
                    textInputType: TextInputType.number,
                    readOnly: true,
                    valid: (String? value) {
                      return ValidTextForm().emptyText(value);
                    },
                    onTab: !_lodaing
                        ? () async {
                            final String date =
                                await datePicker(context: context);
                            _dateOfBirthController.text = date;
                          }
                        : null,
                    icon: const Icon(Icons.date_range_outlined),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    isPassword: true,
                    obscureText: _isObscureText,
                    readOnly: _lodaing ? true : false,
                    onPressedPassword: () {
                      setState(() {
                        _isObscureText = !_isObscureText;
                      });
                    },
                    controller: _passwordController,
                    headline: 'كلمة المرور',
                    hintText: 'إدخل كلمة المرور',
                    textInputType: TextInputType.visiblePassword,
                    valid: (String? value) {
                      return ValidTextForm().password(value);
                    },
                    icon: const Icon(Icons.password_outlined),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    isPassword: true,
                    obscureText: _isObscureText,
                    readOnly: _lodaing ? true : false,
                    onPressedPassword: () {
                      setState(() {
                        _isObscureText = !_isObscureText;
                      });
                    },
                    controller: _confirmPasswordController,
                    headline: 'تأكيد كلمة المرور',
                    hintText: 'إدخل تأكيد كلمة المرور',
                    textInputType: TextInputType.visiblePassword,
                    valid: (String? value) {
                      return ValidTextForm().confirmPassword(
                        value,
                        _passwordController.text,
                      );
                    },
                    icon: const Icon(Icons.password_outlined),
                  ),
                  //   Spacer(),
                  CustomButton(
                    isLoad: _lodaing,
                    context: context,
                    title: 'إنشاء حساب',
                    onPressed: () async {
                      if (!_logUpFormKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        _lodaing = true;
                      });

                      _logUpFormKey.currentState!.save();
                      final String email = _emailController.text.trim();
                      //  'a44hmedee@gmail.com'; //_emailController.text.trim();
                      String fullName = _fullNameController.text.trim();
                      //  'Ahmed'; //_fullNameController.text.trim();
                      final String password = _passwordController.text.trim();
                      //  '112233'; //_passwordController.text.trim();
                      final String dateOfBirth =
                          _dateOfBirthController.text.trim(); //
                      _dateOfBirthController.text.trim(); // '2002';
                      // _dateOfBirthController.text.trim();
                      final int call = int.parse(_callController.text.trim());
                      // 098; //int.parse(_callController.text.trim());
                      String isServiceProvider = serviceProviderUnaccepted;
                      final UserModel user = UserModel(
                        call: call,
                        dateOfBirth: dateOfBirth,
                        email: email,
                        role: 'user',
                        password: password,
                        fullName: fullName,
                        isServiceProvider: isServiceProvider,
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      final auth = await provider.signUp(user, _selectedImage);
                      if (auth is Success) {
                        navigatePushScreen(
                            context: context, screen: const ComplexScreen());
                      }
                      if (auth is Error) {
                        setState(() {
                          _lodaing = false;
                        });

                        styledScaffoldMessenger(
                          context: context,
                          message: 'تأكد من ملئ جميع الحقول',
                          color: AppColor.buttonColorRed,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// علي محمد جسم
