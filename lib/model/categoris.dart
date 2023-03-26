import 'dart:convert';

class CategoryListItems {
  String categoryName;
  String imageUrl;
  String id;
  CategoryListItems({
    required this.categoryName,
    required this.imageUrl,
    required this.id,
  });

  CategoryListItems copyWith({
    String? categoryName,
    String? imageUrl,
    String? id,
  }) {
    return CategoryListItems(
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  factory CategoryListItems.fromMap(Map<String, dynamic> map) {
    return CategoryListItems(
      categoryName: map['categoryName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryListItems.fromJson(String source) => CategoryListItems.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryListItems(categoryName: $categoryName, imageUrl: $imageUrl, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryListItems && other.categoryName == categoryName && other.imageUrl == imageUrl && other.id == id;
  }

  @override
  int get hashCode => categoryName.hashCode ^ imageUrl.hashCode ^ id.hashCode;
}
