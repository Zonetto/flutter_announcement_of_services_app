import 'package:announcement_of_services/components/card_contents_widget.dart';
import 'package:announcement_of_services/components/radio_list_tile_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/services_provider_info_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/alert_dialog.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/service_details_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesInfoScreen extends StatefulWidget {
  final String query;
  const CategoriesInfoScreen({
    super.key,
    required this.query,
  });

  @override
  State<CategoriesInfoScreen> createState() => _CategoriesInfoScreenState();
}

ServicesProviderInfoModel servicesProviderInfoModel =
    ServicesProviderInfoModel.fromJson(servicesProviderInfo);

class _CategoriesInfoScreenState extends State<CategoriesInfoScreen> {
  List<String> rating = <String>['1', '2', '3', '4', '5'];
  List<String> yearsOfExperienceLst =
      servicesProviderInfoModel.itemsYearsOfExperience!;
  List<String> addressLst = servicesProviderInfoModel.itemsAddress!;
  String? _selectedRating;
  String? _selectedAddress;
  String? _selectedYearsOfExperience;
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
    // userDetails = context.watch<ViewModelFetch>().getAllUserDetails;
    // TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            highlightColor: AppColor.green,
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              alertDialog(
                context: context,
                title: 'تصفية حسب',
                widget: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const TextWidget(title: 'الموقع'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return RadioListTileWidget(
                              lst: addressLst,
                              selectedRadio: _selectedAddress,
                              onChanged: (String? value) {
                                _selectedAddress = value;
                              },
                            );
                          },
                        ),
                      ),
                      const Divider(indent: 3),
                      const TextWidget(title: 'التقييم'),
                      Expanded(
                        child: RadioListTileWidget(
                          lst: rating,
                          selectedRadio: _selectedRating,
                          onChanged: (String? value) {
                            _selectedRating = value;
                          },
                        ),
                      ),
                      const Divider(indent: 3),
                      const TextWidget(title: 'الخبرة'),
                      Expanded(
                        child: RadioListTileWidget(
                          lst: yearsOfExperienceLst,
                          selectedRadio: _selectedYearsOfExperience,
                          onChanged: (String? value) {
                            _selectedYearsOfExperience = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  print(addressLst[int.parse(_selectedAddress.toString())]);
                  print(yearsOfExperienceLst[
                      int.parse(_selectedYearsOfExperience.toString())]);
                },
              );
            },
          ),
        ],

        //toolbarHeight: 12,
      ),
      body: Padding(
        padding: AppSize.padding,
        child: Consumer<ViewModelFetch>(
          builder: (context, model, child) {
            userDetails = model.getAllUserDetails;
            return buildBody();
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    return userDetails.isEmpty
        ? Center(
            child: TextWidget(
              title: 'لا يوجد نتائج',
              size: FontSize.subtitle(context),
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: userDetails.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final UserDetailsModel user = userDetails[index];
                final ServicesProviderModel servicesProviderModel =
                    user.servicesProviderModel!;
                return buildComplexCard(context, user, servicesProviderModel);
              },
            ),
          );
  }

  Widget buildUserDetailsListView(List<UserDetailsModel> userDetails) {
    return !isNotEmptyData
        ? Center(
            child: TextWidget(
              title: 'لا يوجد نتائج',
              size: FontSize.subtitle(context),
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: userDetails.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final UserDetailsModel user = userDetails[index];
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
      price: servicesProviderModel.servicePrice,
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
            servicePrice: servicesProviderModel.servicePrice,
            yearsOfExperience: servicesProviderModel.yearsOfExperience,
          ),
        );
      },
    );
  }
}
