// ignore_for_file: unused_field

import 'package:maak/models/image.dart';
import 'package:maak/utils/consts/print_utils.dart';

class Trader {
  int? _id;
  String? _type;
  String? _name;
  String? _address;
  int? _cityId;
  String? _phoneNumber;
  String? _activeness;
  String? _details;
  String? _facebookUrl;
  String? _whatsapp;
  String? _createdAt;
  String? _updatedAt;
  bool selected = false;
  List<AppImage>? _images;
  String? _typeOfTrader;
  // List<Media> media;

  Trader.fromJson(Map<String, dynamic> json) {
    println('------ trader');
    println(json);
    _id = json['id'];
    _type = json['type'];
    _name = json['name'];
    _address = json['address'];
    _cityId = json['city_id'];
    _phoneNumber = json['phone_number'];
    _activeness = json['activeness'];
    _details = json['details'];
    _facebookUrl = json['facebook_url'];
    _whatsapp = json['whatsapp'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(new AppImage.fromJson(v));
      });
    }

    _typeOfTrader = json['type_of_trader'];
  }

  String get name {
    return _name ?? '';
  }

  String get phoneNumber {
    return _phoneNumber ?? '';
  }

  String get whatsapp {
    return _whatsapp ?? '';
  }

  String get address {
    return _address ?? '';
  }

  String get id {
    return _id != null ? '$_id' : '';
  }
}
