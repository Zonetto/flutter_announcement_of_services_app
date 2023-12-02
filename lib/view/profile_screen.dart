import 'package:announcement_of_services/components/custom_buttom_ink.dart';
import 'package:announcement_of_services/components/custom_image.dart';
import 'package:announcement_of_services/components/custom_text.dart';
import 'package:announcement_of_services/components/custom_text_collector.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/services/fire_database_servises.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/start_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:announcement_of_services/view_model/view_model_fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userDatils;
  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelAuth>(context, listen: false);
    final provider1 = Provider.of<ViewModelFetch>(context, listen: false);
    _userDatils = context.watch<ViewModelFetch>().getUserDetails;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: AppSize.nternalMargin,
            //height: 250,
            margin: const EdgeInsets.only(bottom: 24.0),
            width: double.infinity,
            decoration: CustomShapeDecoration.shapeDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // direction: Axis.vertical,
                  children: [
                    CustomTextCollector(
                      title: 'البريد الإلكتروني',
                      subTitle: _userDatils?.email ?? '',
                    ),
                    CustomTextCollector(
                      title: 'رقم الهاتف',
                      subTitle: _userDatils?.call.toString() ?? '',
                    ),
                    const CustomTextCollector(
                      title: 'التقيمات',
                      subTitle: '4.5',
                      isStar: true,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    CustomImage(
                      imagePath: _userDatils?.image,
                      height: AppSize.imageSizeLarg(context),
                      width: AppSize.imageSizeLarg(context),
                    ),
                    const SizedBox(height: 4.0),
                    CustomText(
                      title: _userDatils?.fullName ?? '',
                      size: FontSize.subtitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomButtonInk(
            context: context,
            title: 'الوضع',
            icon: Icons.mode_night_outlined,
            onTap: () {},
            isImage: false,
          ),
          CustomButtonInk(
            context: context,
            title: 'حول التطبيق',
            icon: Icons.info_outlined,
            onTap: () {},
            isImage: false,
          ),
          CustomButtonInk(
            context: context,
            title: 'اتصل بنا',
            icon: Icons.local_phone_outlined,
            onTap: () async {
              final UserModel? userData =
                  await FireDatabaseServises().getUserFromDB(provider.getUserId!);
    
              // final Map<String, dynamic>? userData =
              //     await DatabaseMethod().getUserFromDB1(provider.getUserId!);
    
              //  final Map<String, dynamic> u = DatabaseMethod().getUserFromDB(provider.getUserId!);
              // print(userData!.call);
              // print(provider1.getUserId!);
              provider1.fetchUserDetailsData();
            },
            isImage: false,
          ),
          CustomButtonInk(
            context: context,
            title: 'تسجيل خروج',
            icon: Icons.exit_to_app,
            onTap: () {
              provider.logOut();
              navigatePushScreen(context: context, screen: const StartScreen());
            },
            isImage: false,
          ),
        ],
      ),
    );
  }
}
