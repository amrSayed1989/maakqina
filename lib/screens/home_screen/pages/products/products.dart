// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/product_service.dart' as modelService;
import 'package:maak/models/product.dart';
import 'package:maak/screens/home_screen/pages/products/services_view.dart';
import 'package:maak/screens/home_screen/pages/products/single_product.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';

import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/product_grid_item.dart';
import 'package:maak/utils/widgets/product_list_item.dart';
import 'package:maak/utils/consts/app_colors.dart';

import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/products_view_model.dart';
import 'package:maak/view_models/search/products.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_services.dart';
import '../../../../utils/consts/print_utils.dart';
import '../../../../view_models/account.dart';
import '../../../account/login_page.dart';
import 'filters_widget.dart';

class ProductsPage extends StatelessWidget {
  final scrollController = ScrollController();

  ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cities = Provider.of<MainAppViewModel>(context, listen: false)
        .cities
        .data!
        .map((e) => e.name!)
        .toList();
    cities.insert(0, "الكل");

    return Consumer<ProductsViewModel>(
      builder: (_, viewModel, child) {
        SearchProductsViewModel searchProductsViewModel =
            Get.put(SearchProductsViewModel(viewModel.city));
        return Column(
          children: [
            Container(
              height: 80,
              color: Colors.black, //Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showMyBottomSheet(context,
                                  title: 'المدن',
                                  data: cities, onItemSelected: (index) async {
                                if (index == 0) {
                                  viewModel.city = null;
                                  searchProductsViewModel.city = null;
                                } else {
                                  viewModel.city =
                                      Provider.of<MainAppViewModel>(context,
                                              listen: false)
                                          .cities
                                          .data![index - 1];
                                  searchProductsViewModel.city = viewModel.city;
                                }
                                viewModel.reloadData();
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                  )),
                              child: Icon(
                                Icons.location_city,
                                // color: Colors.white,
                                color: Color(0xffF15412),
                                size: 25,
                              ),
                            ),
                          ),
                          Text('${viewModel.cityName}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  // Color(0xffF15412)  ,
                                  fontFamily: 'Cairo')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showProductServicesBottomSheet(context,
                                  type: 'main_product_types',
                                  onItemSelected: (ProductService? service) {
                                viewModel.type = 'main_product_types';
                                if (service == null) {
                                  viewModel.service = null;
                                  viewModel.productService = null;
                                  viewModel.commercial = null;
                                } else {
                                  viewModel.commercial = service.name ?? '';
                                  viewModel.service = null;
                                  viewModel.productService = service;
                                }

                                // viewModel.commercial = subService == null ? service?.name ?? '' : subService.name ?? '';

                                // viewModel.main_product_type_id = (service?.id ?? '') ;
                                // viewModel.sub_product_type_id = subService?.id ?? '';
                                // viewModel.main_product_service_type_id = '';
                                // viewModel.sub_product_service_type_id = '';
                                viewModel.reloadData();
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: Icon(
                                Icons.store,
                                color: Color(0xffF15412),
                                size: 25,
                              ),
                            ),
                          ),
                          Text(viewModel.commercialType,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  // Color(0xffF15412)  , //Colors.whit
                                  fontFamily: 'Cairo')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              showProductServicesBottomSheet(context,
                                  type: 'main_product_service_types',
                                  onItemSelected: (ProductService? service) {
                                viewModel.type = 'main_product_service_types';
                                if (service == null) {
                                  viewModel.commercial = null;
                                  viewModel.productService = null;
                                  viewModel.service = null;
                                } else {
                                  viewModel.service = service.name ?? '';
                                  viewModel.productService = service;
                                  viewModel.commercial = null;
                                }

                                // viewModel.main_product_type_id = '';
                                // viewModel.sub_product_type_id = '';
                                // viewModel.main_product_service_type_id = (service?.id ?? '') ;
                                // viewModel.sub_product_service_type_id = subService?.id ?? '';
                                viewModel.reloadData();
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: Icon(
                                Icons.home_repair_service,
                                // color: Colors.white,
                                color: Color(0xffF15412),
                                size: 25,
                              ),
                            ),
                          ),
                          Text(viewModel.serviceType,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  // color: Color(0xffF15412)  , //Colors.whit
                                  fontFamily: 'Cairo')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(color: Colors.white, height: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                viewModel.setGridOrList(true);
                              },
                              child: Container(
                                height: double.infinity,
                                child: Icon(
                                  Icons.grid_view,
                                  color: viewModel.gridSelected
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
                              viewModel.setGridOrList(false);
                            },
                            child: Container(
                              height: double.infinity,
                              child: Icon(
                                Icons.list_outlined,
                                color: !viewModel.gridSelected
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
                        showFiltersBottomSheet(context, viewModel,
                            onItemSelected: () {
                          viewModel.reloadData();
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        decoration: BoxDecoration(
                            color: AppColors.mainOrange,
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            Expanded(
              child: viewModel.isLoading
                  ? Container(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    )
                  : viewModel.products.data.length == 0
                      ? Container(
                          child: Center(
                            child: Text(
                              'لا يوجد تسوق في هذه المدينة',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (viewModel.products.countPage >
                                        viewModel.page &&
                                    scrollController.offset ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  if (!viewModel.subLoading) {
                                    viewModel.subLoading = true;
                                    viewModel.loadMore();
                                  }
                                }
                                return true;
                              },
                              child: RefreshIndicator(
                                color: AppColors.mainOrange,
                                onRefresh: () async {
                                  viewModel.products.data.clear();
                                  // viewModel.notifyListeners();
                                  viewModel.page = 0;
                                  viewModel.isLoading = true;
                                  viewModel.reloadData();
                                },
                                child: GridView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: viewModel.products.data.length,
                                  itemBuilder: (context, index) {
                                    Product product =
                                        viewModel.products.data[index];
                                    return InkWell(
                                      onTap: () {
                                        MainAppViewModel mainApp = Get.find();
                                        if (!mainApp.isLogged) {
                                          Go.to(
                                              context,
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    AccountViewModel(),
                                                child: LoginPage(
                                                  onLoginComplete: () {
                                                    Go.to(
                                                        context,
                                                        ChangeNotifierProvider(
                                                          create: (_) =>
                                                              SingleProductViewModel(
                                                                  modelService
                                                                      .ProductService(
                                                                          product)),
                                                          child:
                                                              SingleProductPage(),
                                                        ));
                                                  },
                                                ),
                                              ));
                                          return;
                                        }
                                        Go.to(
                                            context,
                                            ChangeNotifierProvider(
                                              create: (_) =>
                                                  SingleProductViewModel(
                                                      modelService
                                                          .ProductService(
                                                              product)),
                                              child: SingleProductPage(),
                                            ));
                                      },
                                      child: viewModel.gridSelected
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
                                              viewModel.gridSelected
                                                  ? 0.7
                                                  : 2.6,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          crossAxisCount:
                                              viewModel.gridSelected ? 2 : 1),
                                ),
                              ),
                            ),
                            // color: Colors.red,
                          ),
                        ),
            ),
            Container(
              height: viewModel.subLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        );
      },
    );
  }
}
