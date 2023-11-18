import 'package:announcement_of_services/components/custom_text_collector.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              // direction: Axis.vertical,
              children: [
                CustomTextCollector(
                  title: 'رقم الهاتف',
                  subTitle: '288744a78683',
                ),
                CustomTextCollector(
                  title: 'البريد الإلكتروني',
                  subTitle: 'ahmed12@66.com',
                ),
              ],
            ),
            const CustomTextCollector(
              title: 'التقيمات',
              subTitle: '4.5',
              isStar: true,
            ),
            const Spacer(),
            Container(
              width: Dimensions.screenWidth(context) / 2.5,
              height: Dimensions.screenWidth(context) / 2.5,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/clients_home_appliance1.png',
                  ),
                  fit: BoxFit.cover,
                ),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ],
        ),
        CustomTextCollector(
          title: 'البريد الإلكتروني',
          subTitle: 'ahmed12@gmail.com',
        ),
      ],
    );
  }
}
