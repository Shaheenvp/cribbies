import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productName;
  final int quantity;
  final double ctc;
  final String description;
  final String imageUrl;

  ProductModel({
    required this.productName,
    required this.quantity,
    required this.ctc,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
      'ctc': ctc,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    // Ensure data is not null and contains all required fields
    if (data == null ||
        data['productName'] == null ||
        data['quantity'] == null ||
        data['ctc'] == null ||
        data['description'] == null ||
        data['imageUrl'] == null) {
      throw FormatException("Invalid data format in snapshot");
    }

    return ProductModel(
      productName: data['productName'],
      quantity: data['quantity'],
      ctc: data['ctc'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'],
      quantity: map['quantity'],
      ctc: map['ctc'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
