// ignore_for_file: unused_field

import 'package:maak/models/trader.dart';
import 'package:maak/utils/consts/print_utils.dart';

import 'category.dart';
import 'city.dart';
import 'image.dart';

class OfferDetails {
  int? _id;
  String? _name;
  int? _showInMainPage;
  int? _showInMainOffersPage;
  int? _showInTraderPage;
  String? _description;
  String? _addDate;
  String? _dateEnd;
  String? _phoneNumber;
  String? _location;
  dynamic _price;
  String? _createdAt;
  String? _updatedAt;

  int? _categoryId;
  int? _traderId;
  int? _cityId;
  int? _subCategoryId;
  dynamic _ordered;
  List<AppImage> images = [];
  String? _typeOfCategory;
  City? _city;
  Category? _category;
  Trader? _trader;

  OfferDetails();

  OfferDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _showInMainPage = json['show_in_main_page'];
    _showInMainOffersPage = json['show_in_main_offers_page'];
    _showInTraderPage = json['show_in_trader_page'];
    _description = json['description'];
    _addDate = json['add_date'];
    _dateEnd = json['date_end'];
    _phoneNumber = json['phone_number'];
    _location = json['location'];
    _price = json['price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

    _categoryId = json['category_id'];
    _traderId = json['trader_id'];
    _cityId = json['city_id'];
    _subCategoryId = json['sub_category_id'];
    _ordered = json['ordered'];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        var imag = new AppImage.fromJson(v);
        println('------- offer image = ${imag.name}');
        images.add(imag);
      });
    }
    _typeOfCategory = json['type_of_category'];
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    _trader =
        json['trader'] != null ? new Trader.fromJson(json['trader']) : null;
  }

  String get description {
    return _description ?? '';
  }

  String get traderName {
    return _trader?.name ?? '';
  }

  bool get isTraderOffer {
    return _trader != null;
  }

  String get address {
    return _location ?? '';
  }

  String get price {
    return '$_price';
  }

  String get offerDate {
    return _addDate ?? '';
  }

  String get endDate {
    return _dateEnd ?? '';
  }

  String get offerName {
    return _name ?? '';
  }
}
