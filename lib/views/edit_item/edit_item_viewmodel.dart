import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/productModel.dart';

String? imageUrl = '';

class EditItemViewModel extends BaseViewModel {
  TextEditingController productNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController ctcController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedImage;

  // XFile? get pickedImage => pickedImage;

  Future<void> pickImage() async {
    pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      pickedImage = pickedImage;
      imageUrl = await uploadImageToFirebase();

      notifyListeners();
    }
  }

  Future<String?> uploadImageToFirebase() async {
    if (pickedImage == null) return null;

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(File(pickedImage!.path));

      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> editProduct(ProductModel product) async {
    try {
      // Add the product to Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
    } catch (error) {
      // Handle any errors that occur
      print('Error adding product to Firestore: $error');
      throw error; // Optionally, re-throw the error to handle it elsewhere
    }
  }

  Future<void> takePicture() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        pickedImage = pickedFile;
        notifyListeners();
        print('Image path: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
      imageUrl = await uploadImageToFirebase();

      print(imageUrl);
      print("imageUrl--");
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    notifyListeners();
  }
}
