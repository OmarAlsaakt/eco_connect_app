class Product {
  final String id;
  final String brand;
  final String title;
  final String name;
  final double price;
  final String image;
  final String category;
  final double rating;
  final int reviews;
  final String ecoImpact;
  final String description;
  final List<String> features;
  final String sustainability;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.title,
    required this.image,
    required this.reviews,
    required this.category,
    required this.rating,
    required this.ecoImpact,
    required this.description,
    required this.features,
    required this.sustainability,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
      'brand': brand,
      'title': title,
      'reviews': reviews,
      'ecoImpact': ecoImpact,
      'description': description,
      'features': features,
      'sustainability': sustainability,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      reviews: json['reviews'] ?? 0,
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      brand: json['brand'],
      title: json['title'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      ecoImpact: json['ecoImpact'],
      description: json['description'],
      features: List<String>.from(json['features']),
      sustainability: json['sustainability'],
    );
  }
}
