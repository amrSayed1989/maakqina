// ignore_for_file: unused_import, dead_code

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/specialization.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/strings.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';
import 'package:http/http.dart' as http;

import '../utils/images_utils/image_compressing.dart';

class AddNewJobViewModel extends ChangeNotifier {
  List<Specialization> specializations = [];
  String imagePath = '',
      placeName = '',
      details = '',
      email = '',
      whatsappNumber = '';

  City? city;
  Specialization? specialization;

  AddNewJobViewModel() {
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
        placeName.isEmpty ||
        email.isEmpty ||
        whatsappNumber.isEmpty ||
        details.isEmpty ||
        specialization == null ||
        city == null) return Future.value('EmptyFields');

    return await testPost();
  }

  Future<String> testPost() async {
    // Response response;
    // Dio dio = new Dio();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.jobs),
    );

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "multipart/form-data"
    };

    File? f = await compressImage(File(imagePath));
    if (f != null) {
      request.files.add(await http.MultipartFile.fromPath('image', f.path));
    }
    var date = getFormedDateFrom(dateTime: DateTime.now());

    request.fields.addAll({
      "name": placeName,
      'details': details,
      'email': email,
      'city_id': '${city!.id}',
      'specialization_id': '${specialization!.id ?? 0}',
      'whats_app_number': '${int.parse(replaceFarsiNumber(whatsappNumber))}',
      'add_date': date,
    });
    request.headers.addAll(headers);
    println('-----------------request----- add job --------------');
    println('---->>> request ${request.fields}');
    println('---->>> request ${request.files.toString()}');
    print("------- request: " + request.toString());
    var res = await request.send();
    // http.Response response = await http.Response.fromStream(res);
    // setState(() {
    //   resJson = jsonDecode(response.body);
    // });
    println('------------response---------- add job --------------');
    println('---->>> response ${res.statusCode}');
    // println('---->>> response ${res.stream.}');

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Future.value('Created');
    } else {
      return Future.value('not Created');
    }
    // var photo = await MultipartFile.fromFile(imagePath, filename: imagePath);
    // var photo = MultipartFile.fromFileSync(imagePath,
    //     filename: 'upload.png');
    // FormData formData = new FormData.fromMap({
    //   'image': photo,
    //   "name": placeName,
    //   'details': details,
    //   'email': email,
    //   'city_id': city!.id,
    //   'specialization_id': specialization!.id ?? 0,
    //   'whats_app_number': int.parse(replaceFarsiNumber(whatsappNumber)),
    //   'add_date': intl.DateFormat('yyyy-MM-dd').format(DateTime.now()),
    // });

    // println(formData.fields);
    // println(formData.files);
    // response = await dio
    //     .post(
    //   AppUrl.jobs,
    //   data: formData,
    //   options: Options(
    //     headers: {
    //       "Accept": "application/json",
    //       'Content-Type': 'multipart/form-data'
    //       // "Content-Type": "application/json"
    //     },
    //   ),
    // )
    //     .whenComplete(() {
    //   print("complete:");
    // }).catchError((onError) {
    //   print("error:${onError.toString()}");
    // });

    return Future.value('Created');
  }
}
