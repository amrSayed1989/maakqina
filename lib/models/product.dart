// ignore_for_file: unused_field

import 'package:maak/models/image.dart';
import 'package:maak/models/trader.dart';
import 'package:maak/models/varients.dart';

import 'brand.dart';
import 'media.dart';

class Product {
  int? _id;
  String? _name;
  int _isAvailable = 0;
  int? _brandId;
  String? _detailedTitle;
  String? _details;
  String? _productCode;
  int? _showTraderName;
  int? _showInMainPage;
  int? _showInTraderPage;
  int? _traderId;
  int? _mainProductTypeId;
  int? _subProductTypeId;
  int? _subProductServiceTypeId;
  int? _mainProductServiceTypeId;
  int? _cityId;
  int? _departmentId;
  dynamic _price;
  dynamic _priceAfterDiscount;
  AppImage? _image;
  List<Variant> variants = [];
  Brand? brand;
  Trader? _trader;
  List<Media>? _media;

  Product({int? id}) {
    this._id = id;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _isAvailable = json['is_available'];
    _brandId = json['brand_id'];
    _detailedTitle = json['detailed_title'];
    _details = json['details'];
    _productCode = json['product_code'];
    _showTraderName = json['show_trader_name'];
    _showInMainPage = json['show_in_main_page'];
    _showInTraderPage = json['show_in_trader_page'];
    _traderId = json['trader_id'];
    _mainProductTypeId = json['main_product_type_id'];
    _subProductTypeId = json['sub_product_type_id'];
    _subProductServiceTypeId = json['sub_product_service_type_id'];
    _mainProductServiceTypeId = json['main_product_service_type_id'];
    _cityId = json['city_id'];
    _departmentId = json['department_id'];
    _price = json['price'];
    _priceAfterDiscount = json['price_after_discount'];
    // ordered = json['ordered'];
    _image =
        json['image'] != null ? new AppImage.fromJson(json['image']) : null;
    if (json['variants'] != null) {
      json['variants'].forEach((v) {
        variants.add(new Variant.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    _trader =
        json['trader'] != null ? new Trader.fromJson(json['trader']) : null;
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media!.add(new Media.fromJson(v));
      });
    }
  }

  bool get isAvailable {
    return _isAvailable == 1;
  }

  bool get showTraderName {
    return _showTraderName == 1;
  }

  String get name {
    return _name ?? '';
  }

  String get productCode {
    return _productCode ?? '';
  }

  String get details {
    return _details ?? '';
  }

  String get detailedTitle {
    return _detailedTitle ?? '';
  }

  String get productImage {
    return _image?.imageUrl ?? '';
  }

  String get traderName {
    return _trader?.name ?? '';
  }

  String get traderWhats {
    return _trader?.whatsapp ?? '';
  }

  int get traderId {
    return _traderId ?? -1;
  }

  String get priceAfterDiscount {
    return '$_priceAfterDiscount';
  }

  String get price {
    return '$_price';
  }

  String get traderPhone {
    return _trader?.phoneNumber ?? '';
  }

  int get id {
    return _id ?? 0;
  }
}
