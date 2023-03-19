// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:maak/model_services/product_service.dart';
import 'package:maak/models/product.dart';
import 'package:maak/models/varients.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SingleProductViewModel extends ChangeNotifier {
  ProductService productService;

  Map<String, List<Variant>> colors = {};
  List<Variant>? variant;
  Variant? variantItem;
  String mainImage = '';
  bool showDetails = true;

  bool isFromNotif;
  bool loading = false;

  setShowDetails() {
    showDetails = !showDetails;
    notifyListeners();
  }

  // SingleProductViewModel.withid(int id,){
  //   productService = ProductService(Product(id: id))..getSingleProduct(id, (){});
  // }
  // final Product product;
  SingleProductViewModel(this.productService, {this.isFromNotif = false}) {
    if (isFromNotif) {
      loading = true;
      notifyListeners();
      productService.getSingleProduct(() {
        setMainImage(productService.product.productImage);
        for (Variant variant in productService.product.variants) {
          var vars = colors[variant.colorName];
          if (vars != null) {
            vars.addAll([variant]);
            colors.putIfAbsent(variant.colorName, () => vars);
          } else {
            colors.putIfAbsent(variant.colorName, () => [variant]);
          }
        }
        loading = false;
        notifyListeners();
      });
    } else {
      setMainImage(productService.product.productImage);
      for (Variant variant in productService.product.variants) {
        var vars = colors[variant.colorName];
        if (vars != null) {
          vars.addAll([variant]);
          colors.putIfAbsent(variant.colorName, () => vars);
        } else {
          colors.putIfAbsent(variant.colorName, () => [variant]);
        }
      }
    }
  }

  setMainImage(String imageUrl) {
    mainImage = imageUrl;
    notifyListeners();
  }

  setVariant(List<Variant> variant) {
    println(variant.first.images.length);
    this.variant = variant;
    notifyListeners();
  }

  setVariantItem(Variant? variantItem) {
    this.variantItem = variantItem;
    notifyListeners();
  }
}
