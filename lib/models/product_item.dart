class ProductItem {
  final int? id;
  final String name;
  final String imageUrl;
  final String location;
  final double price;
  final String type;

  ProductItem({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'price': price,
      'type': type,
    };
  }

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      location: map['location'],
      price: map['price'],
      type: map['type'],
    );
  }
}
