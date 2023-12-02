import 'dart:io';

import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/utils/pick_image.dart';
import 'package:announcement_of_services/view/complex_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

final GlobalKey<FormState> _logUpFormKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _fullNameController = TextEditingController();
final TextEditingController _callController = TextEditingController();
final TextEditingController _dateOfBirthController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

class _CreateAccountFormState extends State<CreateAccountForm> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          _selectedImage == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image(
                                    image: const AssetImage(
                                      'assets/images/clients_home_appliance1.png',
                                    ),
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.file(
                                    _selectedImage!,
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          GestureDetector(
                            onTap: () async {
                              // getImage(ImageSource.gallery);
                              // Navigator.of(context).pop();

                              // Map<Permission, PermissionStatus> statuses = await [
                              //   Permission.storage,
                              //   Permission.camera
                              // ].request();
                              // if (statuses[Permission.storage]!.isGranted &&
                              //     statuses[Permission.camera]!.isGranted) {

                              final XFile? selectedImage =
                                  await pickImage(ImageSource.gallery);
                              setState(() {
                                _selectedImage = File(selectedImage!.path);
                              });
                              // } else {
                              //   print('No');
                              // }
                            },
                            child: const CustomText(
                              title: 'إضافة صورة',
                              size: FontSize.subtitle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  CustomTextFormFiled(
                    context: context,
                    controller: _emailController,
                    headline: 'عنوان البريد الألكتروني',
                    hintText: 'إدخل البريد الألكتروني',
                    textInputType: TextInputType.emailAddress,
                    valid: (val) {},
                    icon: const Icon(Icons.person),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _fullNameController,
                    headline: 'الاسم',
                    hintText: 'إدخل الاسم',
                    textInputType: TextInputType.name,
                    valid: (val) {},
                    icon: const Icon(Icons.person),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _callController,
                    headline: 'رقم الهاتف',
                    hintText: 'إدخل رقم الهاتف',
                    textInputType: TextInputType.phone,
                    valid: (val) {},
                    icon: const Icon(Icons.phone),
                  ),
                  CustomTextFormFiled(
                    context: context,
                    controller: _dateOfBirthController,
                    headline: 'تاريخ الميلاد',
                    hintText: 'إدخل تاريخ ميلادك',
                    textInputType: TextInputType.number,
                    readOnly: true,
                    valid: (val) {},
                    onTab: () async {
                      final String date = await datePicker(context: context);
                      _dateOfBirthController.text = date;
                    },
                    icon: const Icon(Icons.date_range_outlined),
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
                  CustomTextFormFiled(
                    context: context,
                    controller: _confirmPasswordController,
                    headline: 'تأكيد كلمة المرور',
                    hintText: 'إدخل تأكيد كلمة المرور',
                    textInputType: TextInputType.visiblePassword,
                    valid: (val) {},
                    icon: const Icon(Icons.password_outlined),
                  ),
                  //   Spacer(),
                  CustomButton(
                    context: context,
                    title: 'إنشاء حساب',
                    onPressed: () async {
                      final String email = _emailController.text.trim();
                      String fullName = _fullNameController.text.trim();
                      final String password = _passwordController.text.trim();
                      final String dateOfBirth =
                          _dateOfBirthController.text.trim();
                      final int call = int.parse(_callController.text.trim());
                      bool isServiceProvider = false;
                      final UserModel user = UserModel(
                        call: call,
                        dateOfBirth: dateOfBirth,
                        email: email,
                        password: password,
                        fullName: fullName,
                        isServiceProvider: isServiceProvider,
                      );
                      //"noor12@gmail.com";
                      //07863425435
                      await Future.delayed(const Duration(seconds: 3));
                      final bool auth =
                          await provider.signUp(user, _selectedImage);
                      if (auth) {
                        navigatePushScreen(
                            context: context, screen: const ComplexScreen());
                      } else {
                        print(auth);
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
