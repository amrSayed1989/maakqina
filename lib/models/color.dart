
class AppColor {
  int? id;
  String? name;
  bool selected = false;

  AppColor({this.id, this.name});

  AppColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}

class AppSize {
  int? id;
  String? name;
  bool selected = false;
  AppSize({this.id, this.name});

  AppSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}

class FilterTrader {
  int? id;
  String? name;
  bool selected = false;
  FilterTrader({this.id, this.name});

  FilterTrader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}