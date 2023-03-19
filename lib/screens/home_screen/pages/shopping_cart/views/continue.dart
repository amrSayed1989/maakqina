// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/main.dart';
import 'package:maak/models/coupons.dart';
import 'package:maak/screens/home_screen/main_page.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/controller/controller.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import '../../../../../my_app.dart';
import '../../../../../utils/consts/strings.dart';
import '../../../../../utils/widgets/loading_widget.dart';

class FinishOrder extends StatelessWidget {
  FinishOrder({Key? key}) : super(key: key) {
    viewModel.retrieveCoupons();
    viewModel.details = '';
    viewModel.address = '';
    viewModel.phoneNumber = '';
  }
  final ShoppingCartController viewModel = Get.find();
  final couponNameCrtl = TextEditingController();

  final _headerTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Cairo');

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: CustomAppBar(
            title: 'تكملة الطلب',
          ),
          body: viewModel.loading.value
              ? Center(
                  child: LoadingWidget(),
                )
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child:
                                    Text('رقم الهاتف', style: _headerTextStyle),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 45.0,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    viewModel.phoneNumber = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'ادخل رقم الهاتف',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text('العنوان التفصيلي',
                                    style: _headerTextStyle),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 5.0 * 35.0,
                                child: TextField(
                                  maxLines: 4,
                                  onChanged: (value) {
                                    viewModel.address = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'ادخل العنوان التفصيلي',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text('تفاصيل الطلب ',
                                    style: _headerTextStyle),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 5.0 * 35.0,
                                child: TextField(
                                  maxLines: 4,
                                  onChanged: (value) {
                                    viewModel.details = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'اذا كان لديك تفاصيل لطلب اكتب هنا',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              viewModel.traderId != null
                                  ? Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text('كوبون الخصم ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  height: 45.0,
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: TextField(
                                                      controller:
                                                          couponNameCrtl,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'لو كان لديك كوبون خصم ادخله هنا',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Cairo'),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    5.0),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.amber,
                                                            style: BorderStyle
                                                                .solid,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(width: 5),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 45,
                                                  child: InkWell(
                                                    // color: Colors.red,
                                                    onTap: () async {
                                                      Coupon? coupon = viewModel
                                                          .couponsService.value
                                                          .getCouponFor(
                                                              traderId: viewModel
                                                                      .traderId ??
                                                                  -1);

                                                      if (coupon != null) {
                                                        var couponCode =
                                                            replaceFarsiNumber(
                                                                couponNameCrtl
                                                                    .text
                                                                    .trim());
                                                        var expDate = DateTime
                                                            .parse(coupon
                                                                    .expireDate ??
                                                                '');
                                                        println(
                                                            '--------------- coupons ');
                                                        println(
                                                            '--------------- $expDate ');
                                                        println(couponCode);
                                                        if (expDate.isAfter(
                                                            DateTime.now())) {
                                                          var code =
                                                              coupon.code ?? '';
                                                          println(
                                                              '---- code $code');
                                                          if (code.trim() ==
                                                              couponCode
                                                                  .trim()) {
                                                            if (coupon
                                                                    .fixedDiscount ==
                                                                null) {
                                                              // percentage discount
                                                              var percentage =
                                                                  (double.tryParse(
                                                                          coupon.percentageDiscount ??
                                                                              '') ??
                                                                      0.0);
                                                              viewModel.coupon =
                                                                  coupon;
                                                              viewModel
                                                                  .discountValue
                                                                  .value = (viewModel
                                                                      .totalBeforeDiscount *
                                                                  percentage /
                                                                  100); //viewModel.totalBeforeDiscount - (viewModel.totalBeforeDiscount - (viewModel.totalBeforeDiscount *  percentage/ 100));
                                                            } else {
                                                              // fixed discount
                                                              viewModel.coupon =
                                                                  coupon;
                                                              viewModel
                                                                  .discountValue
                                                                  .value = double
                                                                      .tryParse(
                                                                          coupon.fixedDiscount ??
                                                                              '') ??
                                                                  0.0;
                                                            }
                                                          } else {
                                                            alertErrorDialog(
                                                                'الكوبون غير صحيح');
                                                          }
                                                        } else {
                                                          alertErrorDialog(
                                                              'انتهت صلاحية الكوبون');
                                                        }
                                                      } else {
                                                        alertErrorDialog(
                                                            'الكوبون غير صالح للاستخدام');
                                                      }
                                                      return;
                                                      // ignore: dead_code
                                                      if (couponNameCrtl
                                                          .text.isEmpty) {
                                                        alertErrorDialog(
                                                            'يجب ادخال كود الكوبون اولا');
                                                      } else {}

                                                      // if (couponName.text != '') {
                                                      //   // var result = await getCoupon();
                                                      //   if (snapshot.data[1] == null) {
                                                      //     couponResult = [];
                                                      //     Toast.show("الكوبون غير صحيح", context,
                                                      //         duration: Toast.LENGTH_LONG,
                                                      //         gravity: Toast.CENTER);
                                                      //   } else {
                                                      //     couponResult = snapshot.data[1];
                                                      //     if(couponResult[3] == "0"){
                                                      //       Toast.show("الكوبون غير صالح للاستخدام", context,
                                                      //           duration: Toast.LENGTH_LONG,
                                                      //           gravity: Toast.CENTER);
                                                      //     }else {
                                                      //       couponId =
                                                      //           int.parse(couponResult[0]);
                                                      //       couponValue =
                                                      //           double.parse(couponResult[1]);
                                                      //       if (snapshot.data[1][2] == 'f') {
                                                      //         finalTotal =
                                                      //             tot -
                                                      //                 double.parse(snapshot.data[1][1]);
                                                      //       } else if (snapshot.data[1][2] == 'p') {
                                                      //         double left =
                                                      //             100 -
                                                      //                 double.parse(snapshot.data[1][1]);
                                                      //         finalTotal = tot * left / 100;
                                                      //       }
                                                      //     }
                                                      //   }
                                                      // } else {
                                                      //   Toast.show(
                                                      //       "يجب ادخال كود الكوبون اولا", context,
                                                      //       duration: Toast.LENGTH_LONG,
                                                      //       gravity: Toast.CENTER);
                                                      // }
                                                      // setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          'تحقق',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainOrange,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 35),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text('السعر الكلي ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Expanded(child: Container()),
                                  Text('${viewModel.totalBeforeDiscount}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Text(' ج.م',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  // (snapshot.data[1] != null && snapshot.data[1][3] == "0")
                                  //     ?
                                  Text('الخصم ', // ج.م
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Expanded(child: Container()),
                                  Text('${viewModel.discountValue.value}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  // : Text(
                                  // couponResult.isEmpty
                                  //     ? '00.00'
                                  //     : couponResult[2] == 'p'
                                  //     ? ' % ' + couponResult[1] + ' النسبة  '
                                  //     : 'المبلغ   ' + couponResult[1] + ' ج.م ',
                                  // textAlign: TextAlign.end,
                                  // style: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w700,
                                  //     fontFamily: 'Cairo'))
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text('الاجمالي',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Expanded(child: Container()),
                                  Text(
                                      '${viewModel.totalBeforeDiscount - viewModel.discountValue.value}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Text(' ج.م',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  SizedBox(width: 10),
                                ],
                              ),

                              // Expanded(child: Container()),
                              Container(
                                height: 46,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    InkWell(
                      onTap: () async {
                        if (viewModel.phoneNumber.isEmpty ||
                            viewModel.address.isEmpty) {
                          Get.defaultDialog(
                            title: 'تنبيه',
                            middleText:
                                'يرجي إدخال رقم التليفون والعنوان كاملا',
                            cancel: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'إغلاق',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          );
                          return;
                        }

                        Get.defaultDialog(
                            title: 'جاري ارسال الطلب ...',
                            // middleText: '',
                            content: LoadingWidget(),
                            barrierDismissible: false);

                        var result = await viewModel.testPost();
                        Get.back();
                        Get.defaultDialog(
                          title: result['title']!,
                          middleText: result['text']!,
                          cancel: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (result['code'] == '1') {
                                    viewModel.clearShoppingCart();
                                    viewModel.afterFinishShopping = true;
                                    Go.off(context, MainPageScreen());
                                  } else {
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  'إغلاق',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'ارسال الطلب',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(color: AppColors.mainOrange),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
