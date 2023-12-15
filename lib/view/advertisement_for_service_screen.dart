import 'package:announcement_of_services/components/custom_dropdown.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> fillDropdownItems(List<String> items) {
  return items.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }).toList();
}

class AdvertisementForServiceScreen extends StatefulWidget {
  const AdvertisementForServiceScreen({super.key});

  @override
  State<AdvertisementForServiceScreen> createState() =>
      _AdvertisementForServiceScreenState();
}

class _AdvertisementForServiceScreenState
    extends State<AdvertisementForServiceScreen> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  List<String> itemsServices = <String>[
    'نجارة',
    'حدادة',
    'صباغ',
    'تصليح هواتف',
    'تصليح شاشات',
    'نجار قالب',
    'صب مسلح',
    'خياطة',
    'عامل بناء',
  ];

  List<String> itemsYearsOfExperience = <String>[
    'سنة واحدة',
    'سنتين',
    'ثلاث سنوات',
    'اربعة سنوات',
    'خمسة سنوات',
    'ستة سنوات',
    '7 سنوات',
    '8 سنوات',
    'اكثر من 9 سنوات',
  ];
  List<String> itemsStartOfWorkingDays = <String>[
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];
  List<String> itemsAddress = <String>[
    'القادسية',
    'حي الامير',
    'حي الحرفيين',
    'حي النفط',
    'شارع المطار',
    'حي العسكري',
    'المهندسين',
  ];

  List<DropdownMenuItem<String>>? dropdownItemsServices;
  List<DropdownMenuItem<String>>? dropdownItemsYearsOfExperience;
  List<DropdownMenuItem<String>>? dropdownItemsStartOfWorkingDays;
  List<DropdownMenuItem<String>>? dropdownItemsEndOfWorkingDays;
  List<DropdownMenuItem<String>>? dropdownItemsAddress;

  String? _selectServices;
  String? _selectYearsOfExperience;
  String? _selectStartOfWorkingDays;
  String? _selectendOfWorkingDays;
  String? _selectAddress;
  @override
  Widget build(BuildContext context) {
    dropdownItemsServices = fillDropdownItems(itemsServices);
    dropdownItemsYearsOfExperience = fillDropdownItems(itemsYearsOfExperience);
    dropdownItemsStartOfWorkingDays =
        fillDropdownItems(itemsStartOfWorkingDays);
    dropdownItemsEndOfWorkingDays = fillDropdownItems(itemsStartOfWorkingDays);

    dropdownItemsAddress = fillDropdownItems(itemsAddress);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomImage(
              imagePath: null,
              width: Dimensions.screenWidth(context),
              isCircular: false,
              height: 120,
              radius: 10,
            ),

            // Container(
            //   //  decoration: CustomShapeDecoration.shapeDecoration,
            //   height: 120,
            //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 14),
            //   width: Dimensions.screenWidth(context),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(150),
            //     image: const DecorationImage(
            //       image: AssetImage('assets/images/repairing-computer.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),

            //   // child: Image.asset(
            //   //   fit: BoxFit.fitWidth,
            //   //   'assets/images/repairing-computer.jpg',
            //   // ),
            // ),
            CustomDropDownString(
              hintText: 'نوع الخدمة',
              context: context,
              value: _selectServices,
              onChanged: (value) {
                setState(() {
                  _selectServices = value!;
                });
                return null;
              },
              items: dropdownItemsServices!,
            ),
            CustomDropDownString(
              hintText: 'سنوات الخبرة',
              context: context,
              value: _selectYearsOfExperience,
              onChanged: (value) {
                setState(() {
                  _selectYearsOfExperience = value!;
                });
                return null;
              },
              items: dropdownItemsYearsOfExperience!,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: Dimensions.screenWidth(context) / 3,
                    margin: const EdgeInsets.only(bottom: 14.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.buttonColorGrey,
                    ),
                    child: const Row(
                      children: [
                        CustomText(
                          title: 'إيام العمل',
                          size: FontSize.plainText,
                        ),
                        Spacer(),
                        Icon(Icons.date_range_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  CustomDropDownString(
                    hintText: 'من',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    value: _selectStartOfWorkingDays,
                    onChanged: (value) {
                      setState(() {
                        _selectStartOfWorkingDays = value!;
                      });
                      return null;
                    },
                    items: dropdownItemsStartOfWorkingDays!,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CustomDropDownString(
                    hintText: 'إلى',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    value: _selectendOfWorkingDays,
                    onChanged: (value) {
                      setState(() {
                        _selectendOfWorkingDays = value!;
                      });
                      return null;
                    },
                    items: dropdownItemsEndOfWorkingDays!,
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: Dimensions.screenWidth(context) / 3,
                    margin: const EdgeInsets.only(bottom: 14.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.buttonColorGrey,
                    ),
                    child: const Row(
                      children: [
                        CustomText(
                          title: 'ساعات العمل',
                          size: FontSize.plainText,
                        ),
                        Spacer(),
                        Icon(Icons.date_range_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  CustomDropDownString(
                    hintText: 'من',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    value: _selectStartOfWorkingDays,
                    onChanged: (value) {
                      setState(() {
                        _selectStartOfWorkingDays = value!;
                      });
                      return null;
                    },
                    items: dropdownItemsStartOfWorkingDays!,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CustomDropDownString(
                    hintText: 'إلى',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    value: _selectendOfWorkingDays,
                    onChanged: (value) {
                      setState(() {
                        _selectendOfWorkingDays = value!;
                      });
                      return null;
                    },
                    items: dropdownItemsEndOfWorkingDays!,
                  ),
                ],
              ),
            ),

            CustomTextFormFiled(
              isWithoutText: true,
              context: context,
              controller: priceController,
              headline: '',
              hintText: 'سعر الخدمة',
              textInputType: TextInputType.number,
              valid: (value) {},
              icon: const Icon(Icons.price_check),
            ),
            CustomDropDownString(
              hintText: 'الحي/السكن',
              context: context,
              value: _selectAddress,
              onChanged: (value) {
                setState(() {
                  _selectAddress = value!;
                });
                return null;
              },
              items: dropdownItemsAddress!,
            ),
            CustomTextFormFiled(
              context: context,
              controller: locationController,
              hintText: 'اقرب نقطة دالة',
              headline: '',
              isWithoutText: true,
              textInputType: TextInputType.text,
              valid: (valuse) {},
              icon: const Icon(Icons.location_on_outlined),
              maxLines: 2,
              minLines: 2,
            )
            // TextFormField(maxLength: 130, maxLines: 3),
          ],
        ),
      ),
    );
  }
}
