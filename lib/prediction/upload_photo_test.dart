import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  bool isImageSelected = false;
  File? imageFile;

  Future<void> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        isImageSelected = true;
      } else {
        print('User didn\'t pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        isImageSelected = true;
      } else {
        print('User didn\'t pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
