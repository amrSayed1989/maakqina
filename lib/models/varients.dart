// ignore_for_file: unused_field

import 'package:maak/models/product_size.dart';

import 'pivot.dart';

import 'color.dart';
import 'image.dart';
import 'media.dart';

class Variant {
  int? id;
  String? _price;
  int? _sizeId;
  int? _colorId;
  int? _count;
  int? _isAvailable;
  List<AppImage>? _images;
  String? _colorName;
  String? _sizeName;
  Pivot? _pivot;
  AppColor? _color;
  ProductSize? _size;
  List<Media>? _media;

  Variant();

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _price = json['price'];
    _sizeId = json['size_id'];
    _colorId = json['color_id'];
    _count = json['count'];
    _isAvailable = json['is_available'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images!.add(new AppImage.fromJson(v));
      });
    }
    _colorName = json['color_name'];
    _sizeName = json['size_name'];
    _pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    _color =
        json['color'] != null ? new AppColor.fromJson(json['color']) : null;
    _size =
        json['size'] != null ? new ProductSize.fromJson(json['size']) : null;
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        // media!.add(new Media.fromJson(v));
      });
    }
  }

  String get count {
    return '${_count ?? 0}';
  }

  String get price {
    return _price ?? '';
  }

  String get sizeName {
    return _sizeName ?? '';
  }

  String get colorName {
    return _colorName ?? '';
  }

  List<AppImage> get images {
    var imgs = <String>[];
    if (_images != null) {
      for (var imageUrl in _images!) {
        imgs.add(imageUrl.imageUrl);
      }
    }
    return _images ?? [];
  }
}
