import 'package:announcement_of_services/components/complex_card.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'service_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _ratingStar = 3;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    return StreamBuilder<List<UserDetailsModel>>(
      stream: UserCollection().getchAllServiceProviderData(), //userDetails1,
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
                backgroundImagePath: servicesProviderModel.image,
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
                      onPressedRating: () async {
                        final String? doc =
                            user.servicesProviderModel.serviceProviderId;
                        print(doc);

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('تقييم'),
                              content: RatingBar.builder(
                                onRatingUpdate: (newValue) => setState(
                                  () {
                                    _ratingStar = newValue;
                                  //  print(_ratingStar);
                                  },
                                ),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star_rounded,
                                  color: AppColor.buttonColorGreen,
                                ),
                                direction: Axis.horizontal,
                                initialRating: 3,
                                unratedColor: AppColor.buttonColorRed,
                                itemCount: 5,
                                itemSize: 40,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CustomText(
                                      title: 'لا', size: FontSize.plainText),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await ServicesProviderCollection()
                                        .updateRatingDB(
                                      doc: 'W5ZeWFpnbYFCAFar3jWG',
                                      info: {'stars': _ratingStar.toString()},
                                    );
                                  },
                                  child: const CustomText(
                                      title: 'نعم', size: FontSize.plainText),
                                ),
                              ],
                            );
                          },
                        );
                        // RatingBar.builder(
                        //   onRatingUpdate: (newValue) => setState(
                        //     () => _ratingStar = newValue,
                        //   ),
                        //   itemBuilder: (context, index) => const Icon(
                        //     Icons.star_rounded,
                        //     color: AppColor.buttonColorGreen,
                        //   ),
                        //   direction: Axis.horizontal,
                        //   initialRating: 3,
                        //   unratedColor: AppColor.buttonColorRed,
                        //   itemCount: 5,
                        //   itemSize: 40,
                        //   glowColor: Colors.deepOrange,
                        // );
                      },
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
