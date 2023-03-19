class Specialization {
  int? id;
  String? name;
 bool selected = false;

  Specialization({this.name,this.id});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}