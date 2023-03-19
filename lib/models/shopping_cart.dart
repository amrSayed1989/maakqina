import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart {

  List<CartItem> items = <CartItem>[];
  int? traderId;
  String? traderName;

  ShoppingCart();

  toGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('shopping_cart');
    if(value != null){
      var data = json.decode(value);
      traderId = data['trader_id'];
      traderName = data['trader_name'];
      if (data['items'] != null) {
        data['items'].forEach((v) {
          items.add(new CartItem.fromJson(v));
        });
      }
    }
  }

  Future<bool> toSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['trader_id'] = this.traderId;
    data['trader_name'] = this.traderName;
    data['items'] = this.items.map((v) => v.toJson()).toList();

    var value = json.encode(data);
    var done = prefs.setString('shopping_cart', value);
    return done;
  }
  clearShoppingItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('shopping_cart');
  }
}

class CartItem {
  int? id;
  int? variantId;
  String? name;
  String? color;
  String? size;
  int? count;
  String? price;
  String? image;

  CartItem(
        this.id,
        this.name,
        this.color,
        this.size,
        this.count,
        this.price,
        this.variantId,
        this.image);

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    size = json['size'];
    count = json['count'];
    price = json['price'];
    image = json['image'];
    variantId = json['variantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['size'] = this.size;
    data['count'] = this.count;
    data['price'] = this.price;
    data['image'] = this.image;
    data['variantId'] = this.variantId;
    return data;
  }
}
