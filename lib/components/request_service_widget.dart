import 'package:announcement_of_services/components/text_form_field_widget.dart';

import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/utils/constant/size.dart';
import 'package:announcement_of_services/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'buttom_widget.dart';
import 'image_widget.dart';
import 'shared/custom_shape_decoration.dart';
import 'text_widget.dart';

class RequestServiceWidget extends StatelessWidget {
  final String fullName;
  final String serviceTitle;
  final String imagePath;
  final bool isLoading;
  // final String servicesProviderId;
  final TextEditingController descController;
  final ValidCallback? valid;
  final VoidCallback onPressedRequest;
  const RequestServiceWidget({
    super.key,
    required this.fullName,
    required this.serviceTitle,
    required this.imagePath,
    required this.descController,
    this.valid,
    required this.onPressedRequest,
    required this.isLoading,
    // required this.userid,
    // required this.servicesProviderId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 50,
        ),
        decoration: CustomShapeDecoration.shapeDecoration(
          context,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
              child: TextWidget(
                title: 'طلب خِدمة $serviceTitle',
                fontWeight: FontWeight.w500,
                size: FontSize.headline(context),
                // style: FlutterFlowTheme.of(context).headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
              child: TextWidget(
                title: 'رجاءًا اكتب تفاصيل الطلب بإختصار',
                size: FontSize.plainText(context),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ImageWidget(
                    imagePathNetwork: imagePath,
                    width: AppSize.imageSizeSmall(context),
                    height: AppSize.imageSizeSmall(context),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: TextWidget(
                      title: fullName,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormFieldWidget(
                isWithoutText: true,
                context: context,
                controller: descController,
                headline: '',
                textInputType: TextInputType.multiline,
                maxLength: 180,
                maxLines: 4,
                minLines: 4,
                hintText: 'اكتب هنا تفاصيل الطلب...',
                borderSideWidth: 2,
                // valid: widget.valid,
                valid: valid,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColor.green,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    context: context,
                    onPressed: onPressedRequest,
                    title: 'طلب',
                    width: Dimensions.screenWidth(context) / 3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonWidget(
                    context: context,
                    isLoad: isLoading,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'الغاء',
                    backGroundColor: AppColor.buttonColorRed,
                    width: Dimensions.screenWidth(context) / 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
