class ItemModel {
  final String name, quantity, ctc, description, photoUrl;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.ctc,
    required this.description,
    required this.photoUrl,
  });

  // Factory method to create an ItemModel object from a map
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      ctc: map['ctc'] ?? '',
      description: map['description'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  // Convert the ItemModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'ctc': ctc,
      'description': description,
      'photoUrl': photoUrl,
    };
  }
}
