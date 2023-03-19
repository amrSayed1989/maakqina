// ignore_for_file: unused_import

import 'package:maak/models/place.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class Places {
  List<Place> places = [];
  int countDepartments = 0;
  int countPage = 0;
  int? status;
  String? message;
  int? statusCode;

  Places();

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        places.add(new Place.fromJson(v));
      });
    }
    countDepartments = json['countDepartments'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getPlaces(Map<String, String> params, onDone) async {
    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    AppApiHandler.getData(
        url: '${AppUrl.places}/$queryParameters',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}
