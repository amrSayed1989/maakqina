// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/news.dart';
import 'package:maak/utils/widgets/ads_header.dart';
import 'package:maak/utils/widgets/ads_item_widget.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/utils/widgets/bottom_sheet_add_categories.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/add_new_ad.dart';
import 'package:maak/view_models/ads_by_users.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/search/ads.dart';
import 'package:provider/provider.dart';

import '../../../../utils/consts/navigation.dart';
import '../../../../view_models/account.dart';
import '../../../../view_models/show_single_ad.dart';
import '../../../account/login_page.dart';
import 'add_new_ad.dart';

class AdsByUsersPage extends StatelessWidget {
  AdsByUsersPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var cities = Provider.of<MainAppViewModel>(context, listen: false)
        .cities
        .data!
        .map((e) => e.name!)
        .toList();
    cities.insert(0, "الكل");
    return Consumer<AdsByUsersViewModel>(builder: (_, viewModel, child) {
      SearchAdsViewModel searchAdsViewModel = Get.find();
      searchAdsViewModel.city = viewModel.city;
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xffF15412),
          onPressed: () {
            MainAppViewModel mainApp = Get.find();
            if (!mainApp.isLogged) {
              Go.to(
                  context,
                  ChangeNotifierProvider(
                    create: (_) => AccountViewModel(),
                    child: LoginPage(
                      onLoginComplete: () {
                        Get.to(() => ChangeNotifierProvider(
                              create: (_) => AddNewAdViewModel(),
                              child: AddNewAdPage(),
                            ));
                      },
                    ),
                  ));
              return;
            }
            Get.to(() => ChangeNotifierProvider(
                  create: (_) => AddNewAdViewModel(),
                  child: AddNewAdPage(),
                ));
          },
          label: Row(
            children: [
              Text('اضف إعلانك',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: 'Cairo')),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            AdsHeaderWidget(
              city: viewModel.city,
              selectedCategory: viewModel.selectedCategory,
              onCategoryChanged: () {
                showMyBottomSheetAddCategories(context,
                    inFilter: true, title: 'تصنيف الاعلانات',
                    onItemSelected: (selectedCategory) {
                  // viewModel.selectedAdSubCategory = selectedAdSubCategory;
                  viewModel.selectedCategory = selectedCategory;
                  viewModel.reloadData();
                });
              },
              onChangeCity: () {
                showMyBottomSheet(context, title: 'المدن', data: cities,
                    onItemSelected: (index) async {
                  if (index == 0) {
                    viewModel.city = null;
                  } else {
                    viewModel.city =
                        Provider.of<MainAppViewModel>(context, listen: false)
                            .cities
                            .data![index - 1];
                  }
                  viewModel.reloadData();
                });
              },
            ),
            Container(color: Colors.white, height: 2),
            Expanded(
              child: viewModel.loading
                  ? Center(
                      child: LoadingWidget(),
                    )
                  : viewModel.addedNews.data.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد إعلانات في هذه المدينة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          child: RefreshIndicator(
                            color: Colors.blue,
                            onRefresh: () async {
                              viewModel.reloadData();
                            },
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (viewModel.addedNews.countPage >
                                        viewModel.page &&
                                    scrollController.offset ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  if (!viewModel.subLoading) {
                                    viewModel.loadMore();
                                  }
                                }
                                return true;
                              },
                              child: ListView.separated(
                                controller: scrollController,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  if (index % 6 == 0 && index != 0) {
                                    return viewModel.ads.data.length > 0
                                        ? Container(
                                            width: double.infinity,
                                            height: size.width / 2,
                                            color: Colors.white,
                                            child: imageFromServer(
                                                fit: BoxFit.contain,
                                                imageUrl: viewModel
                                                    .ads
                                                    .data[((index ~/ 6) - 1) %
                                                        viewModel
                                                            .ads.data.length]
                                                    .imageUrl),
                                          )
                                        : SizedBox();
                                  } else
                                    return SizedBox(
                                      height: 0,
                                    );
                                },
                                itemCount: viewModel.addedNews.data.length,
                                itemBuilder: (context, index) {
                                  News news = viewModel.addedNews.data[index];
                                  return AdsItemWidget(
                                    news: news,
                                  );
                                },
                              ),
                            ),
                          ),
                          // color: Colors.red,
                        ),
            ),
            Container(
              height: viewModel.subLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: LoadingWidget(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
