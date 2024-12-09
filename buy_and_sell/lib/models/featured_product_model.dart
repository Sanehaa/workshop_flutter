class FeaturedProduct {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;

  FeaturedProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
  });

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      images: (json['images'] is List)
          ? List<String>.from(json['images'].map((e) => e.toString()))
          : [],
    );
  }
}
