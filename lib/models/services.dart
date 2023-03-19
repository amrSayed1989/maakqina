// ignore_for_file: unnecessary_question_mark

import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class Services {
  List<Service> data = <Service>[];
  String? type;

  Services() {
    Service service = Service(id: -1, name: 'الكل');
    data.add(service);
  }
  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Service.fromJson(v));
      });
    }
  }

  retrieveServices(onDone) async {
    println('======------ ${AppUrl.placesServices}$type');
    AppApiHandler.getData(
        url: '${AppUrl.placesServices}$type',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}

class Service {
  int? id;
  String? name;
  String? type;
  List<SubService> subCategories = <SubService>[];

  Service({this.id, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    SubService subService = SubService(id: -1, name: 'الكل');
    subCategories.add(subService);
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['subCategories'] != null) {
      json['subCategories'].forEach((v) {
        subCategories.add(new SubService.fromJson(v));
      });
    }
  }
}

class SubService {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Service? category;
  bool selected = false;

  SubService(
      {this.id,
      this.name,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.category});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null
        ? new Service.fromJson(json['category'])
        : null;
  }
}

class Category {
  int? id;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Category(
      {this.id,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
