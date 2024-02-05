import 'package:announcement_of_services/components/buttom_ink_widget.dart';
import 'package:announcement_of_services/components/card_contents_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/services_provider_info_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service_details_screen.dart';

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
      BuildContext context, String itemsServices, IconData icon) {
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

class CategoriesInfoScreen extends StatefulWidget {
  final String query;
  const CategoriesInfoScreen({
    super.key,
    required this.query,
  });

  @override
  State<CategoriesInfoScreen> createState() => _CategoriesInfoScreenState();
}

class _CategoriesInfoScreenState extends State<CategoriesInfoScreen> {
  bool isNotEmptyData = false;
  List<UserDetailsModel> userDetails = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    userDetails.clear();
    super.dispose();
  }

  Future<void> fetchData() async {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    final bool a = await provider.fetchAllUserDetailsData(query: widget.query);
    setState(() {
      isNotEmptyData = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    userDetails = context.watch<ViewModelFetch>().getAllUserDetails;

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (userDetails.isEmpty)
          Center(
            child: TextWidget(
              title: 'لا يوجد نتائج',
              size: FontSize.subtitle(context),
            ),
          ),
        if (userDetails.isNotEmpty)
          Expanded(
            child: buildUserDetailsListView(userDetails),
          ),
      ],
    ));
  }

  Widget buildUserDetailsListView(List<UserDetailsModel> userDatils) {
    return !isNotEmptyData
        ? Center(
            child: TextWidget(
              title: 'لا يوجد نتائج',
              size: FontSize.subtitle(context),
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: userDatils.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final UserDetailsModel user = userDatils[index];
                final ServicesProviderModel servicesProviderModel =
                    user.servicesProviderModel!;

                return buildComplexCard(context, user, servicesProviderModel);
              },
            ),
          );
  }

  Widget buildComplexCard(BuildContext context, UserDetailsModel user,
      ServicesProviderModel servicesProviderModel) {
    return CardContentsWidget(
      isAdmin: false,
      backgroundImagePath: servicesProviderModel.image,
      yearsOfExperience: servicesProviderModel.yearsOfExperience,
      name: user.fullName,
      price: servicesProviderModel.servisePrice,
      profileImagePath: user.profileImage,
      star: servicesProviderModel.stars.toString(),
      title: servicesProviderModel.desc,
      onTap: () {
        navigateToScreen(
          context: context,
          screen: ServiceDetailsScreen(
            call: user.call,
            dateOfBirth: user.dateOfBirth,
            email: user.email,
            title: servicesProviderModel.desc,
            stars: servicesProviderModel.stars.toString(),
            address: servicesProviderModel.address,
            startOfWorkingDays: servicesProviderModel.startOfWorkingDays,
            endOfWorkingDays: servicesProviderModel.endOfWorkingDays,
            startWorkingHours: servicesProviderModel.startWorkingHours,
            endWorkingHours: servicesProviderModel.endWorkingHours,
            fullName: user.fullName,
            image: user.profileImage,
            location: servicesProviderModel.location,
            serviceType: servicesProviderModel.serviceType,
            servisePrice: servicesProviderModel.servisePrice,
            yearsOfExperience: servicesProviderModel.yearsOfExperience,
          ),
        );
      },
    );
  }
}
