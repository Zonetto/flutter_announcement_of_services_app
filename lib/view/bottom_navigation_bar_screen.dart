import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/view/search_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'advertising_complex.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// This class represents the main screen with a bottom navigation bar.
class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

/// The state for the [BottomNavigationBarScreen] widget.
class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int index = 0;
  final List screenlst = [
    const HomeScreen(),
    SearchScreen(),
    //const  AdvertisementForServiceInfoScreenView(),
    const CategoriesScreen(),
    AdvertisingComplex(), //const AdvertisementForServiceScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    final provider = Provider.of<ViewModelFetch>(context, listen: false);
    provider.fetchSpecificServerProviderData();
    provider.fetchSpecificUserDetailsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 12),
      //  backgroundColor: AppColor.colorTextButtonWhite,
      body: SafeArea(
        child: Padding(
          padding: AppSize.padding,
          child: screenlst[index],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onDestinationSelected: (index) => setState(() => this.index = index),
        //  backgroundColor: Colors.white,
        //  surfaceTintColor: Colors.white70,
        indicatorColor: Colors.green.withOpacity(0.5),
        // shadowColor: Colors.red,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "الرئيسي",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "البحث",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.grid_view,
            ),
            label: "الفئات",
          ),
          NavigationDestination(
            icon: Icon(Icons.ads_click_outlined),
            label: "إعلان",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
