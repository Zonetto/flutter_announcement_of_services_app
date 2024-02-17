import 'package:announcement_of_services/components/buttom_ink_widget.dart';
import 'package:announcement_of_services/components/image_widget.dart';
import 'package:announcement_of_services/components/shared/custom_shape_decoration.dart';
import 'package:announcement_of_services/components/shared/network/local/cache_helper.dart';
import 'package:announcement_of_services/components/text_collector_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/main.dart';
import 'package:announcement_of_services/module/service_provider_model.dart';
import 'package:announcement_of_services/module/user_model.dart';
import 'package:announcement_of_services/utils/alert_dialog.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/navigate_utils.dart';
import 'package:announcement_of_services/view/start_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userDetails;
  ServicesProviderModel? _servicesProviderModel;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewModelAuth>(context, listen: false);
    _userDetails = context.watch<ViewModelFetch>().getUserDetails;
    final bool isServiceProviderAccept =
        _userDetails?.isServiceProvider == serviceProviderAccept;
    //print(_userDatils?.call);
    return Column(
      children: [
        //AppSize.sizedBoxHeight,
        Container(
          padding: AppSize.nternalMargin,
          width: Dimensions.screenWidth(context),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
          decoration: CustomShapeDecoration.shapeDecoration(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // direction: Axis.vertical,
                    children: [
                      TextCollectorWidget(
                        title: 'البريد الإلكتروني',
                        subTitle: _userDetails?.email ?? '',
                      ),
                      TextCollectorWidget(
                        title: 'رقم الهاتف',
                        subTitle: _userDetails?.call.toString() ?? '',
                      ),
                      isServiceProviderAccept
                          ? const TextCollectorWidget(
                              title: 'التقييم',
                              subTitle: '4',
                              isStar: true,
                            )
                          : const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              //const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ImageWidget(
                      imagePathNetwork: _userDetails?.image,
                      height: AppSize.imageSizeLarge(context),
                      width: AppSize.imageSizeLarge(context),
                    ),
                    const SizedBox(height: 4.0),
                    TextWidget(
                      title: _userDetails?.fullName ?? '',
                      size: FontSize.subtitle(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 20.0),
        Column(
          children: [
            ButtonInkWidget(
              context: context,
              title: 'الوضع',
              icon: Icons.mode_night_outlined,
              onTap: () async {
                if (MyApp.themeNotifier.value == ThemeMode.light) {
                  await CacheHelper.putDataBoolean(key: 'mode', value: false);
                  MyApp.themeNotifier.value = ThemeMode.dark;
                } else {
                  await CacheHelper.putDataBoolean(key: 'mode', value: true);
                  MyApp.themeNotifier.value = ThemeMode.light;
                }
              },
              isImage: false,
            ),
            ButtonInkWidget(
              context: context,
              title: 'حول التطبيق',
              icon: Icons.info_outlined,
              onTap: () async {
                try {
                  _servicesProviderModel =
                      await _userDetails!.getServiceProviderModel();
                  print(
                      "_servicesProviderModel ${_servicesProviderModel!.address}");
                } catch (e) {}
              },
              isImage: false,
            ),
            ButtonInkWidget(
              context: context,
              title: 'اتصل بنا',
              icon: Icons.local_phone_outlined,
              onTap: () async {},
              isImage: false,
            ),
            ButtonInkWidget(
              context: context,
              title: 'تسجيل خروج',
              icon: Icons.exit_to_app,
              onTap: () {
                alertDialog(
                  context: context,
                  title: 'تسجيل الخروج',
                  content: 'هل أنت متأكد من تسجيل الخروج؟',
                  onPressed: () {
                    provider.logOut();
                    navigateToScreen(
                        context: context, screen: const StartScreen());
                  },
                );
              },
              isImage: false,
            ),
          ],
        ),
      ],
    );
  }
}
