import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:flutter/widgets.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
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
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: AssetImage(
            imagePath,
          ),
          fit: BoxFit.cover,
        ),
        shape: isCircular
            ? const OvalBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
        shadows: isShadows ? const [AppColor.shadow] : null,
      ),
    );
  }
}
