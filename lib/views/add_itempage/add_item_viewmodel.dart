import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class AddItemViewModel extends BaseViewModel {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  XFile? get pickedImage => _pickedImage;

  Future<void> pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _pickedImage = pickedImage;
      notifyListeners();
    }
  }

  Future<void> takePicture() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _pickedImage = pickedFile;
        notifyListeners();
        // You can handle the picked image file here.
        print('Image path: ${pickedFile.path}');
        // Add your logic to use the image as needed.
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void clearPickedImage() {
    _pickedImage = null;
    notifyListeners();
  }
}
