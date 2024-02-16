import 'package:announcement_of_services/components/buttom_widget.dart';
import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/module/request_details_model.dart';
import 'package:announcement_of_services/module/user_details_model.dart';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/constants.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'shared/custom_shape_decoration.dart';

class RequestUserWidget extends StatelessWidget {
  final RequestDetailsModel requestDetailsModel;
  final UserDetailsModel userDetailsModel;
  final bool isServiceProvider;
  final VoidCallback onTap;
  final VoidCallback? onPressedAccepted;
  final VoidCallback? onPressedUnaccepted;
  final VoidCallback? onPressedDone;
  const RequestUserWidget({
    super.key,
    required this.requestDetailsModel,
    required this.userDetailsModel,
    this.isServiceProvider = false,
    required this.onTap,
    this.onPressedAccepted,
    this.onPressedUnaccepted,
    this.onPressedDone,
  });

  @override
  Widget build(BuildContext context) {
    final String status = requestDetailsModel.status!;
    DateTime requestDateTime = DateTime.parse(requestDetailsModel.requestDate);
    String formattedDate =
        intl.DateFormat('yyyy-MM-dd EE', 'en').format(requestDateTime);
    String formattedTime =
        intl.DateFormat('a  h:mm:ss', 'en').format(requestDateTime);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Dimensions.screenWidth(context),
        decoration: CustomShapeDecoration.shapeDecoration(context),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Dimensions.screenWidth(context) / 2,
                    height: 25,
                    decoration: ShapeDecoration(
                      color: requestDetailsModel.status == REQUEST_WAIT
                          ? Colors.blueGrey
                          : requestDetailsModel.status == REQUEST_ACCEPTED
                              ? AppColor.green.withOpacity(0.9)
                              : requestDetailsModel.status == REQUEST_UNACCEPTED
                                  ? AppColor.buttonColorRed
                                  : AppColor.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    child: Center(
                      child: TextWidget(
                        title: requestDetailsModel.status == REQUEST_WAIT
                            ? 'قيد الأنتظار'
                            : requestDetailsModel.status == REQUEST_ACCEPTED
                                ? 'تم الموافقة'
                                : requestDetailsModel.status ==
                                        REQUEST_UNACCEPTED
                                    ? 'تم رفض الطلب'
                                    : 'تم الانتهاء',
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                        size: FontSize.plainText(context),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: AppColor.green),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          userDetailsModel.profileImage,
                          width: Dimensions.screenWidth(context),
                          height: Dimensions.screenHeight(context),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: isServiceProvider
                                ? userDetailsModel
                                        .servicesProviderModel?.serviceType ??
                                    'ليس مزود خدمة'
                                : userDetailsModel
                                        .servicesProviderModel?.desc ??
                                    'ليس مزود خدمة',
                            fontWeight: FontWeight.w500,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.account_circle_rounded,
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    4,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: TextWidget(
                                    title: userDetailsModel.fullName,
                                    size: FontSize.plainText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.date_range_outlined,
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    4,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: TextWidget(
                                    title: formattedDate,
                                    size: FontSize.plainText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    4,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: TextWidget(
                                    title: formattedTime,
                                    size: FontSize.plainText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Icon(
                              //   Icons.timer_rounded,
                              //   size: 16,
                              // ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  4,
                                  4,
                                  0,
                                  0,
                                ),
                                child: Column(
                                  children: [
                                    TextWidget(
                                      size: FontSize.plainText(context),
                                      title: status == REQUEST_WAIT
                                          ? isServiceProvider
                                              ? ''
                                              : 'انتظر لحين موافقة مزود الخِدمة ${userDetailsModel.fullName}'
                                          : status == REQUEST_ACCEPTED
                                              ? "تاريخ المباشرة ${requestDetailsModel.date}\nوقت المباشرة ${requestDetailsModel.time}"
                                              : status == REQUEST_UNACCEPTED
                                                  ? 'تم رفض الطلب'
                                                  : 'تم الانتهاء من العمل',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 6, 0, 0),
                        child: TextWidget(
                          title: "تفاصيل الطلب",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.all(10),
                    child: TextWidget(
                      title: requestDetailsModel.desc,
                      size: FontSize.plainText(context),
                    ),
                  ),
                ],
              ),
              isServiceProvider
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        status != REQUEST_ACCEPTED &&
                                status != REQUEST_UNACCEPTED &&
                                status != REQUEST_DONE
                            ? ButtonWidget(
                                context: context,
                                title: 'قبول الطلب',
                                onPressed: onPressedAccepted,
                                width: Dimensions.screenWidth(context) / 3.5,
                                backGroundColor:
                                    AppColor.green.withOpacity(0.9),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 6),
                        status != REQUEST_UNACCEPTED &&
                                status != REQUEST_ACCEPTED &&
                                status != REQUEST_DONE
                            ? ButtonWidget(
                                context: context,
                                title: 'رفض الطلب',
                                onPressed: onPressedUnaccepted,
                                width: Dimensions.screenWidth(context) / 3.5,
                                backGroundColor: AppColor.buttonColorRed,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 6),
                        status != REQUEST_DONE &&
                                status == REQUEST_ACCEPTED &&
                                status != REQUEST_UNACCEPTED
                            ? ButtonWidget(
                                context: context,
                                title: 'تم الانتهاء',
                                onPressed: onPressedDone,
                                width: Dimensions.screenWidth(context) / 2,
                              )
                            : const SizedBox.shrink(),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
