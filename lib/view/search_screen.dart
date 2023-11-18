import 'package:announcement_of_services/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final TextEditingController searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
        )
      ],
    );
  }
}
