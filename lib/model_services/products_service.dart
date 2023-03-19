// ignore_for_file: unused_import

import 'package:maak/models/product.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class ProductsServces {
  List<Product> data = [];
  int? countProducts;
  int countPage = 0;
  int? status;
  String? message;
  int? statusCode;

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Product.fromJson(v));
      });
    }
    countProducts = json['countProducts'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getProducts(Map<String, String> params, onDone) async {
    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    AppApiHandler.getData(
        url: '${AppUrl.products}$queryParameters',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}
