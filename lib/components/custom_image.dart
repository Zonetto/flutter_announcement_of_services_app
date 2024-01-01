import 'dart:io';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/view/lodaing_screen.dart';
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
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(),
            if (isEdit) _buildEditWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePathNetwork == null) {
      return imagePathLocal == null
          ? const SizedBox.shrink()
          : Image.file(
              imagePathLocal!,
              fit: BoxFit.cover,
            );
    } else {
      return Image.network(
        imagePathNetwork!,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const LoadingScreen();
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        },
      );
    }
  }

  Widget _buildEditWidget() {
    return GestureDetector(
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
    );
  }
}
