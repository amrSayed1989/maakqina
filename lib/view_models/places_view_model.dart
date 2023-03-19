// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/model_services/places.dart';
import 'package:maak/models/place.dart';
import 'package:maak/models/services.dart';
import 'package:maak/utils/consts/print_utils.dart';

import 'init_app_viewmodel.dart';

class PlacesViewModel extends ChangeNotifier {
  Places placesService = Places();
  Ads ads = Ads();

  bool isLoading = true;
  int page = 0;
  City? city;
  bool subLoading = false;

  Service? services;
  String? selectedService;

  String? commercial;
  String? service;
  MainAppViewModel initApp = Get.find();

  String get cityName {
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  PlacesViewModel() {
    this.city = initApp.city.value;
    initApp.city.listen((city) {
      this.city = city;
      println('-=-=-=- we listen to in places ${city.name} ${city.id}');
      reloadData();
    });
    _retrieveAllPlaces();
  }

  _retrieveAllPlaces() {
    var params = {
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      "show_in_main_departments_page": '1',
    };
    println('-------------- city ${city?.name}');
    if (services != null) {
      int i = 0;
      println(
          '---->>>> service id ${services!.id}  subcats = ${services!.subCategories.length}');
      if (services!.id == -2) {
        for (var ser in services!.subCategories) {
          if (ser.id != -1) {
            params.addAll({'sub_category_id[$i]': '${ser.id}'});
            i++;
          }
        }
      } else {
        for (var ser in services!.subCategories) {
          if (ser.id == -1 && ser.selected) {
            params.addAll({'category_id': '${services!.id}'});
            break;
          } else {
            if (ser.selected) {
              params.addAll({'sub_category_id[$i]': '${ser.id}'});
              i++;
            }
          }
        }
      }
    }
    println(params);
    notifyListeners();
    placesService.getPlaces(params, () {
      if (isLoading) {
        ads.getAds(city?.id ?? 1, () {
          isLoading = false;
          notifyListeners();
        });
      }
      subLoading = false;
      notifyListeners();
    });
  }

  reloadData() {
    isLoading = true;
    page = 0;
    placesService.places.clear();
    _retrieveAllPlaces();
  }

  loadMore() {
    subLoading = true;
    page += 1;
    _retrieveAllPlaces();
  }

  String get serviceType {
    return service ?? 'اماكن خدمية';
  }

  String get commercialType {
    return commercial ?? 'اماكن تجارية';
  }
}
