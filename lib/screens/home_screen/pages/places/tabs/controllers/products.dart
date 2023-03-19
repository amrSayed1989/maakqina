// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:maak/models/product.dart';
import '../../../../../../model_services/trader_service.dart' as cats;
import '../../../../../../models/brand.dart';
import '../../../../../../models/color.dart';
import '../../../../../../utils/consts/print_utils.dart';
import '../../../../../../utils/consts/urls.dart';
import '../../../../../../utils/network/api.dart';

class TraderProductsControllers extends GetxController {
  var traderProducts = TraderProducts().obs;
  var loading = true.obs;
  var subLoading = false.obs;

  var data = <Product>[].obs;
  List<cats.MainCategories> mainCategories = [];

  var _catName = 'التصنيف'.obs;
  set catName(value) => _catName.value = value;
  String get catName {
    // if(_catName.value == '')
    if (_catName.value.length > 15) {
      return '${_catName.value.substring(0, 13)}...';
    }
    return _catName.value;
  }

  var firstTimeLoaded = true;

  int page = 0;

  String? traderType;

  String main_product_type_id = '';
  String main_product_service_type_id = '';
  String sub_product_type_id = '';
  String sub_product_service_type_id = '';
  String SortByLowerPrice = '';
  String LowerPrice = '';
  String HigherPrice = '';
  String PriceAfterDiscount = '';
  String RecentlyAdded = '';
  String searchName = '';
  var colors = <AppColor>[];
  var sizes = <AppSize>[];
  var brands = <Brand>[];
  var traders = <FilterTrader>[];

  int? traderId;

  retrieveOffer() {
    var params = {
      "page": '$page',
      'main_product_type_id': main_product_type_id,
      'main_product_service_type_id': main_product_service_type_id,
      'name': searchName,
      'sub_product_service_type_id': sub_product_service_type_id,
      'SortByLowerPrice': SortByLowerPrice,
      'LowerPrice': LowerPrice,
      'HigherPrice': HigherPrice,
      'show_in_trader_page': '1',
      'PriceAfterDiscount': PriceAfterDiscount,
      'RecentlyAdded': RecentlyAdded
    };
    if (sub_product_type_id != '') {
      params.addAll({
        'sub_product_type_id[0]': '$sub_product_type_id',
      });
    }
    for (int i = 0; i < colors.length; i++) {
      if (colors[i].selected) params.addAll({'Color[$i]': '${colors[i].id}'});
    }
    for (int i = 0; i < brands.length; i++) {
      if (brands[i].selected) params.addAll({'Brand[$i]': '${brands[i].id}'});
    }
    for (int i = 0; i < sizes.length; i++) {
      if (sizes[i].selected) params.addAll({'Size[$i]': '${sizes[i].id}'});
    }

    for (int i = 0; i < traders.length; i++) {
      if (traders[i].selected)
        params.addAll({'trader_id[$i]': '${traders[i].id}'});
    }

    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    AppApiHandler.getData(
        url: '$apiVersion/getTraderProductsById/$traderId$queryParameters',
        body: null,
        callback: (json) {
          traderProducts.value.fromJson(json);
          if (json['data'] != null) {
            json['data'].forEach((v) {
              data.add(new Product.fromJson(v));
            });
          }
          // data.addAll(traderProducts.value.data);
          loading.value = false;
          subLoading.value = false;
        });
  }

  loadMore() {
    subLoading.value = true;
    page += 1;
    retrieveOffer();
  }

  reloadData() {
    loading.value = true;
    page = 0;
    data.clear();
    retrieveOffer();
  }
}

class TraderProducts {
  // List<Product> data = [];
  int? countProducts;
  int? countPage;
  int? status;
  String? message;
  int? statusCode;

  TraderProducts();

  fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    //
    //   json['data'].forEach((v) {
    //     data.add(new Product.fromJson(v));
    //   });
    // }
    countProducts = json['countProducts'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }
}
