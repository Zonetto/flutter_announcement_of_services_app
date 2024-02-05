import 'package:announcement_of_services/components/card_contents_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/lodaing_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);

    if (provider.getAllServiceProviderLst.isEmpty) {
      provider.fetchAllServiceProviderData();
    }
    super.initState();
  }

  // double _averageRating = 0;
  @override
  Widget build(BuildContext context) {
    List<UserDetailsModel> userDatils = [];
    final provider = Provider.of<ViewModelFetch>(context, listen: false);

    if (userDatils.isEmpty) {
      userDatils = context
          .watch<ViewModelFetch>()
          .getAllServiceProviderLst; // provider.fetchAllServiceProviderData();
    }

    return RefreshIndicator(
      onRefresh: () => provider.fetchAllServiceProviderData(),
      child: userDatils.isEmpty
          ? const LoadingScreen()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                    itemCount: userDatils.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final UserDetailsModel user = userDatils[index];
                      final ServicesProviderModel servicesProviderModel =
                          user.servicesProviderModel!;
                      return Column(
                        children: [
                          // AppSize.sizedBoxHeight,
                          CardContentsWidget(
                            isAdmin: false,
                            backgroundImagePath: servicesProviderModel.image,
                              yearsOfExperience:
                                servicesProviderModel.yearsOfExperience,
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
                                  serviceProviderCollection: user.userId,
                                  title: servicesProviderModel.desc,
                                  stars: servicesProviderModel.stars.toString(),
                                  address: servicesProviderModel.address,
                                  startOfWorkingDays:
                                      servicesProviderModel.startOfWorkingDays,
                                  endOfWorkingDays:
                                      servicesProviderModel.endOfWorkingDays,
                                  startWorkingHours:
                                      servicesProviderModel.startWorkingHours,
                                  endWorkingHours:
                                      servicesProviderModel.endWorkingHours,
                                  fullName: user.fullName,
                                  image: user.profileImage,
                                  location: servicesProviderModel.location,
                                  serviceType:
                                      servicesProviderModel.serviceType,
                                  servisePrice:
                                      servicesProviderModel.servisePrice,
                                  yearsOfExperience:
                                      servicesProviderModel.yearsOfExperience,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

// هاشم علي الرضاوي

double calculateAverageRating({required List<double> ratings}) {
  if (ratings.isEmpty) {
    return 0.0;
  }
  double sum = ratings.reduce((value, element) => value + element);
  return sum / ratings.length;
}
