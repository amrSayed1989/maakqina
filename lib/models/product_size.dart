class ProductSize {
  int? id;
  String? name;

  ProductSize({this.id, this.name});

  ProductSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}