// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/places.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/city.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SearchPlacesViewModel extends GetxController {
  var places = Places().obs;
  var ads = Ads().obs;

  var isLoading = false.obs;
  int page = 0;
  City? city;
  var subLoading = false.obs;
  var about = '';

  _retrieveAllPlaces() {
    var params = {
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      'about': about
    };

    update();
    places.value.getPlaces(params, () {
      // if(isLoading.value){
      //   ads.value.getAds(city?.id ?? 1, (){
      //
      //     update();
      //   });
      // }
      isLoading.value = false;
      subLoading.value = false;
      update();
    });
  }

  searchData(value) {
    isLoading.value = true;
    page = 0;
    about = value;
    places.value.places.clear();
    _retrieveAllPlaces();
  }

  loadMore() {
    subLoading.value = true;
    page += 1;
    _retrieveAllPlaces();
  }
}
