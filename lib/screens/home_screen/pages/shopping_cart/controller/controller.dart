// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:maak/models/coupons.dart';
import 'package:maak/models/shopping_cart.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';

class ShoppingCartController extends GetxController {
  var _shoppingCart = ShoppingCart().obs;
  var couponsService = CouponsService().obs;
  var _itemsCount = 0.obs;
  var _shoppingItems;
  var loading = true.obs;
  var afterFinishShopping = false;
  var discountValue = 0.0.obs;
  // var totalAfterDiscount = 0.0;

  //vars for cart

  String phoneNumber = '';
  String details = '';
  String address = '';
  Coupon? coupon;

  var isEmptyCart = false.obs;
  var initApp = Get.find<MainAppViewModel>();
  @override
  void onInit() {
    super.onInit();
    initCartItems();
  }

  retrieveCoupons() {
    couponsService.value.retrieveCoupons(() {
      loading.value = false;
    });
  }

  initCartItems() async {
    await _shoppingCart.value.toGet();
    // clearShoppingCart();
    _shoppingItems = _shoppingCart.value.items.obs;
    // _itemsCount.value = _shoppingCart.value.items.length;
    itemsCount;
  }

  int get itemsCount {
    _itemsCount.value = 0;
    for (CartItem item in shoppingItems) {
      _itemsCount.value += item.count!;
    }
    if (_itemsCount.value == 0)
      isEmptyCart.value = true;
    else
      isEmptyCart.value = false;
    return _itemsCount.value;
  }

  bool addItemToCart(CartItem cartItem) {
    for (var item in _shoppingCart.value.items) {
      if ((item.id == cartItem.id) &&
          (item.color == cartItem.color && item.size == cartItem.size)) {
        return false;
      }
    }
    _shoppingCart.value.items.add(cartItem);
    _shoppingItems.value.add(cartItem);
    _shoppingCart.value.toSave();
    itemsCount;
    return true;
  }

  clearShoppingCart() {
    _shoppingCart.value.items.clear();
    _shoppingCart.value.clearShoppingItems();
    _shoppingCart.value.traderName = null;
    _shoppingCart.value.traderId = null;
    // _shoppingCart.value.toSave();
    _shoppingItems.value.clear();
    itemsCount;
  }

  removeItem(int index) {
    var deleted = _shoppingCart.value.items.removeAt(index);
    _shoppingItems.value.removeAt(index);
    if (0 == _shoppingCart.value.items.length) {
      println('----------- last Item');
      _shoppingCart.value.traderId = null;
      _shoppingCart.value.traderName = null;
    }
    _shoppingCart.value.toSave();
    itemsCount;
    // update();
  }

  incrementItemCount(int index) {
    _shoppingCart.value.items[index].count =
        _shoppingCart.value.items[index].count! + 1;
    _shoppingCart.value.toSave();
    itemsCount;
    update();
  }

  decrementItemCount(int index) {
    _shoppingCart.value.items[index].count =
        _shoppingCart.value.items[index].count! - 1;
    _shoppingCart.value.toSave();
    itemsCount;
    update();
  }

  double get totalBeforeDiscount {
    double count = 0.0;
    println('------------------>>.>>. checking null $shoppingItems');
    for (CartItem item in shoppingItems) {
      count += (item.count! * (double.tryParse(item.price!) ?? 0));
    }
    return count;
  }

  List<CartItem> get shoppingItems {
    return _shoppingItems.value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Map<String, String>> testPost() async {
    var token = initApp.userService.value.token;
    print(token);

    var url = 'https://m3akm3ak.com/api/v1/orders';

    var mapOfProduct = _shoppingCart.value.items.map((e) {
      return {"product_variant_id": '${e.variantId}', "quantity": '${e.count}'};
    }).toList();

    println(mapOfProduct.runtimeType);

    var data = {
      'details': details,
      "address": address,
      'phone_number': phoneNumber,
      // 'coupon_id' : couponId,
      'subtotal': totalBeforeDiscount, // total of all [totalPrice]

      // 'discount': couponValue, // value of discount

      'total':
          "${this.totalBeforeDiscount - this.discountValue.value}", // final total value

      'order_products': mapOfProduct
    };

    if (coupon != null) {
      var couponValue = coupon?.fixedDiscount == null
          ? coupon?.percentageDiscount
          : coupon?.fixedDiscount;
      data.addAll({
        'coupon_id': '${coupon?.id}',
        'discount': couponValue ?? '',
      });
    }
    println(data);

    // if (couponId == 0) {
    //   data = {
    //     'details': details,
    //     "address": address,
    //     'phone_number': phoneNumber,
    //     // 'coupon_id' : couponId,
    //     'subtotal': totalPrice, // total of all [totalPrice]
    //
    //     // 'discount': couponValue, // value of discount
    //
    //     'total': totalPrice, // final total value
    //
    //     'order_products': mapOfProduct
    //   };
    // } else {
    //   data = {
    //     'details': details,
    //     "address": address,
    //     'phone_number': phoneNumber,
    //
    //     'coupon_id': couponId,
    //
    //     'subtotal': subTotal, // total of all [totalPrice]
    //
    //     'discount': couponValue, // value of discount
    //
    //     'total': finalTotal, // final total value
    //
    //     'order_products': mapOfProduct
    //   };
    // }
    //

    var body = json.encode(data);
    print(body);

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);
    var jsonMap = json.decode(response.body);
    print(jsonMap);
    print(response.statusCode);
    if (response.statusCode == 201) {
      var title = 'تم ارسال الطلب بنجاح';
      var text = 'سوف يتم متابعة طلبك من قبل الادارة';
      return {'title': title, 'text': text, 'code': '1'};
    } else {
      if (response.body ==
          '{"messages":"Product Number is less than quantity requiredChelsea Jenkins"}') {
        var title = 'تنبيه';
        var text = 'العنصر او احد العناصر التي طلبتها غير متوفره الان';
        return {'title': title, 'text': text, 'code': '2'};
      } else {
        var title = 'هناك مشكلة ما';
        var text = 'حاول الطلب في وقت أخر';
        return {'title': title, 'text': text, 'code': '3'};
      }
    }
  }

  // int? traderId;
  set traderName(String? value) => _shoppingCart.value.traderName = value;
  String? get traderName => _shoppingCart.value.traderName;

  set traderId(int? value) => _shoppingCart.value.traderId = value;
  int? get traderId => _shoppingCart.value.traderId;
}
