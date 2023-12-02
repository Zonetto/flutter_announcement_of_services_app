
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final bool isCircular;
  final bool isShadows;
  const CustomImage({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    this.isCircular = true,
    this.isShadows = true,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imagePath == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  'assets/images/clients_home_appliance1.png',
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.network(
                  imagePath!,
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                ),
              ),
        // const CustomText(
        //   title: 'ضع صورة',
        //   size: FontSize.subtitle,
        // ),
      ],
    );
    // return Container(
    //   width: width,
    //   height: height,
    //   decoration: ShapeDecoration(
    //     image: DecorationImage(
    //       image: NetworkImage(imagePath),
    //       // image: imagePath == null
    //       //     ? AssetImage(
    //       //         imagePath,
    //       //       )
    //       //     : NetworkImage(imagePath),
    //       fit: BoxFit.cover,
    //     ),
    //     shape: isCircular
    //         ? const OvalBorder()
    //         : RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15),
    //           ),
    //     shadows: isShadows ? const [AppColor.shadow] : null,
    //   ),
    // );
  }
}
