import 'dart:io';
import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/dropdown_widget.dart';
import 'package:announcement_of_services/components/image_widget.dart';
import 'package:announcement_of_services/components/text_form_field_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/services_provider_info_model.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/services/fire_storage_servises.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/date_picker.dart';
import 'package:announcement_of_services/utils/fill_dropdown_items.dart';
import 'package:announcement_of_services/utils/pick_image.dart';
import 'package:announcement_of_services/utils/styled_scaffold_messenger.dart';
import 'package:announcement_of_services/utils/validate.dart';
import 'package:announcement_of_services/view_model/app_status.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateOrEditAdvertisementForServiceForm extends StatefulWidget {
  final ServicesProviderModel? servicesProviderModel;
  const CreateOrEditAdvertisementForServiceForm(
      {super.key, this.servicesProviderModel});

  @override
  State<CreateOrEditAdvertisementForServiceForm> createState() =>
      _CreateOrEditAdvertisementForServiceFormState();
}

List<DropdownMenuItem<String>> fillDropdownItems1(
    List<ItemsServices> itemsServices) {
  return itemsServices.map((item) {
    return DropdownMenuItem<String>(
      value: item.type,
      child: Text(item.type),
    );
  }).toList();
}

class _CreateOrEditAdvertisementForServiceFormState
    extends State<CreateOrEditAdvertisementForServiceForm> {
  final GlobalKey<FormState> _createAdvertisementKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeFromController = TextEditingController();
  final TextEditingController _timeIntoController = TextEditingController();
  String? backgroundImage;

  List<DropdownMenuItem<String>>? dropdownItemsServices;
  List<DropdownMenuItem<String>>? dropdownItemsYearsOfExperience;
  List<DropdownMenuItem<String>>? dropdownItemsStartOfWorkingDays;
  List<DropdownMenuItem<String>>? dropdownItemsEndOfWorkingDays;
  List<DropdownMenuItem<String>>? dropdownItemsAddress;

  String? _selectServices;
  String? _selectYearsOfExperience;
  String? _selectStartOfWorkingDays;
  String? _selectedOfWorkingDays;
  String? _selectAddress;
  File? _selectedImage;
  bool isEdit = false;
  bool _loading = false;
  @override
  void dispose() {
    _createAdvertisementKey.currentState?.dispose();
    _priceController.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _timeFromController.dispose();
    _timeIntoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final ServicesProviderModel? servicesProviderModel =
        widget.servicesProviderModel;

    isEdit = false;
    if (widget.servicesProviderModel != null) isEdit = true;
    if (servicesProviderModel != null) {
      _priceController.text = servicesProviderModel.servicePrice;
      _titleController.text = servicesProviderModel.desc;
      _locationController.text = servicesProviderModel.location;
      _timeFromController.text = servicesProviderModel.startWorkingHours;
      _timeIntoController.text = servicesProviderModel.endWorkingHours;
      backgroundImage = servicesProviderModel.image;
      _selectServices = servicesProviderModel.serviceType;
      _selectYearsOfExperience = servicesProviderModel.yearsOfExperience;
      _selectStartOfWorkingDays = servicesProviderModel.startOfWorkingDays;
      _selectedOfWorkingDays = servicesProviderModel.endOfWorkingDays;
      _selectAddress = servicesProviderModel.address;
    } else {
      _priceController.clear();
      _locationController.clear();
      _timeFromController.clear();
      _timeIntoController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    final ServicesProviderInfoModel servicesProviderInfo =
        ServicesProviderInfoModel().fillServicesProviderInfo();

    dropdownItemsServices =
        fillDropdownItems1(servicesProviderInfo.itemsServices!);
    dropdownItemsYearsOfExperience =
        fillDropdownItems(servicesProviderInfo.itemsYearsOfExperience!);
    dropdownItemsStartOfWorkingDays =
        fillDropdownItems(servicesProviderInfo.itemsStartOfWorkingDays!);
    dropdownItemsEndOfWorkingDays =
        fillDropdownItems(servicesProviderInfo.itemsStartOfWorkingDays!);

    dropdownItemsAddress =
        fillDropdownItems(servicesProviderInfo.itemsAddress!);
    return Form(
      key: _createAdvertisementKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSize.sizedBoxHeight,
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
              child: ImageWidget1(
                imagePathNetwork:
                    _selectedImage == null ? backgroundImage : null,
                imagePathLocal: _selectedImage,
                // disabled: _loading ? true : false,
                isEdit: !_loading ? true : false,
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
            TextFormFieldWidget(
              isWithoutText: true,
              context: context,
              readOnly: _loading ? true : false,
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
            DropdownStringWidget(
              hintText: 'نوع الخدمة',
              context: context,
              value: _selectServices,
              disabled: _loading ? true : false,
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
            DropdownStringWidget(
              hintText: 'سنوات الخبرة',
              context: context,
              value: _selectYearsOfExperience,
              disabled: _loading ? true : false,
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
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Row(
                      children: [
                        TextWidget(
                          title: 'إيام العمل',
                          size: FontSize.plainText(context),
                        ),
                        const Spacer(),
                        const Icon(Icons.date_range_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  DropdownStringWidget(
                    hintText: 'من',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    disabled: _loading ? true : false,
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
                  DropdownStringWidget(
                    hintText: 'إلى',
                    width: Dimensions.screenWidth(context) / 2,
                    context: context,
                    disabled: _loading ? true : false,
                    value: _selectedOfWorkingDays,
                    valid: (String? value) {
                      return ValidTextForm().nullText(value);
                    },
                    onChanged: (value) {
                      setState(() {
                        _selectedOfWorkingDays = value!;
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
                    width: Dimensions.screenWidth(context) / 2.5,
                    margin: const EdgeInsets.only(bottom: 14.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Row(
                      children: [
                        TextWidget(
                          title: 'ساعات العمل',
                          size: FontSize.plainText(context),
                        ),
                        const Spacer(),
                        const Icon(Icons.date_range_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextFormFieldWidget(
                    context: context,
                    width: Dimensions.screenWidth(context) / 2,
                    controller: _timeFromController,
                    readOnly: true,
                    hintText: 'من',
                    headline: '',
                    isWithoutText: true,
                    textInputType: TextInputType.text,
                    valid: (String? value) {
                      return ValidTextForm().emptyText(value);
                    },
                    onTab: !_loading
                        ? () async {
                            _timeFromController.clear();

                            _timeFromController.text =
                                await timePicker(context: context);
                          }
                        : null,
                    icon: const Icon(Icons.access_time_outlined),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  TextFormFieldWidget(
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
                    onTab: !_loading
                        ? () async {
                            _timeIntoController.clear();

                            _timeIntoController.text =
                                await timePicker(context: context);
                          }
                        : null,
                    icon: const Icon(Icons.access_time_outlined),
                  ),
                ],
              ),
            ),

            TextFormFieldWidget(
              isWithoutText: true,
              context: context,
              controller: _priceController,
              readOnly: _loading ? true : false,
              headline: '',
              hintText: 'سعر الخدمة',
              textInputType: TextInputType.number,
              valid: (String? value) {
                return ValidTextForm().emptyText(value);
              },
              icon: const Icon(Icons.price_check),
            ),
            DropdownStringWidget(
              hintText: 'الحي/السكن',
              context: context,
              value: _selectAddress,
              disabled: _loading ? true : false,
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
            TextFormFieldWidget(
              context: context,
              controller: _locationController,
              hintText: 'اقرب نقطة دالة',
              headline: '',
              readOnly: _loading ? true : false,
              isWithoutText: true,
              textInputType: TextInputType.text,
              valid: (String? value) {
                return ValidTextForm().emptyText(value);
              },
              icon: const Icon(Icons.location_on_outlined),
              maxLines: 2,
              minLines: 2,
            ),

            ButtonWidget(
              context: context,
              title: isEdit ? 'تم' : 'الترقية لمزود خدمة',
              isLoad: _loading,
              onPressed: () async {
                if (!_createAdvertisementKey.currentState!.validate()) {
                  return;
                }

                // try {
                setState(() {
                  _loading = true;
                });
                // print(_loading);
                _createAdvertisementKey.currentState!.save();
                Result result;
                ServicesProviderCollection servicesProviderCollection =
                    ServicesProviderCollection();

                final String serviceType = _selectServices!.trim();
                final String yearsOfExperience =
                    _selectYearsOfExperience!.trim();
                final String startOfWorkingDays =
                    _selectStartOfWorkingDays!.trim();
                final String endOfWorkingDays = _selectedOfWorkingDays!.trim();
                final String startWorkingHours =
                    _timeFromController.text.trim();
                final String endWorkingHours = _timeIntoController.text.trim();
                final String servisePrice = _priceController.text.trim();
                final String address = _selectAddress!.trim();
                final String location = _locationController.text.trim();
                String stars = "0.0";
                String? image;
                if (_selectedImage != null) {
                  image = await FireStorageServices()
                      .uploadAndGetImageToFirebaseStorage(_selectedImage!);
                } else {
                  image = backgroundImage;
                }

                final DocumentReference? serviceProviderId = !isEdit
                    ? servicesProviderCollection
                        .getServiceProviderDocReference()
                    : null;

                final String? serviceProviderIdisEdit = isEdit
                    ? widget.servicesProviderModel!.serviceProviderId.toString()
                    : null;

                ServicesProviderModel servicesProviderModel =
                    ServicesProviderModel(
                  serviceProviderId:
                      serviceProviderId?.id ?? serviceProviderIdisEdit,
                  serviceType: serviceType,
                  desc: _titleController.text.trim(),
                  yearsOfExperience: yearsOfExperience,
                  startOfWorkingDays: startOfWorkingDays,
                  endOfWorkingDays: endOfWorkingDays,
                  startWorkingHours: startWorkingHours,
                  endWorkingHours: endWorkingHours,
                  servicePrice: servisePrice,
                  address: address,
                  location: location,
                  stars: stars,
                  image: image,
                );

                final userManager = UserManager().userId;
                if (!isEdit) {
                  if (backgroundImage != null) {
                    result = await servicesProviderCollection.addInfoDB(
                      doc: serviceProviderId!.id,
                      info: servicesProviderModel.toJson(),
                    );
                    if (result is Success) {
                      // final ref = servicesProviderCollection;

                      UserCollection().updateInfoDB(
                        doc: userManager,
                        info: {
                          "service_provider_collection": serviceProviderId,
                          "is_service_provider": serviceProviderWait,
                        },
                      );
                    }
                    if (result is Error) {
                      setState(() {
                        _loading = false;
                      });
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    styledScaffoldMessenger(
                        context: context,
                        message: 'يجب اختيار صورة',
                        color: AppColor.buttonColorRed);
                  }
                }
                if (isEdit) {
                  // final String doc =
                  //     widget.servicesProviderModel!.serviceProviderId!;
                  //   print(doc);
                  result = await servicesProviderCollection.updateInfoDB(
                    doc: serviceProviderIdisEdit,
                    info: servicesProviderModel.toJson(),
                  );

                  if (result is Success) {
                    UserCollection().updateInfoDB(
                      doc: userManager,
                      info: {
                        "is_service_provider": serviceProviderWait,
                      },
                    );
                    provider.setServicesProviderLst = null;
                    provider.fetchSpecificUserDetailsData();
                    provider.fetchSpecificServerProviderData();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                  if (result is Error) {
                    setState(() {
                      _loading = false;
                    });
                  }
                }

                //.addInfoDB(doc: ref.id, info: postModel.toJson());
                // } catch (e) {
                //   print('errorADV ${e.toString()}');
                // }
              },
            ),
            AppSize.sizedBoxHeight,
            // TextFormField(maxLength: 130, maxLines: 3),
          ],
        ),
      ),
    );
  }
}

// صباغة شبابيك المنازل