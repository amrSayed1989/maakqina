// ignore_for_file: unused_import, unused_local_variable

import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';

import 'city.dart';
import 'image.dart';

class SliderItem {
  int? id;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  List<AppImage>? images;
  City? city;

  SliderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = [];
      int count = 0;
      json['images'].forEach((v) {
        images?.add(new AppImage.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  String get imageUrl {
    if (images != null) {
      if (images!.length > 0) {
        return images?[0].imageUrl ?? '';
      }
    }
    return "";
  }
}
