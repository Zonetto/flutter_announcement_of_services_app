import 'package:announcement_of_services/components/form/create_advertisement_for_service_form.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:flutter/material.dart';

class AdvertisementForServiceScreen extends StatefulWidget {
  final ServicesProviderModel? servicesProviderModel;
  const AdvertisementForServiceScreen({super.key, this.servicesProviderModel});

  @override
  State<AdvertisementForServiceScreen> createState() =>
      _AdvertisementForServiceScreenState();
}

class _AdvertisementForServiceScreenState
    extends State<AdvertisementForServiceScreen> {
  bool isEdit = false;
  @override
  void initState() {
    isEdit = false;
    if (widget.servicesProviderModel != null) isEdit = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isEdit
        ? CreateOrEditAdvertisementForServiceForm(
            servicesProviderModel: widget.servicesProviderModel,
          )
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: AppSize.padding,
                child: CreateOrEditAdvertisementForServiceForm(
                  servicesProviderModel: widget.servicesProviderModel,
                ),
              ),
            ),
          );

    //  : return Scaffold(
    //     body: CreateOrEditAdvertisementForServiceForm(
    //       servicesProviderModel: widget.servicesProviderModel,
    //     ),
    //   );
  }
}
