class Category {
  final String icon;
  final int id;
  final bool isActive;
  final String name;

  Category({
    required this.icon,
    required this.id,
    required this.isActive,
    required this.name,
  });

  // Factory constructor to create a Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      icon: json['icon'] ?? '',
      name: json['name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, icon: $icon, isActive: $isActive}';
  }
}
