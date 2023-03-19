class Pivot {
  int? productId;
  int? variantId;

  Pivot({this.productId, this.variantId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantId = json['variant_id'];
  }


}