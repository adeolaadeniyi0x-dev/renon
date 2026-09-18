class Vendor {
  const Vendor({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.location,
    required this.deliveryFee,
    required this.tags,
    required this.isFeatured,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final double rating;
  final String deliveryTime;
  final String location;
  final int deliveryFee;
  final List<String> tags;
  final bool isFeatured;
  final String imageUrl;
}
