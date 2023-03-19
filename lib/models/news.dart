// ignore_for_file: unused_import, unused_field

import 'package:maak/models/image.dart';
import 'package:maak/utils/consts/print_utils.dart';

import 'city.dart';
import 'news_category.dart';

class News {
  int? _id;
  String? _name;
  String? _detailedTitle;
  String? _details;
  String? _addDate;
  String? _price;
  String? _phoneNumber;
  String? _whatsappNumber;

  int? _approved;
  int? _addedByAdmin;

  int? _newsCategoryId;
  int? _newsSubCategoryId;
  int? _cityId;
  int? _adminSeen;
  int? _ordered;
  List<AppImage>? _images;
  NewsCategory? _newsCategory;
  City? _city;

  News.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _detailedTitle = json['detailed_title'];
    _details = json['details'];
    _addDate = json['add_date'];
    _price = json['price'];
    _phoneNumber = json['phone_number'];
    _approved = json['approved'];
    _addedByAdmin = json['added_by_admin'];
    _whatsappNumber = json['whatsapp_number'];
    _newsCategoryId = json['news_category_id'];
    _newsSubCategoryId = json['news_sub_category_id'];
    _cityId = json['city_id'];
    _adminSeen = json['admin_seen'];
    _ordered = json['ordered'];
    if (json['image'] != null) {
      _images = [];
      json['image'].forEach((v) {
        _images!.add(new AppImage.fromJson(v));
      });
    }
    _newsCategory = json['news_category'] != null
        ? new NewsCategory.fromJson(json['news_category'])
        : null;
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  String get name {
    return _name ?? '';
  }

  String get whatsappNumber {
    return _whatsappNumber ?? '';
  }

  String get price {
    return _price ?? '';
  }

  String get dateOffAdding {
    return _addDate ?? '';
  }

  String get cityName {
    return _city?.name ?? '';
  }

  String get firstImage {
    return _images?[0].imageUrl ?? '';
  }

  String get phoneNumber {
    return _phoneNumber ?? '';
  }

  String get details {
    return _details ?? '';
  }

  String get address {
    return _detailedTitle ?? '';
  }

  int get id {
    return _id ?? 0;
  }

  List<AppImage> get images {
    return _images ?? [];
  }
}
