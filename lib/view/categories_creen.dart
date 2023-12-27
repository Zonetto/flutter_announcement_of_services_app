import 'package:announcement_of_services/components/custom_buttom_ink.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
