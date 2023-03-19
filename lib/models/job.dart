// ignore_for_file: unused_import, unused_field

import 'package:maak/models/specialization.dart';

import 'city.dart';
import 'image.dart';
import 'media.dart';

class Job {
  int? _id;
  String? _name;
  String? _whatsAppNumber;
  String? _email;
  String? _addDate;
  int? _approved;
  String? _details;
  String? _createdAt;
  String? _updatedAt;
  int? _cityId;
  int? _specializationId;
  int? _adminSeen;
  AppImage? _image;
  String? _isApproved;
  City? _city;
  Specialization? _specialization;
  // List<Media>? _media;

  Job.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _whatsAppNumber = json['whats_app_number'];
    _email = json['email'];
    _addDate = json['add_date'];
    _approved = json['approved'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _cityId = json['city_id'];
    _specializationId = json['specialization_id'];
    _adminSeen = json['admin_seen'];
    _image =
        json['image'] != null ? new AppImage.fromJson(json['image']) : null;
    _isApproved = json['is_approved'];
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
    _specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
    // if (json['media'] != null) {
    //   _media = [];
    //   json['media'].forEach((v) {
    //     _media!.add(new Media.fromJson(v));
    //   });
    // }
  }

  String get titleOfJob {
    return _name ?? '';
  }

  String get nameOfSpecialist {
    return _specialization?.name ?? '';
  }

  String get dateOfAddingJob {
    return _addDate ?? '';
  }

  String get cityName {
    return _city?.name ?? '';
  }

  String get jobImage {
    return _image?.imageUrl ?? '';
  }

  String get whatsappNumber {
    return _whatsAppNumber ?? '';
  }

  String get details {
    return _details ?? '';
  }
}
