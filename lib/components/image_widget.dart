import 'dart:io';
import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/utils/constant/responsive_screen.dart';
import 'package:announcement_of_services/view/lodaing_screen.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? imagePathNetwork;
  final File? imagePathLocal;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double? radius;
  final bool isEdit;
  final bool isShadows;
  final VoidCallback? onTap;

  const ImageWidget({
    super.key,
    required this.imagePathNetwork,
    this.width,
    this.height,
    this.isEdit = false,
    this.isShadows = true,
    this.radius,
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
        borderRadius: BorderRadius.circular(150),
        color: imagePathLocal == null && imagePathNetwork == null
            ? Theme.of(context).secondaryHeaderColor
            : null,
        boxShadow: [AppColor.shadow(context)],
      ),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          _buildImage(context),
          if (isEdit)
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (imagePathNetwork == null) {
      return imagePathLocal == null
          ? ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).hintColor,
                    size: 100,
                  ),
                ),
              ),
            )
          : ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: FileImage(
                    imagePathLocal!,
                  ),
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                ),
              ),
            );
    } else {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: NetworkImage(imagePathNetwork!),
            fit: BoxFit.cover,
            width: 128,
            height: 128,
          ),
        ),
      );
    }
  }

  Widget buildEditIcon() => buildCircle(
        color: AppColor.green.withOpacity(0.9),
        all: 0.0,
        child: IconButton(
          icon: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
          onPressed: onTap,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class ImageWidget1 extends StatelessWidget {
  final String? imagePathNetwork;
  final File? imagePathLocal;
  final EdgeInsets? margin;
  final bool isEdit;
  final bool isShadows;
  final VoidCallback? onTap;

  const ImageWidget1({
    super.key,
    required this.imagePathNetwork,
    this.isEdit = false,
    this.isShadows = true,
    this.margin,
    this.onTap,
    this.imagePathLocal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: margin,
      width: Dimensions.screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: imagePathLocal == null && imagePathNetwork == null
            //? light grey  //? dark darkShadeText
            ? Theme.of(context).secondaryHeaderColor
            : null,
        boxShadow: [AppColor.shadow(context)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(context),
            if (isEdit)
              Positioned(
                bottom: 6,
                right: 6,
                child: _buildEditIcon(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (imagePathNetwork == null) {
      return imagePathLocal == null
          ? ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Icon(
                    Icons.person,
                    //? dark whiteText //? light darkShadeText
                    color: Theme.of(context).hintColor,
                    size: 100,
                  ),
                ),
              ),
            )
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

  Widget _buildEditIcon() => buildCircle(
        color: AppColor.green.withOpacity(0.9),
        all: 0.0,
        child: IconButton(
          icon: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
          onPressed: onTap,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

//!CommonImageWidget

// class CommonImageWidget extends StatelessWidget {
//   final String? imagePathNetwork;
//   final File? imagePathLocal;
//   final double? width;
//   final double? height;
//   final EdgeInsets? margin;
//   final double? radius;
//   final bool isEdit;
//   final bool isShadows;
//   final VoidCallback? onTap;

//   const CommonImageWidget({
//     super.key,
//     required this.imagePathNetwork,
//     this.width = 140,
//     this.height = 140,
//     this.isEdit = false,
//     this.isShadows = true,
//     this.radius = 150,
//     this.margin,
//     this.onTap,
//     this.imagePathLocal,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       margin: margin,
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius!),
//         color: imagePathLocal == null && imagePathNetwork == null
//             ? Theme.of(context).secondaryHeaderColor
//             : null,
//         boxShadow: isShadows ? [AppColor.shadow(context)] : null,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(radius!),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             _buildImage(context),
//             if (isEdit)
//               Positioned(
//                 bottom: 6,
//                 right: 6,
//                 child: _buildEditIcon(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(BuildContext context) {
//     if (imagePathNetwork == null) {
//       return imagePathLocal == null
//           ? ClipOval(
//               child: Material(
//                 color: Colors.transparent,
//                 child: Center(
//                   child: Icon(
//                     Icons.person,
//                     //? dark whiteText //? light darkShadeText
//                     color: Theme.of(context).hintColor,
//                     size: 100,
//                   ),
//                 ),
//               ),
//             )
//           : Image.file(
//               imagePathLocal!,
//               fit: BoxFit.cover,
//             );
//     } else {
//       return Image.network(
//         imagePathNetwork!,
//         fit: BoxFit.cover,
//         loadingBuilder: (BuildContext context, Widget child,
//             ImageChunkEvent? loadingProgress) {
//           if (loadingProgress == null) {
//             return child;
//           } else {
//             return const LoadingScreen();
//           }
//         },
//         errorBuilder:
//             (BuildContext context, Object error, StackTrace? stackTrace) {
//           return const Center(
//             child: Icon(
//               Icons.error,
//               color: Colors.red,
//             ),
//           );
//         },
//       );
//     }
//   }

//   Widget _buildEditIcon() => buildCircle(
//         color: AppColor.green.withOpacity(0.9),
//         all: 0.0,
//         child: IconButton(
//           icon: const Icon(
//             Icons.add_a_photo,
//             color: Colors.white,
//             size: 20,
//           ),
//           onPressed: onTap,
//         ),
//       );

//   Widget buildCircle({
//     required Widget child,
//     required double all,
//     required Color color,
//   }) =>
//       ClipOval(
//         child: Container(
//           padding: EdgeInsets.all(all),
//           color: color,
//           child: child,
//         ),
//       );
// }
