
import 'category.dart';

class SubCategory {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Category? category;

  SubCategory(
      {this.id,
        this.name,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.category});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

}