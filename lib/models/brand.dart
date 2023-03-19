
class Brand {
  int? id;
  String? name;
  bool selected = false;


  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}