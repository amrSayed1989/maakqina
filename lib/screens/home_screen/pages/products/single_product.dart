// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/product.dart';
import 'package:maak/models/shopping_cart.dart';
import 'package:maak/models/varients.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/controller/controller.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/app_carosel.dart';
import 'package:maak/utils/widgets/curved_shadow_container.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:provider/provider.dart';

class SingleProductPage extends StatelessWidget {
  final bool comeFromTrader;
  final String? traderName;
  SingleProductPage({Key? key, this.comeFromTrader = false, this.traderName})
      : super(key: key);

  ShoppingCartController shoppingCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductViewModel>(
      builder: (_, viewModel, child) {
        Product product = viewModel.productService.product;

        return Scaffold(
          appBar: CustomAppBar(
            title: viewModel.loading
                ? ''
                : '${viewModel.productService.product.name}',
          ),
          body: viewModel.loading
              ? Center(
                  child: LoadingWidget(),
                )
              : (viewModel.productService.product.variants.length) <= 0
                  ? Center(
                      child: Text(
                      'لا يحتوي المنتج على اي عناصر',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo'),
                    ))
                  : Container(
                      color: AppColors.greyBackground,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  /// big image
                                  viewModel.variant == null
                                      ? Container(
                                          height: 250,
                                          width: double.infinity,
                                          child: imageFromServer(
                                              imageUrl: viewModel.mainImage),
                                        )
                                      : AppCarousel(
                                          images:
                                              viewModel.variant!.first.images,
                                          autoPlay: false,
                                        ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'الالوان :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Cairo'),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: viewModel.colors.keys
                                                  .map<Widget>(
                                                    (item) => InkWell(
                                                      onTap: () {
                                                        viewModel.setVariant(
                                                            viewModel
                                                                .colors[item]!);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 8),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18.0,
                                                                  vertical: 5),
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                                color: viewModel
                                                                            .variant?[
                                                                                0]
                                                                            .colorName ==
                                                                        item
                                                                    ? Colors
                                                                        .white
                                                                    : AppColors
                                                                        .mainOrange,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'Cairo'),
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: viewModel
                                                                        .variant?[
                                                                            0]
                                                                        .colorName ==
                                                                    item
                                                                ? AppColors
                                                                    .mainOrange
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .mainOrange,
                                                                width: 1)),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewModel.variant == null
                                              ? 'اختر لون لعرض الاحجام المتوفره منه'
                                              : 'اختر الحجم :',
                                          style: TextStyle(
                                              color: viewModel.variant == null
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Cairo'),
                                        ),
                                        viewModel.variant != null
                                            ? CurvedShadowedContainer(
                                                // width: double.infinity,
                                                child: Column(
                                                  children: viewModel.variant!
                                                      .map((e) {
                                                    return Row(
                                                      children: [
                                                        Radio<Variant?>(
                                                            activeColor:
                                                                AppColors
                                                                    .mainOrange,
                                                            value: e,
                                                            groupValue: viewModel
                                                                .variantItem,
                                                            onChanged:
                                                                (variantItem) {
                                                              viewModel
                                                                  .setVariantItem(
                                                                      variantItem);
                                                            }),
                                                        Text(
                                                          e.sizeName,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '(${e.count})',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          '${e.price} ج.م ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        )
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0.0,
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'الاسم : ',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .mainOrange,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'Cairo'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        18.0),
                                                            child: Text(
                                                              product.name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      'Cairo'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0.0,
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'التفاصيل :',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .mainOrange,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'Cairo'),
                                                              ),
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  viewModel
                                                                      .setShowDetails();
                                                                },
                                                                child: Icon(
                                                                  viewModel
                                                                          .showDetails
                                                                      ? Icons
                                                                          .keyboard_arrow_down_outlined
                                                                      : Icons
                                                                          .keyboard_arrow_left,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          viewModel.showDetails
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          18.0),
                                                                  child: Text(
                                                                    product
                                                                        .details,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontFamily:
                                                                            'Cairo'),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'كود المنتج : ',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .mainOrange,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Cairo'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 18.0),
                                                        child: Text(
                                                          product.productCode,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'اسم الماركة : ',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .mainOrange,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Cairo'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 18.0),
                                                        child: Text(
                                                          product.brand?.name ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'العنوان : ',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .mainOrange,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Cairo'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 18.0),
                                                        child: Text(
                                                          product.detailedTitle,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          product.isAvailable
                              ? SizedBox(
                                  width: double.infinity,
                                  child: InkWell(
                                      onTap: () {
                                        var item = CartItem(
                                            viewModel.productService.product.id,
                                            viewModel
                                                .productService.product.name,
                                            viewModel.variantItem?.colorName ??
                                                '',
                                            viewModel.variantItem?.sizeName ??
                                                '',
                                            1,
                                            viewModel
                                                .productService.product.price,
                                            viewModel.variantItem?.id ?? 0,
                                            viewModel.productService.product
                                                .productImage);
                                        if (viewModel.variantItem?.colorName ==
                                                null ||
                                            viewModel.variantItem?.sizeName ==
                                                null) {
                                          alertErrorDialog(
                                              'يجب اختيار اللون والمقاس للمنتج');
                                        } else {
                                          if (comeFromTrader) {
                                            //  coming from trader page
                                            if (shoppingCartController
                                                    .traderId ==
                                                null) {
                                              println(
                                                  '---->> shoppingCartController.traderId == null && comeFromTrader product.traderName = ${product.traderId}');
                                              if (shoppingCartController
                                                  .isEmptyCart.value) {
                                                println(
                                                    '--->>> shoppingCartController.isEmptyCart = true product.traderName = ${product.traderId}');
                                                shoppingCartController
                                                        .traderId =
                                                    product.traderId;
                                                shoppingCartController
                                                    .traderName = traderName;
                                                addItemToShoppingCart(item);
                                              } else {
                                                println(
                                                    '--->>> shoppingCartController.isEmptyCart = false product.traderName = ${product.traderId}');
                                                alertWarningDialog(
                                                    'تحتوي السلة علي عناصر ليست لهذا التاجر',
                                                    confirmButton:
                                                        ' إفراغ السلة وإضافة النتج',
                                                    onConfirm: () {
                                                  shoppingCartController
                                                      .clearShoppingCart();
                                                  shoppingCartController
                                                          .traderId =
                                                      product.traderId;
                                                  shoppingCartController
                                                      .traderName = traderName;
                                                  addItemToShoppingCart(item);
                                                });
                                              }
                                            } else if (shoppingCartController
                                                    .traderId ==
                                                product.traderId) {
                                              shoppingCartController.traderId =
                                                  product.traderId;
                                              shoppingCartController
                                                  .traderName = traderName;
                                              addItemToShoppingCart(item);
                                            } else {
                                              println(
                                                  '-------------- products from another trader');
                                              alertWarningDialog(
                                                  'تحتوي السلة علي عناصر للتاجر : ${shoppingCartController.traderName}',
                                                  confirmButton:
                                                      ' إفراغ السلة وإضافة النتج',
                                                  onConfirm: () {
                                                shoppingCartController
                                                    .clearShoppingCart();
                                                shoppingCartController
                                                        .traderId =
                                                    product.traderId;
                                                shoppingCartController
                                                    .traderName = traderName;
                                                addItemToShoppingCart(item);
                                              });
                                            }
                                          } else {
                                            //  coming from general shopping
                                            if (shoppingCartController
                                                    .traderId !=
                                                null) {
                                              println(
                                                  '---->> !comeFromTrader && shoppingCartController.traderId == null');
                                              alertWarningDialog(
                                                  'تحتوي السلة علي عناصر للتاجر : ${shoppingCartController.traderName}',
                                                  confirmButton:
                                                      ' إفراغ السلة وإضافة النتج',
                                                  onConfirm: () {
                                                shoppingCartController
                                                    .clearShoppingCart();
                                                shoppingCartController
                                                    .traderId = null;
                                                shoppingCartController
                                                    .traderName = null;
                                                addItemToShoppingCart(item);
                                              });
                                            } else {
                                              addItemToShoppingCart(item);
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'أضف للسلة',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.add_shopping_cart_rounded,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                        color: AppColors.mainOrange,
                                      )),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
        );
      },
    );
  }

  addItemToShoppingCart(CartItem item) {
    var done = shoppingCartController.addItemToCart(item);
    if (done) {
      Get.snackbar('تنبيه', 'تمت الاضافة الي سلة التسوق',
          backgroundColor: Colors.green,
          snackStyle: SnackStyle.FLOATING,
          colorText: Colors.white,
          messageText: Text(
            'تمت الاضافة الي سلة التسوق',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ));
    } else {
      Get.snackbar('تنبيه', 'العنصر موجود في سلة التسوق',
          backgroundColor: Colors.redAccent,
          snackStyle: SnackStyle.FLOATING,
          colorText: Colors.white,
          messageText: Text(
            'العنصر موجود في سلة التسوق',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ));
    }
  }
}
