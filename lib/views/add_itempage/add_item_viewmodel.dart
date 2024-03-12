import 'dart:io';

import 'package:Potrack/views/purchaseOrder_page/purchaseOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/productModel.dart';

String? imageUrl = '';

class AddItemViewModel extends BaseViewModel {
  TextEditingController productNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController ctcController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedImage;

  // XFile? get pickedImage => pickedImage;

  Future<void> pickImage() async {
    pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);

    if (pickedImage != null) {
      pickedImage = pickedImage;
      notifyListeners();
    }
    imageUrl = await uploadImageToFirebase();
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

  Future<void> addProductToFirestore(
      ProductModel product, purchaseOrderDocId) async {
    try {
      // Add the product to Firestore
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('purchaseOrders')
          .doc(purchaseOrderDocId)
          .collection('products')
          .add(product.toMap());

      // Get the ID of the newly added document
      String productId = docRef.id;

      // Update the document with the ID
      await docRef.update({'id': productId});
    } catch (error) {
      // Handle any errors that occur
      print('Error adding product to Firestore: $error');
      throw error; // Optionally, re-throw the error to handle it elsewhere
    }
  }

  Future<void> takePicture() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 30);

      print(imageUrl);
      print("imageUrl");

      if (pickedFile != null) {
        pickedImage = pickedFile;
        notifyListeners();
        print('Image path: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
      imageUrl = await uploadImageToFirebase();
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    notifyListeners();
  }
}
