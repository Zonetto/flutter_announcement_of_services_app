import 'package:announcement_of_services/components/buttom_ink_widget.dart';
import 'package:announcement_of_services/module/services_provider_info_model.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';

import 'package:flutter/material.dart';

import 'Category_info_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicesProviderInfoModel servicesProviderInfo =
        ServicesProviderInfoModel().fillServicesProviderInfo();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: servicesProviderInfo.itemsServices!.length,
            itemBuilder: (context, index) {
              final String itemsServices =
                  servicesProviderInfo.itemsServices![index].type;
              final IconData icon =
                  servicesProviderInfo.itemsServices![index].icon;

              return buildCustomButtonInk(context, itemsServices, icon);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCustomButtonInk(
    BuildContext context,
    String itemsServices,
    IconData icon,
  ) {
    return ButtonInkWidget(
      context: context,
      title: itemsServices,
      icon: icon,
      isImage: false,
      onTap: () {
        navigateToScreen(
          context: context,
          screen: CategoriesInfoScreen(
            query: itemsServices,
          ),
        );
      },
    );
  }
}
