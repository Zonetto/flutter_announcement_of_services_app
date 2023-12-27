import 'package:announcement_of_services/components/complex_card.dart';
import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/collections/user_collection.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/service_details_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final TextEditingController searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  // @override
  // void initState() {
  //   Provider.of<ViewModelFetch>(context, listen: false)
  //       .fetchAllUserDetailsData();
  //   super.initState();
  // }

  List<UserDetailsModel> _userDatils = [];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    //  _userDatils = context.watch<ViewModelFetch>().getAllUserDetails;
    // _userDatils = context.watch<ViewModelFetch>().getAllUserDetails;
    return Column(
      children: [
        CustomTextFormFiled(
          context: context,
          controller: searchController,
          headline: '',
          hintText: 'أبحث عن الخدمات',
          textInputType: TextInputType.text,
          valid: (value) {},
          icon: const Icon(Icons.search),
          isWithoutText: true,
          onChanged: (String? query) {
            //_userDatils?.clear();
            //  provider.fetchAllUserDetailsData(query: query);
            //  UserDetailsModel u;
            UserCollection().fetchAllDB(query: query)?.then((value) {
              setState(() {
                _userDatils = value??[];
              });
               print(_userDatils[0].servicesProviderModel.desc);
            });
            //print(u.email);
          },
        ),
        const SizedBox(height: 10),
        _userDatils.isEmpty
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: _userDatils?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final UserDetailsModel user = _userDatils![index];
                  final ServicesProviderModel? servicesProviderModel =
                      user?.servicesProviderModel;
                  return ComplexCard(
                    isAdmin: false,
                    backgroundImagePath: servicesProviderModel!.image,
                    name: user?.fullName ?? '',
                    price: servicesProviderModel.servisePrice,
                    profileImagePath: user?.profileImage ?? '',
                    star: servicesProviderModel.stars.toString(),
                    title: servicesProviderModel.desc,
                    onTap: () {
                      navigatePushScreen(
                        context: context,
                        screen: ServiceDetailsScreen(
                          call: user?.call ?? 0,
                          dateOfBirth: user?.dateOfBirth ?? '',
                          email: user?.email ?? '',
                          stars: servicesProviderModel.stars,
                          address: servicesProviderModel.address,
                          startOfWorkingDays:
                              servicesProviderModel.startOfWorkingDays,
                          endOfWorkingDays:
                              servicesProviderModel.endOfWorkingDays,
                          startWorkingHours:
                              servicesProviderModel.startWorkingHours,
                          endWorkingHours:
                              servicesProviderModel.endWorkingHours,
                          fullName: user?.fullName ?? '',
                          image: user?.profileImage ?? '',
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
              ),
      ],
    );
  }
}
