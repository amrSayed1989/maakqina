import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/ads/ad_service.dart';
import 'package:maak/models/ads/ad_category.dart';
import 'package:maak/models/ads/ad_sub_category.dart';
import 'package:maak/models/city.dart';
import 'package:intl/intl.dart' as intl;

import '../utils/consts/print_utils.dart';
import '../utils/consts/strings.dart';
import '../utils/consts/urls.dart';
import '../utils/images_utils/image_compressing.dart';

class AddNewAdViewModel extends ChangeNotifier {
  AdCategoriesService adCategoriesService = AdCategoriesService();
  // String imagePath = '',
  String name = '',
      adDetails = '',
      address = '',
      price = '',
      phoneNumber = '',
      whatsappNumber = '';
  // File? file;
  List<File> files = [];

  City? city;
  AdCategory? selectedCategory;
  AdSubCategory? selectedAdSubCategory;
  bool loadingCats = true;

  AddNewAdViewModel() {
    retrieveCategories();
  }

  retrieveCategories() {
    adCategoriesService.getAdsCategories(onDone: () {
      loadingCats = false;
      notifyListeners();
    });
  }

  Future<String> sendAdData() async {
    if (files.isEmpty ||
        name.isEmpty ||
        adDetails.isEmpty ||
        address.isEmpty ||
        price.isEmpty ||
        phoneNumber.isEmpty ||
        selectedCategory == null ||
        city == null) return Future.value('يجب اكمال جميع البيانات');
    // return Future.value('جاري العمل علي هذه الصفحة');

    List<File> compressedFiles = [];
    for (var file in files) {
      File? f = await compressImage(file);
      if (f != null) {
        compressedFiles.add(f);
      }
      println(
          "file after ==========?????? ${f!.readAsBytesSync().lengthInBytes}");
    }

    List multipartArray = [];
    for (var file in files) {
      println("---- file path???? ${file.path}");
      File? f = await compressImage(file);
      if (f != null) {
        println("---- file path>>>>> ${f.path}");
        multipartArray
            .add(MultipartFile.fromFileSync(f.path, filename: 'upload.png'));
      }
    }

    // multipartArray.add(MultipartFile.fromFileSync(imagePath,
    //     filename: imagePath.split('/').last));
    return await testPost(multipartArray);
  }

  Future testPost(List multipartArray) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.news),
    );

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "multipart/form-data"
    };

    for (var file in files) {
      File? f = await compressImage(file);
      if (f != null) {
        println("---- file path>>>>> ${f.path}");
        request.files.add(await http.MultipartFile.fromPath('image[]', f.path));
      }
    }

    var date = getFormedDateFrom(dateTime: DateTime.now());
    request.fields.addAll({
      "name": '${this.name}',
      'detailed_title': '${this.address}',
      'details': '${this.adDetails}',
      'add_date':
          date, //"${intl.DateFormat('yyyy-MM-dd').format(DateTime.now())}", // dateOffAdding,
      'price': '${this.price}', // int.parse(replaceFarsiNumber(price)),
      'phone_number':
          '${this.phoneNumber}', // int.parse(replaceFarsiNumber(phoneNumber)),
      'whatsapp_number': '${this.whatsappNumber}',
      'news_category_id': '${selectedCategory!.id}', // int.parse(mainSection),
      'news_sub_category_id':
          '${selectedAdSubCategory!.id}', //int.parse(subSection),
      'city_id': '${this.city!.id}', // int.parse(city),
    });

    request.headers.addAll(headers);
    println('-----------------request----- add job ---- $date ----------');
    println('---->>> request ${request.fields}');
    println('---->>> request ${request.files.toString()}');
    print("------- request: " + request.toString());
    // return Future.value('\n${intl.DateFormat('yyyy-MM-dd').format(DateTime.now())}');

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    // setState(() {
    //   resJson = jsonDecode(response.body);
    // });
    println('------------response---------- add job --------------');
    println('---->>> response ${res.statusCode}');
    println('---->>> response ${response.body}');
    if (res.statusCode == 200 || res.statusCode == 201) {
      return Future.value('تم انشاء الاعلان بنجاح وفي انتظار المراجعة');
    } else {
      return Future.value(
          '${response.body}\nstatus code:${response.statusCode}\n${intl.DateFormat('yyyy-MM-dd').format(DateTime.now())}');
    }

    // Response response;
    // Dio dio = new Dio();
    //
    // FormData formData = new FormData.fromMap({
    //   "name": this.name,
    //   'detailed_title': this.address,
    //   'details': this.adDetails,
    //   'add_date': intl.DateFormat('yyyy-MM-dd').format(DateTime.now()), // dateOffAdding,
    //   'price': this.price, // int.parse(replaceFarsiNumber(price)),
    //   'phone_number': this.phoneNumber, // int.parse(replaceFarsiNumber(phoneNumber)),
    //   'news_category_id': selectedCategory!.id, // int.parse(mainSection),
    //   'news_sub_category_id': selectedAdSubCategory!.id, //int.parse(subSection),
    //   'city_id': this.city!.id, // int.parse(city),
    //   'image[]': multipartArray,
    // });
    // print('------------- after form data');
    //
    // response = await dio
    //     .post(
    //   url,
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
    //   // Navigator.pop(context);
    //   print("complete: ---------- ");
    //
    //
    // }).catchError((onError) {
    //   // Navigator.pop(context);
    //   return Future.value('هناك مشكلة ما، حاول مرة اخرى');
    //
    // });
    // if(response.statusCode == 200 || response.statusCode == 201){
    //   return Future.value('تم انشاء الاعلان بنجاح وفي انتظار المراجعة');
    // }
    //
    // return Future.value('هناك مشكلة ما، حاول مرة اخرى');
  }

  setCategory(int id, String name) {
    selectedCategory = AdCategory(
      id: id,
      name: name,
    );
    notifyListeners();
  }

  // setSubCategory(int id, String name) {
  // selectedAdSubCategory = AdCategory(
  // id: id,
  // name: name,
  // );
  // notifyListeners();
  // }
}
