import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.buttonColorGrey,
            ),
            child: const Row(
              children: [
                CustomText(
                  title: 'إيام العمل',
                  size: FontSize.plainText,
                ),
                //  Spacer(),
                Icon(Icons.date_range_outlined),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.buttonColorGrey,
            ),
            child: const Row(
              children: [
                CustomText(
                  title: 'إيام العمل',
                  size: FontSize.plainText,
                ),
                //  Spacer(),
                Icon(Icons.date_range_outlined),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.buttonColorGrey,
            ),
            child: const Row(
              children: [
                CustomText(
                  title: 'إيام العمل',
                  size: FontSize.plainText,
                ),
                //   Spacer(),
                Icon(Icons.date_range_outlined),
              ],
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   body: Expanded(
    //     child: SingleChildScrollView(
    //       //  scrollDirection: Axis.horizontal,
    //       child: Row(
    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,

    //         children: [
    //           Flexible(
    //             flex: 1,
    //             child: Container(
    //               height: 60,
    //               padding: const EdgeInsets.symmetric(horizontal: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 color: AppColor.buttonColorGrey,
    //               ),
    //               child: const Row(
    //                 children: [
    //                   CustomText(
    //                     title: 'إيام العمل',
    //                     size: FontSize.plainText,
    //                   ),
    //                   Spacer(),
    //                   Icon(Icons.date_range_outlined),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Flexible(
    //             flex: 2,
    //             child: Container(
    //               height: 60,
    //               padding: const EdgeInsets.symmetric(horizontal: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 color: AppColor.buttonColorGrey,
    //               ),
    //               child: const Row(
    //                 children: [
    //                   CustomText(
    //                     title: 'إيام العمل',
    //                     size: FontSize.plainText,
    //                   ),
    //                   Spacer(),
    //                   Icon(Icons.date_range_outlined),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Flexible(
    //             flex: 2,
    //             child: Container(
    //               height: 60,
    //               padding: const EdgeInsets.symmetric(horizontal: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 color: AppColor.buttonColorGrey,
    //               ),
    //               child: const Row(
    //                 children: [
    //                   CustomText(
    //                     title: 'إيام العمل',
    //                     size: FontSize.plainText,
    //                   ),
    //                   Spacer(),
    //                   Icon(Icons.date_range_outlined),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
