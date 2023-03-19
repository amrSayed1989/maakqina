// ignore_for_file: unused_field, unused_import

import 'package:maak/models/photo.dart';
import 'package:maak/models/specialization.dart';

import 'city.dart';
import 'cv.dart';
import 'media.dart';

class JobOffer {
  int? _id;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _details;
  int? _approved;
  String? _addDate;
  String? _about;
  int? _age;
  String? _yearsOfExperience;
  String? _createdAt;
  String? _updatedAt;
  int? _specializationId;
  int? _cityId;
  int? _adminSeen;
  Photo? _photo;
  Cv? _cv;
  Specialization? _specialization;
  City? _city;
  // List<Media>? media;

  JobOffer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _details = json['details'];
    _approved = json['approved'];
    _addDate = json['add_date'];
    _about = json['about'];
    _age = json['age'];
    _yearsOfExperience = json['years_of_experience'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _specializationId = json['specialization_id'];
    _cityId = json['city_id'];
    _adminSeen = json['admin_seen'];
    _photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    _cv = json['cv'] != null ? new Cv.fromJson(json['cv']) : null;
    _specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
    _city = json['city'] != null ? new City.fromJson(json['city']) : null;
    // if (json['media'] != null) {
    //   media = [];
    //   json['media'].forEach((v) {
    //     media!.add(new Media.fromJson(v));
    //   });
    // }
  }

  String get nameOfPerson {
    return _name ?? '';
  }

  String get specialist {
    return _specialization?.name ?? '';
  }

  String get cityName {
    return _city?.name ?? '';
  }

  String get imageUrl {
    return _photo?.photoUrl ?? '';
  }

  String get phoneNumber {
    return _phoneNumber ?? '';
  }

  String get age {
    return '$_age';
  }

  String get yearsOfExperience {
    return _yearsOfExperience ?? '';
  }

  String get about {
    return _about ?? '';
  }

  String get details {
    return _details ?? '';
  }

  String get email {
    return _email ?? '';
  }

  String get cv {
    return _cv?.url ?? '';
  }
}
