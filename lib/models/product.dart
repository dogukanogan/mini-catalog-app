class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String currency;
  final String image;
  final Map<String, String> specs;

  /// API'deki URL'den dosya adını çıkararak local asset yolunu döndürür
  String get localImagePath {
    final filename = image.split('/').last;
    return 'images/$filename';
  }

  Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Specs alanını Map<String, String>'e dönüştür
    Map<String, String> specsMap = {};
    if (json['specs'] != null) {
      json['specs'].forEach((key, value) {
        specsMap[key] = value.toString();
      });
    }

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      currency: json['currency'] ?? 'USD',
      image: json['image'] ?? '',
      specs: specsMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }
}
