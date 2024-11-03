class ProductItem {
  final String? id;
  final String name;
  final String imageUrl;
  final String location;
  final String store;
  final double price;
  final String type;
  final String? description;
  final int likes;
  final int dislikes;
  final double? rate;
  final double? latitude; // opcional
  final double? longitude; // opcional

  ProductItem({
    this.id = "",
    required this.name,
    required this.imageUrl,
    required this.location,
    this.store = "",
    required this.price,
    required this.type,
    this.description,
    this.likes = 0,
    this.dislikes = 0,
    this.rate,
    this.latitude,
    this.longitude,
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
      'likes': likes,
      'dislikes': dislikes,
      'rate': rate,
      'coords': {
        'latitude': latitude,
        'longitude': longitude,
      },
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
      likes: map['likes'],
      dislikes: map['dislikes'],
      rate: map['rate'],
      latitude: map['coords']?['latitude'],
      longitude: map['coords']?['longitude'],
    );
  }
}
