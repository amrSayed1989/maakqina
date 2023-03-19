import 'package:maak/models/product.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class ProductService{
  Product product;

  ProductService(this.product);
  fromJson(Map<String, dynamic> json) {

    if((json['data'] != null ? new Product.fromJson(json['data']) : null) != null) {
      product =
      (json['data'] != null ? new Product.fromJson(json['data']) : null)!;
    }
  }

  getSingleProduct(onDone){
    println('************** ${AppUrl.products}/${product.id}');
    AppApiHandler.getData(url: '${AppUrl.products}/${product.id}', body: null, callback: (json){
      this.fromJson(json);
      onDone();
    });
  }
}