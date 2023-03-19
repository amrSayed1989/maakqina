// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/specialization.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maak/utils/consts/strings.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class AddNewCVViewModel extends ChangeNotifier {
  List<Specialization> specializations = [];
  String imagePath = '',
      cvPath = '',
      name = '',
      about = '',
      details = '',
      email = '',
      experience = '',
      age = '',
      phoneNumber = '';

  City? city;
  Specialization? specialization;

  AddNewCVViewModel() {
    retrieveJobFields();
  }

  retrieveJobFields() {
    AppApiHandler.getData(
        url: AppUrl.specializations,
        body: null,
        callback: (json) {
          if (json['data'] != null) {
            json['data'].forEach((v) {
              specializations.add(new Specialization.fromJson(v));
            });
          }
          notifyListeners();
        });
  }

  Future<String> sendCvData() async {
    if (imagePath.isEmpty ||
        name.isEmpty ||
        cvPath.isEmpty ||
        about.isEmpty ||
        email.isEmpty ||
        experience.isEmpty ||
        age.isEmpty ||
        phoneNumber.isEmpty ||
        details.isEmpty ||
        specialization == null ||
        city == null) return Future.value('EmptyFields');

    return await testPost();
  }

  Future<String> testPost() async {
    Response response;
    Dio dio = new Dio();
    var date = getFormedDateFrom(dateTime: DateTime.now());

    FormData formData = new FormData.fromMap({
      'photo': await MultipartFile.fromFile(imagePath, filename: imagePath),
      'cv': await MultipartFile.fromFile(cvPath, filename: cvPath),
      "name": name,
      'about': about,
      'details': details,
      'email': email,
      'years_of_experience': int.parse(experience),
      'age': int.parse(age),
      'city_id': city!.id,
      'specialization_id': specialization!.id ?? 0,
      'phone_number': int.parse(replaceFarsiNumber(phoneNumber)),
      'add_date': date,
    });

    response = await dio
        .post(
      AppUrl.jobOffers,
      data: formData,
      options: Options(
        headers: {
          "Accept": "application/json",
          // 'Content-Type': 'multipart/form-data'
          // "Content-Type": "application/json"
        },
      ),
    )
        .whenComplete(() {
      print("complete:");
    }).catchError((onError) {
      print("error:${onError.toString()}");
    });

    return Future.value(response.statusMessage);
  }
}
