import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/view/admin_screen.dart';
import 'package:announcement_of_services/view/advertisement_for_service_screen.dart';
import 'package:announcement_of_services/view/request_screen.dart';
import 'package:announcement_of_services/view/wait_screen.dart';
import 'package:flutter/material.dart';
import 'advertisement_for_service_info_screen.dart';
import 'lodaing_screen.dart';

class AdvertisingComplex extends StatelessWidget {
  AdvertisingComplex({super.key});

  final Stream<UserModel> stateIsServiceProvider =
      UserCollection().stateIsServiceProvider()!;

  @override
  Widget build(BuildContext context) {
    String isServiceProvider = serviceProviderUnaccepted;
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'الاعلان عن خدمة'),
                Tab(text: 'طلباتي'),
                Tab(text: 'الطلبات')
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder<UserModel>(
                    stream: stateIsServiceProvider,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else if (snapshot.hasError) {
                        return const Text('');
                      } else {
                        final UserModel? userDetails = snapshot.data;

                        if (userDetails == null) {
                          return const LoadingScreen();
                        }

                        isServiceProvider = userDetails.isServiceProvider;
                        final String role = userDetails.role!;

                        return role == "ADMIN"
                            ? const AdminScreen()
                            : isServiceProvider == serviceProviderUnaccepted
                                ? const AdvertisementForServiceScreen()
                                : isServiceProvider == serviceProviderAccept
                                    ? const AdvertisementForServiceInfoScreen()
                                    : const WaitScreen();
                      }
                    },
                  ),
                  const RequestScreen(),
                  const RequestScreen(isServiceProvider: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
