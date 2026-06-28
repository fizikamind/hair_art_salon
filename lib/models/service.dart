class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final int duration;
  final bool isActive;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'duration': duration,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ServiceModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return ServiceModel(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? 'General',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      duration: map['duration'] ?? 0,
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(
        map['createdAt'] ??
            DateTime.now().toIso8601String(),
      ),
    );
  }
}