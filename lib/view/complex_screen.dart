import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/view/categories_creen.dart';
import 'package:announcement_of_services/view/search_screen.dart';
import 'package:announcement_of_services/view_model/view_model_fetch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'advertisement_for_service_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class ComplexScreen extends StatefulWidget {
  const ComplexScreen({super.key});

  @override
  State<ComplexScreen> createState() => _ComplexScreenState();
}

class _ComplexScreenState extends State<ComplexScreen> {
  int index = 0;
  final List<StatefulWidget> screenlst = [
    const HomeScreen(),
    const SearchScreen(),
    const CategoriesScreen(),
    const AdvertisementForServiceScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    Provider.of<ViewModelFetch>(context, listen: false).fetchUserDetailsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white70,
        indicatorColor: Colors.green.withOpacity(0.5),
        shadowColor: Colors.red,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 30, color: Colors.black),
            label: "الرئيسي",
          ),
          NavigationDestination(
            icon: Icon(Icons.search, size: 30, color: Colors.black),
            label: "البحث",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.grid_view,
              size: 30,
              color: Colors.black,
            ),
            label: "الفئات",
          ),
          NavigationDestination(
            icon: Icon(Icons.ads_click_outlined, size: 30, color: Colors.black),
            label: "إعلان",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined, size: 30, color: Colors.black),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
