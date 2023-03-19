import 'package:maak/utils/consts/print_utils.dart';

import '../utils/consts/urls.dart';
import '../utils/network/api.dart';

class CouponsService {
  List<Coupon> coupons = <Coupon>[];

  CouponsService();

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        coupons.add(new Coupon.fromJson(v));
      });
    }
  }

  retrieveCoupons(onDone){
    AppApiHandler.getData(url: '${AppUrl.coupons}', body: null, callback: (json){
      this.fromJson(json);
      println('--->>>----- coupons ');
      println(json);
      println('--->>>----- coupons ');
      onDone();
    });
  }

  Coupon? getCouponFor({required int traderId}){
    println('----->>>>>> traderId = $traderId');
    for(Coupon coupon in coupons){
      if((coupon.traderId ?? -1) == traderId){
        return coupon;
      }
    }
    return null;
  }

}

class Coupon {
  int? id;
  String? code;
  String? fixedDiscount;
  String? percentageDiscount;
  int? maxUsagePerUser;
  int? numberOfUsage;
  int? minTotal;
  String? expireDate;
  String? createdAt;
  String? updatedAt;
  int? traderId;

  Coupon(
      {this.id,
        this.code,
        this.fixedDiscount,
        this.percentageDiscount,
        this.maxUsagePerUser,
        this.numberOfUsage,
        this.minTotal,
        this.expireDate,
        this.createdAt,
        this.updatedAt,
        this.traderId});

  Coupon.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    code = json['code'];
    fixedDiscount = json['fixed_discount'];
    percentageDiscount = json['percentage_discount'];
    maxUsagePerUser = json['max_usage_per_user'];
    numberOfUsage = json['number_of_usage'];
    minTotal = json['min_total'];
    expireDate = json['expire_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    traderId = json['trader_id'];
  }

}
