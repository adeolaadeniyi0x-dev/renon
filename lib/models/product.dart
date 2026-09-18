class Product {
  const Product({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String vendorId;
  final String vendorName;
  final String category;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
}
