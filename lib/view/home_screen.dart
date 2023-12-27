import 'package:announcement_of_services/components/complex_card.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:flutter/material.dart';

import 'service_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserDetailsModel>>(
      stream:
          UserCollection().getchAllServiceProviderData(), //userDetails1,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('err');
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final UserDetailsModel user = snapshot.data![index];
              final ServicesProviderModel servicesProviderModel =
                  user.servicesProviderModel;
              return ComplexCard(
                isAdmin: false,
                backgroundImagePath: servicesProviderModel.image!,
                name: user.fullName,
                price: servicesProviderModel.servisePrice,
                profileImagePath: user.profileImage,
                star: servicesProviderModel.stars.toString(),
                title: servicesProviderModel.desc,
                onTap: () {
                  navigatePushScreen(
                    context: context,
                    screen: ServiceDetailsScreen(
                      call: user.call,
                      dateOfBirth: user.dateOfBirth,
                      email: user.email,
                      stars: servicesProviderModel.stars,
                      address: servicesProviderModel.address,
                      startOfWorkingDays:
                          servicesProviderModel.startOfWorkingDays,
                      endOfWorkingDays: servicesProviderModel.endOfWorkingDays,
                      startWorkingHours:
                          servicesProviderModel.startWorkingHours,
                      endWorkingHours: servicesProviderModel.endWorkingHours,
                      fullName: user.fullName,
                      image: user.profileImage,
                      location: servicesProviderModel.location,
                      serviceType: servicesProviderModel.serviceType,
                      servisePrice: servicesProviderModel.servisePrice,
                      yearsOfExperience:
                          servicesProviderModel.yearsOfExperience,
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );

    // return ListView.builder(
    //   itemCount: 10,
    //   scrollDirection: Axis.vertical,
    //   itemBuilder: (context, index) {
    //     return const ComplexCard(
    //       backgroundImagePath: null,
    //       name: 'Ahmed Saad',
    //       price: "50",
    //       profileImagePath: null,
    //       star: ' 3.5',
    //       title: 'بناء كاونتر حسب القياس',
    //       isAdmin: false,
    //     );
    //   },
    // );
  }
}

// هاشم علي الرضاوي
