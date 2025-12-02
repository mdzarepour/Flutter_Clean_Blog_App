import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker picker;
  ImageHelper({required this.picker});

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        return File(xFile.path);
      }
    } catch (e) {
      return null;
    }
  }
}
