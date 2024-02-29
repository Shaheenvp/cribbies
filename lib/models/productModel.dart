import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id; // Added id property
  final String productName;
  final int quantity;
  final double ctc;
  final String description;
  final String imageUrl;
  final String userName;

  ProductModel({
    this.id, // Include id property in the constructor
    required this.productName,
    required this.quantity,
    required this.ctc,
    required this.description,
    required this.imageUrl,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map
      'productName': productName,
      'quantity': quantity,
      'ctc': ctc,
      'description': description,
      'imageUrl': imageUrl,
      'userName': userName,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    // Ensure data is not null and contains all required fields
    if (data == null ||
        data['id'] == null ||
        data['productName'] == null ||
        data['quantity'] == null ||
        data['ctc'] == null ||
        data['description'] == null ||
        data['imageUrl'] == null ||
        data['userName'] == null) {
      throw FormatException("Invalid data format in snapshot");
    }

    return ProductModel(
      id: data['id'], // Assign id from snapshot
      productName: data['productName'],
      quantity: data['quantity'],
      ctc: data['ctc'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      userName: data['userName'],
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      productName: map['productName'],
      quantity: map['quantity'],
      ctc: map['ctc'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      userName: map['userName'],
    );
  }
}
