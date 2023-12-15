import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double? radius;
  final bool isCircular;
  final bool isShadows;
  const CustomImage({
    super.key,
    required this.imagePath,
    this.width = 140,
    this.height = 140,
    this.isCircular = true,
    this.isShadows = true,
    this.radius = 150,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imagePath == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  'assets/images/repairing-computer.jpg',
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.network(
                  imagePath!,
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                ),
              ),
                Container(
          //  decoration: CustomShapeDecoration.shapeDecoration,
          height: height,
          margin:margin ,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            image: const DecorationImage(
              image: AssetImage('assets/images/repairing-computer.jpg'),
              fit: BoxFit.cover,
            ),
          ),

        ),
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
