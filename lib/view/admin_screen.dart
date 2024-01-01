import 'package:announcement_of_services/components/complex_card.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/service_details_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => SserviceDetailsScreenState();
}

class SserviceDetailsScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<List<UserDetailsModel>> userDetails =
        UserCollection().getAllServiceProviderData_admin();

    return StreamBuilder<List<UserDetailsModel>>(
      stream: userDetails, //userDetails1,
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
              final String doc = user.userId;
              final ServicesProviderModel servicesProviderModel =
                  user.servicesProviderModel;
              return ComplexCard(
                onPressedAccept: () {
                  UserCollection().updateInfoDB(
                    doc: doc,
                    info: {
                      "is_service_provider": serviceProviderAccept,
                    },
                  );
                },
                onPressedRejection: () {
                  UserCollection().updateInfoDB(
                    doc: doc,
                    info: {
                      "is_service_provider": serviceProviderUnaccepted,
                    },
                  );
                },
                onPressedWait: () {
                  UserCollection().updateInfoDB(
                    doc: doc,
                    info: {
                      "is_service_provider": serviceProviderWait,
                    },
                  );
                },
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
                      stars: servicesProviderModel.stars.toString(),
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
  }
}
