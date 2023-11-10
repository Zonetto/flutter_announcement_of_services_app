import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/add_photo_screen.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

final GlobalKey<FormState> _personFormKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _callController = TextEditingController();
final TextEditingController _dateOfBirthController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

class _CreateAccountFormState extends State<CreateAccountForm> {
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
                    await datePicker(context: context);
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
              ],
            ),
          ),
          CustomButton(
            context: context,
            title: 'إنشاء حساب',
            onPressed: () {
              navigatePushScreen(
                context: context,
                screen: const AddPhotoScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
