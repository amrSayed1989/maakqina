// ignore_for_file: unused_import, unused_field

import 'package:maak/models/sub_category.dart';
import 'package:maak/models/trader.dart';
import 'package:maak/utils/consts/urls.dart';

import 'category.dart';
import 'city.dart';
import 'logo.dart';

class Place {
  int? _id;
  String? _name;
  int? _showInMainPage;
  int? _showInMainDepartmentsPage;
  String? _about;
  String? _phoneNumber;
  int? _itemNumber;

  int? _cityId;
  int? _traderId;
  int? _categoryId;
  int? _subCategoryId;
  int? _ordered;
  Logo? _logo;
  String? _typeOfCategory;
  City? _city;
  Category? _category;
  SubCategory? _subCategory;
  Trader? _trader;

  Place.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _showInMainPage = json['show_in_main_page'];
    _showInMainDepartmentsPage = json['show_in_main_departments_page'];
    _about = json['about'];
    _phoneNumber = json['phone_number'];
    _itemNumber = json['item_number'];

    _cityId = json['city_id'];
    _traderId = json['trader_id'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _ordered = json['ordered'];
    _logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    _typeOfCategory = json['type_of_category'];
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    _subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    _trader =
        json['trader'] != null ? new Trader.fromJson(json['trader']) : null;
  }

  String get name {
    return _name ?? '';
  }

  String get image {
    return _logo?.logoUrl ?? '';
  }

  int get traderId {
    return _traderId ?? 0;
  }

  int get id {
    return _id ?? 0;
  }

  String get phoneNumber {
    return _phoneNumber ?? '';
  }

  String get about {
    return _about ?? '';
  }

  String get cityName {
    return _city?.name ?? '';
  }

  String get typeOfCategory {
    return (_typeOfCategory ?? "") == 'خدمي' ? 'الخدمات' : 'متجر';
  }

  String get placeType {
    return _typeOfCategory ?? "";
  }
}
