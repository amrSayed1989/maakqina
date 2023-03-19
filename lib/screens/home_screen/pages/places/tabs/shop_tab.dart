// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:maak/model_services/product_service.dart';
import 'package:maak/models/product.dart';
import 'package:maak/screens/home_screen/pages/places/tabs/controllers/products.dart';
import 'package:maak/screens/home_screen/pages/places/tabs/filters/filters.dart';
import 'package:maak/screens/home_screen/pages/products/single_product.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/product_grid_item.dart';
import 'package:maak/utils/widgets/product_list_item.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:provider/provider.dart';

import '../../../../../model_services/trader_service.dart';
import 'filters/categories.dart';

class ShopTabWidget extends StatefulWidget {
  // final List<Product> data;
  final PlaceViewModel viewModel;

  ShopTabWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key) {}

  @override
  State<ShopTabWidget> createState() => _ShopTabWidgetState();
}

class _ShopTabWidgetState extends State<ShopTabWidget> {
  final scrollController = ScrollController();

  final traderProductsController = Get.put(TraderProductsControllers());

  final searchContoller = TextEditingController();
  var showSearchBox = false;

  getProducts() {
    traderProductsController.retrieveOffer();
    traderProductsController.mainCategories =
        widget.viewModel.traderService.data!.mainCategories;

    List<SubCategories> subCategories =
        widget.viewModel.traderService.data!.subCategories;
    traderProductsController.mainCategories
        .insert(0, MainCategories(id: -1, name: 'الكل'));
    for (int i = 0; i < subCategories.length; i++) {
      for (MainCategories main in traderProductsController.mainCategories) {
        if (main.id == subCategories[i].mainProductTypeId) {
          main.subCategories.add(subCategories[i]);
          break;
        } else if (main.id == subCategories[i].mainProductServiceTypeId) {
          main.subCategories.add(subCategories[i]);
          break;
        }
      }
    }
    for (MainCategories main in traderProductsController.mainCategories) {
      main.subCategories.insert(0, SubCategories(id: -1, name: 'الكل'));
    }
  }

  @override
  void initState() {
    super.initState();
    traderProductsController.traderId = widget.viewModel.traderService.data?.id;
    traderProductsController.traderType =
        widget.viewModel.traderService.data?.type;

    if (traderProductsController.firstTimeLoaded) {
      getProducts();
      traderProductsController.firstTimeLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(() => AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
                // reverseDuration: Duration(milliseconds: 1000),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: Offset(showSearchBox ? 1.0 : -1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  );
                },
                child: showSearchBox
                    ? Padding(
                        key: UniqueKey(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          color: Colors.white,
                          height: 45,
                          child: TextFormField(
                            controller: searchContoller,
                            decoration: InputDecoration(
                              hintText: 'ابحث عن منتج في المتجر',
                              // prefix: Icon(Icons.search,color: Colors.blue,),
                              prefixIcon: InkWell(
                                onTap: () {
                                  traderProductsController.searchName =
                                      searchContoller.text;
                                  traderProductsController.reloadData();
                                  showSearchBox = false;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    if (searchContoller.text.isNotEmpty) {
                                      searchContoller.text = '';
                                    } else {
                                      showSearchBox = false;
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(Icons.clear)),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        key: UniqueKey(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          widget.viewModel.setGridOrList(true);
                                        },
                                        child: Container(
                                          height: double.infinity,
                                          child: Icon(
                                            Icons.grid_view,
                                            color: widget.viewModel.gridSelected
                                                ? AppColors.mainOrange
                                                : AppColors.unSelectedGray,
                                            size: 25,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        widget.viewModel.setGridOrList(false);
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        child: Icon(
                                          Icons.list_outlined,
                                          color: !widget.viewModel.gridSelected
                                              ? AppColors.mainOrange
                                              : AppColors.unSelectedGray,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  showSearchBox = true;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 0),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  showProductServicesBottomSheet(
                                    context,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 0),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  child: Center(
                                    child: Text(
                                      traderProductsController.catName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 0),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  child: InkWell(
                                    onTap: () {
                                      showFiltersBottomSheet(
                                        context,
                                      );
                                    },
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.filter_alt,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '  الفلاتر',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
              )),
          Obx(() => Expanded(
                child: traderProductsController.loading.value
                    ? Center(
                        child: LoadingWidget(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: traderProductsController.data.length == 0
                            ? Center(
                                child: Text(
                                  'لا توجد منتجات',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (traderProductsController
                                              .traderProducts.value.countPage! >
                                          traderProductsController.page &&
                                      scrollController.offset ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                    if (!traderProductsController
                                        .subLoading.value) {
                                      traderProductsController
                                          .subLoading.value = true;
                                      traderProductsController.loadMore();
                                    }
                                  }
                                  return true;
                                },
                                child: GridView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount:
                                      traderProductsController.data.length,
                                  itemBuilder: (context, index) {
                                    Product product =
                                        traderProductsController.data[index];
                                    return InkWell(
                                      onTap: () {
                                        Go.to(
                                            context,
                                            ChangeNotifierProvider(
                                              create: (_) =>
                                                  SingleProductViewModel(
                                                ProductService(product),
                                              ),
                                              child: SingleProductPage(
                                                comeFromTrader: true,
                                                traderName: widget.viewModel
                                                    .traderService.data?.name,
                                              ),
                                            ));
                                      },
                                      child: widget.viewModel.gridSelected
                                          ? ProductGridItemWidget(
                                              product: product,
                                            )
                                          : ProductListItemWidget(
                                              product: product),
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio:
                                              widget.viewModel.gridSelected
                                                  ? 0.7
                                                  : 2.6,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          crossAxisCount:
                                              widget.viewModel.gridSelected
                                                  ? 2
                                                  : 1),
                                ),
                                // color: Colors.red,
                              ),
                      ),
              )),
          Obx(() => Container(
                height: traderProductsController.subLoading.value ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              )),
        ],
      ),
    );
  }
}
