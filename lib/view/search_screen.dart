import 'package:announcement_of_services/components/card_contents_widget.dart';
import 'package:announcement_of_services/components/text_form_field_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/service_details_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  // bool _resultSearch = false;

  @override
  Widget build(BuildContext context) {
    List<UserDetailsModel> userDatils = [];
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    userDatils = context.watch<ViewModelFetch>().getAllUserDetails;
    return Column(
      children: [
        AppSize.sizedBoxHeight,
        TextFormFieldWidget(
          context: context,
          controller: _searchController,
          headline: '',
          hintText: 'البحث عن الخدمات',
          textInputType: TextInputType.text,
          icon: const Icon(Icons.search),
          isWithoutText: true,
          onChanged: (String? query) {
            if (query != null && query.isNotEmpty) {
              // _resultSearch = false;
              provider.fetchAllUserDetailsData(query: query);
              // fetch(query: query);
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        userDatils.isEmpty
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
                    return CardContents(
                      isAdmin: false,
                      backgroundImagePath: servicesProviderModel.image,
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
              ),
      ],
    );
  }
}
