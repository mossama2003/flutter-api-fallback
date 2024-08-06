class ProductModel {
  final String title;
  final double price;

  ProductModel({
    required this.title,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      price: json['price'].toDouble(),
    );
  }
}
