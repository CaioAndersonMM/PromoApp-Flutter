class ProductItem {
  final int? id;
  final String name;
  final String imageUrl;
  final String location;
  final double price;
  final String type;
  final String? description;
  final double? rate;

  ProductItem({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.type,
    this.description,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'price': price,
      'type': type,
      'description': description,
      'rate': rate,
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
      description: map['description'],
      rate: map['rate'],
    );
  }
}
