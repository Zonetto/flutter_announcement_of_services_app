import 'dart:io';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/components/custom_dropdown.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/module/post_model.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/services_provider_info_model.dart';
import 'package:announcement_of_services/services/collections/post_collection.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_storage_servises.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/utils/fill_dropdown_items.dart';
import 'package:announcement_of_services/utils/pick_image.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAdvertisementForServiceForm extends StatefulWidget {
  const CreateAdvertisementForServiceForm({super.key});

  @override
  State<CreateAdvertisementForServiceForm> createState() =>
      _CreateAdvertisementForServiceFormState();
}

class _CreateAdvertisementForServiceFormState
    extends State<CreateAdvertisementForServiceForm> {
  final GlobalKey<FormState> _createAdvertisement = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeFromController = TextEditingController();
  final TextEditingController _timeIntoController = TextEditingController();
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
  File? _selectedImage;

  @override
  void dispose() {
    _createAdvertisement.currentState?.dispose();
    _priceController.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _timeFromController.dispose();
    _timeIntoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _priceController.clear();
    _locationController.clear();
    _timeFromController.clear();
    _timeIntoController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServicesProviderInfoModel servicesProviderInfo =
        ServicesProviderInfoModel().fillServicesProviderInfo();
    dropdownItemsServices =
        fillDropdownItems(servicesProviderInfo.itemsServices!);
    dropdownItemsYearsOfExperience =
        fillDropdownItems(servicesProviderInfo.itemsYearsOfExperience!);
    dropdownItemsStartOfWorkingDays =
        fillDropdownItems(servicesProviderInfo.itemsStartOfWorkingDays!);
    dropdownItemsEndOfWorkingDays =
        fillDropdownItems(servicesProviderInfo.itemsStartOfWorkingDays!);

    dropdownItemsAddress =
        fillDropdownItems(servicesProviderInfo.itemsAddress!);
    return Form(
      key: _createAdvertisement,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
              child: CustomImage(
                imagePathNetwork: null,
                imagePathLocal: _selectedImage,
                width: Dimensions.screenWidth(context),
                height: 120,
                radius: 15,
                isEdit: true,
                onTap: () async {
                  final XFile? selectedImage =
                      await pickImage(ImageSource.gallery);
                  setState(() {
                    if (selectedImage != null) {
                      _selectedImage = File(selectedImage.path);
                    }
                  });
                },
              ),
            ),
            CustomTextFormFiled(
              isWithoutText: true,
              context: context,
              controller: _titleController,
              headline: '',
              maxLength: 30,
              hintText: 'عنوان الخدمة',
              textInputType: TextInputType.text,
              valid: (String? value) {
                return ValidTextForm().emptyText(value);
              },
            ),
            //
            CustomDropDownString(
              hintText: 'نوع الخدمة',
              context: context,
              value: _selectServices,
              valid: (String? value) {
                return ValidTextForm().nullText(value);
              },
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
              valid: (String? value) {
                return ValidTextForm().nullText(value);
              },
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
                    valid: (String? value) {
                      return ValidTextForm().nullText(value);
                    },
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
                    valid: (String? value) {
                      return ValidTextForm().nullText(value);
                    },
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
                  CustomTextFormFiled(
                    context: context,
                    width: Dimensions.screenWidth(context) / 2,
                    controller: _timeFromController,
                    hintText: 'من',
                    headline: '',
                    readOnly: true,
                    isWithoutText: true,
                    textInputType: TextInputType.text,
                    valid: (String? value) {
                      return ValidTextForm().emptyText(value);
                    },
                    onTab: () async {
                      _timeFromController.clear();

                      _timeFromController.text =
                          await timePicker(context: context);
                    },
                    icon: const Icon(Icons.access_time_outlined),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CustomTextFormFiled(
                    context: context,
                    width: Dimensions.screenWidth(context) / 2,
                    controller: _timeIntoController,
                    hintText: 'إلى',
                    headline: '',
                    readOnly: true,
                    isWithoutText: true,
                    textInputType: TextInputType.text,
                    valid: (String? value) {
                      return ValidTextForm().emptyText(value);
                    },
                    onTab: () async {
                      _timeIntoController.clear();

                      _timeIntoController.text =
                          await timePicker(context: context);
                    },
                    icon: const Icon(Icons.access_time_outlined),
                  ),
                ],
              ),
            ),

            CustomTextFormFiled(
              isWithoutText: true,
              context: context,
              controller: _priceController,
              headline: '',
              hintText: 'سعر الخدمة',
              textInputType: TextInputType.number,
              valid: (String? value) {
                return ValidTextForm().emptyText(value);
              },
              icon: const Icon(Icons.price_check),
            ),
            CustomDropDownString(
              hintText: 'الحي/السكن',
              context: context,
              value: _selectAddress,
              valid: (String? value) {
                return ValidTextForm().nullText(value);
              },
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
              controller: _locationController,
              hintText: 'اقرب نقطة دالة',
              headline: '',
              isWithoutText: true,
              textInputType: TextInputType.text,
              valid: (String? value) {
                return ValidTextForm().emptyText(value);
              },
              icon: const Icon(Icons.location_on_outlined),
              maxLines: 2,
              minLines: 2,
            ),

            CustomButton(
              context: context,
              title: 'الترقية لمزود خدمة',
              onPressed: () async {
                if (_createAdvertisement.currentState!.validate()) {
                  try {
                    ServicesProviderCollection servicesProviderCollection =
                        ServicesProviderCollection();
                    final String serviceType = _selectServices!.trim();
                    final String yearsOfExperience =
                        _selectYearsOfExperience!.trim();
                    final String startOfWorkingDays =
                        _selectStartOfWorkingDays!.trim();
                    final String endOfWorkingDays =
                        _selectendOfWorkingDays!.trim();
                    final String startWorkingHours =
                        _timeFromController.text.trim();
                    final String endWorkingHours =
                        _timeIntoController.text.trim();
                    final String servisePrice = _priceController.text.trim();
                    final String address = _selectAddress!.trim();
                    final String location = _locationController.text.trim();
                    int stars = 0;

                    String? image = await FireStorageServises()
                        .uploadAndGetImageToFirebaseStorage(_selectedImage!);
                    ServicesProviderModel servicesProviderModel =
                        ServicesProviderModel(
                      serviceType: serviceType,
                      desc: _titleController.text.trim(),
                      yearsOfExperience: yearsOfExperience,
                      startOfWorkingDays: startOfWorkingDays,
                      endOfWorkingDays: endOfWorkingDays,
                      startWorkingHours: startWorkingHours,
                      endWorkingHours: endWorkingHours,
                      servisePrice: servisePrice,
                      address: address,
                      location: location,
                      stars: stars,
                      image: image,
                    );

                    servicesProviderCollection.addInfoDB(
                      info: servicesProviderModel.toJson(),
                    );

                    final doc = UserManager().userId;
                    final ref = servicesProviderCollection
                        .getServiceProviderDocReference();

                    UserCollection().updateInfoDB(
                      doc: doc,
                      info: {
                        "service_provider_collection": ref,
                        "is_service_provider": serviceProviderWait,
                      },
                    );

                    PostModel postModel = PostModel(
                      serviceProviderCollection: ref,
                      image: image,
                    );

                    PostCollection()
                        .addInfoDB(doc: ref.id, info: postModel.toJson());
                  } catch (e) {
                    print('errorADV ${e.toString()}');
                  }
                }
              },
            ),

            // TextFormField(maxLength: 130, maxLines: 3),
          ],
        ),
      ),
    );
  }
}
