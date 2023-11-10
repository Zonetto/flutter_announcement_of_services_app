import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/add_photo_screen.dart';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

TextEditingController controller = TextEditingController();

class _CreateAccountFormState extends State<CreateAccountForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        const CustomText(
          title: 'سجل الأن',
          fontWeight: FontWeight.bold,
          size: FontSize.headline,
        ),
        // const Spacer(),
        Expanded(
          child: ListView(
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
              CustomTextFormFiled(
                context: context,
                controller: controller,
                headline: 'رقم الهاتف',
                hintText: 'إدخل رقم الهاتف',
                textInputType: TextInputType.phone,
                valid: (val) {},
                icon: const Icon(Icons.phone),
              ),
              CustomTextFormFiled(
                context: context,
                controller: controller,
                headline: 'تاريخ الميلاد',
                hintText: 'إدخل تاريخ ميلادك',
                textInputType: TextInputType.number,
                readOnly: true,
                valid: (val) {},
                onTab: () {},
                icon: const Icon(Icons.date_range_outlined),
              ),
              CustomTextFormFiled(
                context: context,
                controller: controller,
                headline: 'كلمة المرور',
                hintText: 'إدخل كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                valid: (val) {},
                icon: const Icon(Icons.password_outlined),
              ),
              CustomTextFormFiled(
                context: context,
                controller: controller,
                headline: 'تأكيد كلمة المرور',
                hintText: 'إدخل تأكيد كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                valid: (val) {},
                icon: const Icon(Icons.password_outlined),
              ),
            ],
          ),
        ),
        // const Spacer(),
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
    );
  }
}
