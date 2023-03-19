import 'package:flutter/material.dart';
import 'package:maak/models/product.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import '../consts/share.dart';
import 'image_from_server.dart';

class ProductListItemWidget extends StatelessWidget {
  final Product product;
  //final MainAppViewModel mainApp = Get.find();
  const ProductListItemWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: imageFromServer(
                          imageUrl: product.productImage, fit: BoxFit.cover)))),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          // padding: const EdgeInsets.only(top: 5.0,left: 5,right: 5,bottom: 0),
                          child: Text(
                            product.name,
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.mainOrange,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        Visibility(
                            visible: product.showTraderName,
                            child: Container(
                                child: Text(
                              product.traderName,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cairo'),
                            ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${product.priceAfterDiscount}ج.م',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo'),
                              ),
                              Visibility(
                                visible: double.tryParse('${product.price}') !=
                                    double.tryParse(
                                        '${product.priceAfterDiscount}'),
                                child: Text(
                                  '${product.price} ج.م',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Cairo'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              shareProductWith(
                                  title: product.name,
                                  about: product.details,
                                  traderName: product.traderName,
                                  price: product.price,
                                  address: product.detailedTitle,
                                  brand: product.brand?.name ?? '',
                                  priceAfter:
                                      '${product.priceAfterDiscount}ج.م');
                              // Share.share(' name : ${snapshot[index].name} \n '
                              //     'details : ${snapshot[index].details} \n '
                              //     'price : ${snapshot[index].price} \n '
                              //     'price After Discount : ${snapshot[index].priceAfterDiscount} \n '
                              //     'address : ${snapshot[index].detailedTitle}  \n'
                              //     ' brand : ${snapshot[index].brand} \n\n\n'
                              //     'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
                              //     'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');
                              //
                            },
                            child: ClipOval(
                              child: Container(
                                width: 30,
                                height: 30,
                                color: Colors.grey.shade200,
                                child: Icon(
                                  Icons.share,
                                  // color: Colors.grey,
                                  color: Color(0xffF15412), //Colors.whit

                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              launchWhatsApp(
                                  phone: product.traderWhats,
                                  message: 'مرحبا، اريد مساعدتكم!');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: ClipOval(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.phone,
                                    // color: Colors.grey,
                                    color: Color(0xffF15412), //Colors.whit

                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                              visible: product.isAvailable,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: ClipOval(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: Color(0xffF15412), //Colors.whit
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainOrange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          // bottomRight: Radius.circular(8),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.5), width: 0.5)),
    );
  }
}
