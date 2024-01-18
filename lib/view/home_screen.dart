import 'package:announcement_of_services/components/complex_card.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/services/collections/services_provider_collection.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'service_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // double _averageRating = 0;
  @override
  Widget build(BuildContext context) {
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
              final ServicesProviderModel servicesProvider =
                  user.servicesProviderModel;
              double ratingStar = 3;
              ratingStar = double.tryParse(servicesProvider.stars) ?? 0.0;
              // List<double> ratings = [];
              // ratings.add(_ratingStar);
              // _averageRating = calculateAverageRating(ratings: ratings);

              return Column(
                children: [
                  AppSize.sizedBoxHeight,
                  ComplexCard(
                    isAdmin: false,
                    backgroundImagePath: servicesProvider.image,
                    name: user.fullName,
                    price: servicesProvider.servisePrice,
                    profileImagePath: user.profileImage,
                    star: ratingStar.toString(),
                    title: servicesProvider.desc,
                    onTap: () {
                      navigateToScreen(
                        context: context,
                        screen: ServiceDetailsScreen(
                          // averageRating: _ratingStar,
                          call: user.call,
                          dateOfBirth: user.dateOfBirth,
                          onPressedRating: () async {
                            final String? doc =
                                user.servicesProviderModel.serviceProviderId;
                            // print(doc);

                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('تقييم'),
                                  content: ListTile(
                                    title: RatingBar.builder(
                                      onRatingUpdate: (newValue) {
                                        setState(() {
                                          ratingStar = newValue;
                                        });
                                      },
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star_rounded,
                                        color: AppColor.buttonColorGreen,
                                      ),
                                      direction: Axis.horizontal,
                                      initialRating: 3,
                                      unratedColor: AppColor.buttonColorRed,
                                      itemCount: 5,
                                      itemSize: 40,
                                    ),
                                    subtitle: TextWidget(
                                      alignment: TextAlign.center,
                                      title: ratingStar.toString(),
                                      size: FontSize.plainText,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const TextWidget(
                                          title: 'لا',
                                          size: FontSize.plainText),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await ServicesProviderCollection()
                                            .updateRatingDB(
                                          doc: doc,
                                          info: {
                                            'stars': ratingStar.toString()
                                          },
                                        );
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      },
                                      child: const TextWidget(
                                        title: 'نعم',
                                        size: FontSize.plainText,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          email: user.email,
                          stars: ratingStar.toString(),
                          address: servicesProvider.address,
                          startOfWorkingDays:
                              servicesProvider.startOfWorkingDays,
                          endOfWorkingDays: servicesProvider.endOfWorkingDays,
                          startWorkingHours: servicesProvider.startWorkingHours,
                          endWorkingHours: servicesProvider.endWorkingHours,
                          fullName: user.fullName,
                          image: user.profileImage,
                          location: servicesProvider.location,
                          serviceType: servicesProvider.serviceType,
                          servisePrice: servicesProvider.servisePrice,
                          yearsOfExperience: servicesProvider.yearsOfExperience,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
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
