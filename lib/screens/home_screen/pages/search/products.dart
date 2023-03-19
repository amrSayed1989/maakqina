// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/product_service.dart';
import 'package:maak/models/product.dart';
import 'package:maak/screens/home_screen/pages/products/single_product.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/product_grid_item.dart';
import 'package:maak/utils/widgets/product_list_item.dart';
import 'package:maak/utils/widgets/search_text_field.dart';
import 'package:maak/view_models/search/products.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:provider/provider.dart';

class SearchProductsPage extends StatelessWidget {
  SearchProductsPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  SearchProductsViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.greyBackground,
        height: double.infinity,
        width: double.infinity,
        child: Obx(() => Column(
              children: [
                Container(
                  width: double.infinity,
                  height: AppBar().preferredSize.height +
                      MediaQuery.of(context).viewPadding.top,
                  decoration: BoxDecoration(color: AppColors.mainOrange),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SearchTextForm(
                              onChangeHandler: (value) {
                                // viewModel.isLoading.value = true;;
                                viewModel.searchData(value);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.products.value.data.clear();
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                                      color: viewModel.gridSelected.value
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
                                    color: !viewModel.gridSelected.value
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
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: viewModel.isLoading.value
                      ? Container(
                          child: Center(
                            child: LoadingWidget(),
                          ),
                        )
                      : viewModel.products.value.data.length == 0
                          ? Container(
                              child: Center(
                                child: Text(
                                  'لا يوجد تسوق في هذه المدينة',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (viewModel.products.value.countPage >
                                            viewModel.page &&
                                        scrollController.offset ==
                                            scrollInfo
                                                .metrics.maxScrollExtent) {
                                      if (!viewModel.subLoading.value) {
                                        viewModel.subLoading.value = true;
                                        viewModel.loadMore();
                                      }
                                    }
                                    return true;
                                  },
                                  child: GridView.builder(
                                    controller: scrollController,
                                    shrinkWrap: true,
                                    itemCount:
                                        viewModel.products.value.data.length,
                                    itemBuilder: (context, index) {
                                      Product product =
                                          viewModel.products.value.data[index];
                                      return InkWell(
                                        onTap: () {
                                          Go.to(
                                              context,
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    SingleProductViewModel(
                                                        ProductService(
                                                            product)),
                                                child: SingleProductPage(),
                                              ));
                                        },
                                        child: viewModel.gridSelected.value
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
                                                viewModel.gridSelected.value
                                                    ? 0.7
                                                    : 2.6,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            crossAxisCount:
                                                viewModel.gridSelected.value
                                                    ? 2
                                                    : 1),
                                  ),
                                ),
                                // color: Colors.red,
                              ),
                            ),
                ),
                Container(
                  height: viewModel.subLoading.value ? 50.0 : 0,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
