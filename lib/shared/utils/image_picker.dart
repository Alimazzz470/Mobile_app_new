import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({ImageSource? source}) async {
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(
    source: source ?? ImageSource.camera,
  );
  if (image != null) {
    return File(image.path);
  }
  return null;
}
