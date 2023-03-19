
class Category {
  int? id;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;


  Category(
      {this.id,
        this.name,
        this.type,
        this.createdAt,
        this.updatedAt,});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

}