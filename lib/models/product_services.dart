// ignore_for_file: unused_import

import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class ProductServices {
  List<ProductService> data = <ProductService>[];
  String? type;

  ProductServices() {
    ProductService service = ProductService(id: -1, name: 'الكل');
    data.add(service);
  }
  retrieveServices(onDone) async {
    AppApiHandler.getData(
        url: '$apiVersion/$type',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new ProductService.fromJson(v));
      });
    }
  }
}

class ProductService {
  int? _id;
  String? name;
  bool selected = false;
  List<SubService> subCategories = <SubService>[];

  ProductService({int? id, String? name}) {
    _id = id;
    this.name = name;
  }

  set id(value) => _id = value;
  String get id {
    return _id == null ? '' : '$_id';
  }

  ProductService.fromJson(Map<String, dynamic> json) {
    SubService subService = SubService(id: -1, name: 'الكل');
    subCategories.add(subService);
    _id = json['id'];
    name = json['name'];
    if (json['subCategories'] != null) {
      json['subCategories'].forEach((v) {
        subCategories.add(new SubService.fromJson(v));
      });
    }
  }
}

class SubService {
  int? _id;
  String? name;
  int? mainProductServiceTypeId;
  String? createdAt;
  String? updatedAt;
  bool selected = false;

  SubService({int? id, String? name}) {
    _id = id;
    this.name = name;
  }

  set id(value) => _id = value;
  String get id {
    return _id == null ? '' : '$_id';
  }

  SubService.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    name = json['name'];
    mainProductServiceTypeId = json['main_product_service_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
