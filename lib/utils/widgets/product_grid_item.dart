import 'package:flutter/material.dart';
import 'package:maak/models/product.dart';
import 'package:maak/screens/home_screen/pages/products/products.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/consts/share.dart';
import 'package:maak/view_models/products_view_model.dart';

import 'image_from_server.dart';

//

import 'package:get/get.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:provider/provider.dart';
import '../../screens/account/login_page.dart';
import '../../view_models/account.dart';
import '../../view_models/init_app_viewmodel.dart';
import '../consts/navigation.dart';
import '../consts/share.dart';

class ProductGridItemWidget extends StatelessWidget {
  final Product product;
  const ProductGridItemWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Container(
      // margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: imageFromServer(
                      imageUrl: product.productImage, fit: BoxFit.cover))),
          // Divider(),
          // SizedBox(height: 5,),
          Container(
            width: double.infinity,

            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5.0, left: 5, right: 5, bottom: 0),
              child: Text(
                product.name,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.mainOrange,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'),
              ),
            ),
            // color: AppColors.mainOrange,
          ),
          Visibility(
              visible: product.showTraderName,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                    child: Text(
                  product.traderName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                )),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.priceAfterDiscount} ج.م',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                ),
                Visibility(
                  visible: double.tryParse('${product.price}') !=
                      double.tryParse('${product.priceAfterDiscount}'),
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      MainAppViewModel mainApp = Get.find();
                      if (!mainApp.isLogged) {
                        Go.to(
                            context,
                            ChangeNotifierProvider(
                              create: (_) => AccountViewModel(),
                              child: LoginPage(
                                onLoginComplete: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    ProductsViewModel(),
                                                child: ProductsPage(),
                                              )));
                                },
                              ),
                            ));
                        return;
                      }
                      shareProductWith(
                          title: product.name,
                          about: product.details,
                          traderName: product.traderName,
                          price: product.price,
                          address: product.detailedTitle,
                          brand: product.brand?.name ?? '',
                          priceAfter: '${product.priceAfterDiscount}ج.م');
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
                      MainAppViewModel mainApp = Get.find();
                      if (!mainApp.isLogged) {
                        Go.to(
                            context,
                            ChangeNotifierProvider(
                              create: (_) => AccountViewModel(),
                              child: LoginPage(
                                onLoginComplete: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    ProductsViewModel(),
                                                child: ProductsPage(),
                                              )));
                                },
                              ),
                            ));
                        return;
                      }
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
                  bottomRight: Radius.circular(8),
                )),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.5), width: 0.5)),
      // color: Colors.red,
    );
  }
}
