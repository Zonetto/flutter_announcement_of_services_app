
import 'package:image_picker/image_picker.dart';

Future <XFile?> pickImage(ImageSource imageSource) async {
  final XFile? returnedImage =
      await ImagePicker().pickImage(source: imageSource);
  if (returnedImage == null) return null;
  return returnedImage;
}
