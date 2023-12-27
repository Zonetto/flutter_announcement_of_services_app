import 'dart:io';
import 'package:announcement_of_services/components/custom_buttom.dart';
import 'package:announcement_of_services/components/custom_dropdown.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/components/form/create_advertisement_for_service_form.dart';
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
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementForServiceScreen extends StatefulWidget {
  const AdvertisementForServiceScreen({super.key});

  @override
  State<AdvertisementForServiceScreen> createState() =>
      _AdvertisementForServiceScreenState();
}

class _AdvertisementForServiceScreenState
    extends State<AdvertisementForServiceScreen> {
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();
  // final TextEditingController _timeFromController = TextEditingController();
  // final TextEditingController _timeIntoController = TextEditingController();
  // List<DropdownMenuItem<String>>? dropdownItemsServices;
  // List<DropdownMenuItem<String>>? dropdownItemsYearsOfExperience;
  // List<DropdownMenuItem<String>>? dropdownItemsStartOfWorkingDays;
  // List<DropdownMenuItem<String>>? dropdownItemsEndOfWorkingDays;
  // List<DropdownMenuItem<String>>? dropdownItemsAddress;

  // String? _selectServices;
  // String? _selectYearsOfExperience;
  // String? _selectStartOfWorkingDays;
  // String? _selectendOfWorkingDays;
  // String? _selectAddress;
  // File? _selectedImage;

  // @override
  // void dispose() {
  //   _priceController.dispose();
  //   _locationController.dispose();
  //   _timeFromController.dispose();
  //   _timeIntoController.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   _priceController.clear();
  //   _locationController.clear();
  //   _timeFromController.clear();
  //   _timeIntoController.clear();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return const CreateAdvertisementForServiceForm();
  }
}
