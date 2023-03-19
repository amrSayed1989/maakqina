import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/city.dart';
import 'package:maak/model_services/products_service.dart';
import '../models/brand.dart';
import '../models/color.dart';
import '../models/product_services.dart';
import '../utils/consts/print_utils.dart';
import 'init_app_viewmodel.dart';

class ProductsViewModel extends ChangeNotifier{
  bool isLoading = true;
  int page = 0;
  City? city;
  bool subLoading = false;
  bool gridSelected = true;
  Ads ads = Ads();
  ProductsServces products = ProductsServces();

  String? service;
  String? commercial;
  ProductService? productService;
  String main_product_type_id = '';
  String main_product_service_type_id = '';
  String sub_product_type_id = '';
  String sub_product_service_type_id = '';
  String SortByLowerPrice = '';
  String LowerPrice = '';
  String HigherPrice = '';
  String PriceAfterDiscount = '';
  String RecentlyAdded = '';

  String type = '';

  var colors = <AppColor>[];
  var sizes = <AppSize>[];
  var brands = <Brand>[];
  var traders = <FilterTrader>[];
  MainAppViewModel initApp = Get.find();

  ProductsViewModel(){
    this.city = initApp.city.value;
    initApp.city.listen((city){
      this.city = city;
      println('-=-=-=- we listen to in products ${city.name} ${city.id}');
      reloadData();
    });
    _retrieveProducts();
  }

  void _retrieveProducts() async {

    var params = {
      'city_id':city == null ? '' : '${city?.id}',
      "page": '$page',
      'SortByLowerPrice':SortByLowerPrice,
      'LowerPrice':LowerPrice,
      'HigherPrice':HigherPrice,
      'show_in_main_page':'1',
      'PriceAfterDiscount':PriceAfterDiscount,
      'RecentlyAdded':RecentlyAdded
    };

    if(productService != null && productService?.id == '-2'){
      if(type == 'main_product_service_types'){
        // params.addAll({'main_product_service_type_id':'${productService?.id}',});
        for(int i=0;i<productService!.subCategories.length;i++){
          if(productService!.subCategories[i].selected)
            params.addAll({'sub_product_service_type_id[$i]':'${productService!.subCategories[i].id}',});
        }
      }else{
        // params.addAll({'main_product_type_id':'${productService?.id}',});
        for(int i=0;i<productService!.subCategories.length;i++){
          if(productService!.subCategories[i].selected && productService!.subCategories[i].id != '-1' )
            params.addAll({'sub_product_type_id[$i]':'${productService!.subCategories[i].id}',});
        }
      }
    }else{
      if(productService != null && productService?.id != '-1'){
        if(type == 'main_product_service_types'){
          params.addAll({'main_product_service_type_id':'${productService?.id}',});
          for(int i=0;i<productService!.subCategories.length;i++){
            if(productService!.subCategories[i].selected)
              params.addAll({'sub_product_service_type_id[$i]':'${productService!.subCategories[i].id}',});
          }
        }else{
          params.addAll({'main_product_type_id':'${productService?.id}',});
          for(int i=0;i<productService!.subCategories.length;i++){
            if(productService!.subCategories[i].selected && productService!.subCategories[i].id != '-1' )
              params.addAll({'sub_product_type_id[$i]':'${productService!.subCategories[i].id}',});
          }
        }
      }
    }


    if(sub_product_type_id != ''){
      params.addAll({'sub_product_type_id[0]':'$sub_product_type_id',});
    }
    for(int i=0;i<colors.length;i++){
      if(colors[i].selected)
      params.addAll({'Color[$i]':'${colors[i].id}'});
    }
    for(int i=0;i<brands.length;i++){
      if(brands[i].selected)
      params.addAll({'Brand[$i]':'${brands[i].id}'});
    }
    for(int i=0;i<sizes.length;i++){
      if(sizes[i].selected)
      params.addAll({'Size[$i]':'${sizes[i].id}'});
    }

    for(int i=0;i<traders.length;i++){
      if(traders[i].selected)
        params.addAll({'trader_id[$i]':'${traders[i].id}'});
    }


    println('----- params ---------------------');
    println(json.encode(params));
    println('----- params ---------------------');
    notifyListeners();
    products.getProducts(params,(){

      if(isLoading){
        ads.getAds(city?.id ?? 1, (){
          isLoading = false;
          notifyListeners();
        });
      }
      isLoading = false;
      subLoading = false;
      notifyListeners();
    });
  }

  void setGridOrList(bool value){
    gridSelected = value;
    notifyListeners();
  }


  reloadData(){

    isLoading = true;
    page = 0;
    products.data.clear();
    _retrieveProducts();
  }

  loadMore(){
    subLoading = true;
    page += 1;
    _retrieveProducts();
  }

  String get serviceType{
    return service ?? 'منتجات خدمية';
  }

  String get commercialType{
    return commercial ?? 'منتجات تجارية' ;
  }

  String get cityName{
    return city == null ? 'كل المدن' : '${city?.name}';
  }

}