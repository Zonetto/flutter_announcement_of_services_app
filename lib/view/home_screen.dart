import 'package:announcement_of_services/components/complex_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return const ComplexCard(
          backgroundImagePath: 'assets/images/repairing-computer.jpg',
          name: 'Ahmed Saad',
          price: 50,
          profileImagePath: 'assets/images/woman.jpg',
          star: 3.5,
          title: 'بناء كاونتر حسب القياس',
        );
      },
    );
  }
}

// هاشم علي الرضاوي
