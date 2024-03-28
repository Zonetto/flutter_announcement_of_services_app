// import 'package:announcement_of_services/components/buttom_widget.dart';
// import 'package:announcement_of_services/components/text_widget.dart';
// import 'package:announcement_of_services/utils/alert_dialog.dart';
// import 'package:announcement_of_services/utils/constant/color.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   List<int> rating = <int>[1, 2, 3, 4, 5];
//   int? _selectedRadio;
//   String? _selectedExp;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const TextWidget(title: 'الموقع'),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('الموقع $index'),
//                   onTap: () {
//                     //Navigator.of(context).pop();
//                     // Add your logic here for item tap
//                   },
//                 );
//               },
//             ),
//           ),
//           const Divider(indent: 3),
//           const TextWidget(title: 'التقييم'),
//           Expanded(
//             child: ListView.builder(
//               itemCount: rating.length,
//               itemBuilder: (context, index) {
//                 return RadioListTile<int>(
//                   title: Text(rating[index].toString()),
//                   value: index,
//                   groupValue: _selectedRadio,
//                   onChanged: (int? value) {
//                     // setSelectedRadio(value ?? '');
//                     setState(() {
//                       _selectedRadio = value;
//                       print(value);
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           //sdads
//           ButtonWidget(
//               context: context,
//               title: 'title',
//               onPressed: () {
//                 alertDialog(
//                   context: context,
//                   title: 'sd',
//                   widget: SizedBox(
//                     width: 300,
//                     child: Column(
//                       children: [
//                         const Divider(indent: 3),
//                         const TextWidget(title: 'التقييم'),
//                         Expanded(
//                           child: RadioListTileWidget<int>(
//                             lst: rating,
//                             selectedRadio: _selectedRadio,
//                           ),
//                         ),
//                         const Divider(indent: 3),
//                         const TextWidget(title: 'الخبرة'),
//                         Expanded(
//                           child: RadioListTileWidget<String>(
//                             lst: const ['sa', 's', 's', 's', 's', 's', 's'],
//                             selectedRadio: _selectedExp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   onPressed: () {},
//                 );
//               }),
//         ],
//       ),
//     );
//   }
// }

// // ! DDD

