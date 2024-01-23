import 'dart:io';
import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/image_widget.dart';
import 'package:announcement_of_services/components/text_form_field_widget.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/pick_image.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view/bottom_navigation_bar_screen.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ImageWidget(
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
                  TextFormFieldWidget(
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
                  TextFormFieldWidget(
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
                  TextFormFieldWidget(
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
                  TextFormFieldWidget(
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
                  TextFormFieldWidget(
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
                  TextFormFieldWidget(
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
                  ButtonWidget(
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
                      String fullName = _fullNameController.text.trim();
                      final String password = _passwordController.text.trim();
                      final String dateOfBirth =
                          _dateOfBirthController.text.trim();
                      _dateOfBirthController.text.trim();
                      final int call = int.parse(_callController.text.trim());
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
                      if (_selectedImage != null) {
                        await Future.delayed(const Duration(seconds: 1));

                        final auth =
                            await provider.signUp(user, _selectedImage);
                        if (auth is Success) {
                          // ignore: use_build_context_synchronously
                          navigateAndReplaceScreen(
                              context: context,
                              screen: const BottomNavigationBarScreen());
                        }
                        if (auth is Error) {
                          setState(() {
                            _lodaing = false;
                          });
                          print(auth.errorResponse);
                          if (auth.code == 400) {
                            // ignore: use_build_context_synchronously
                            styledScaffoldMessenger(
                              context: context,
                              message: 'لقد تم التسجيل في هذا الحساب مسبقاً\nرجاءًا حاول تغير عنوان البريد الالكتروني',
                              color: AppColor.buttonColorRed,
                            );
                          }
                        }
                      } else {
                        setState(() {
                          _lodaing = false;
                        });
                        styledScaffoldMessenger(
                          context: context,
                          message: 'لايمكن ان تكون الصورة فارغة',
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
