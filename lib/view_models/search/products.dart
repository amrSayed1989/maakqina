// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/products_service.dart';
import 'package:maak/models/city.dart';

class SearchProductsViewModel extends GetxController {
  var isLoading = false.obs;
  int page = 0;
  City? city;
  String name = '';
  var subLoading = false.obs;
  var gridSelected = true.obs;
  var products = ProductsServces().obs;

  SearchProductsViewModel(this.city);

  String get cityName {
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  void _retrieveProducts() async {
    // city = await Cities.getCityFromSF();
    // if(!isLoading){
    //   subLoading = true;
    //   page += 1;
    //
    // }
    update();
    products.value.getProducts({
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      "name": name
    }, () {
      // if(isLoading){
      //   ads.getAds(city?.id ?? 1, (){
      //     isLoading = false;
      //     notifyListeners();
      //   });
      // }
      isLoading.value = false;
      subLoading.value = false;
      update();
    });
  }

  void setGridOrList(bool value) {
    gridSelected.value = value;
    update();
  }

  searchData(String value) {
    isLoading.value = true;
    name = value;
    page = 0;
    products.value.data.clear();
    _retrieveProducts();
  }

  loadMore() {
    subLoading.value = true;
    page += 1;
    _retrieveProducts();
  }
}
