import 'dart:io';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imagePathNetwork;
  final File? imagePathLocal;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double? radius;
  final bool isEdit;
  final bool isShadows;
  final VoidCallback? onTap;
  const CustomImage({
    super.key,
    required this.imagePathNetwork,
    this.width = 140,
    this.height = 140,
    this.isEdit = false,
    this.isShadows = true,
    this.radius = 150,
    this.margin,
    this.onTap,
    this.imagePathLocal,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        boxShadow: isShadows ? const [AppColor.shadow] : null,
        image: imagePathNetwork == null
            ? imagePathLocal == null
                ? const DecorationImage(
                    image: AssetImage('assets/images/repairing-computer.jpg'),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: FileImage(imagePathLocal!),
                    fit: BoxFit.cover,
                  )
            : DecorationImage(
                image: NetworkImage(imagePathNetwork!),
                fit: BoxFit.cover,
                // loadingBuilder: (context, child, loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return const CircularProgressIndicator();
                // },
              ),
      ),
      child: isEdit
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const CircleAvatar(
                  backgroundColor: AppColor.buttonColorGrey,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
