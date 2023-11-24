import 'package:announcement_of_services/components/custom_buttom_ink.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonInk(
          context: context,
          title: 'خدمات تصليح السيارات',
          imagePath: 'assets/images/cleaning.png',
          onTap: () {},
        ),
      ],
    );
  }
}
