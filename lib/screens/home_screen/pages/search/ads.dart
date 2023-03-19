// ignore_for_file: unused_import, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/news.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/ads_item_widget.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/search_text_field.dart';
import 'package:maak/view_models/search/ads.dart';
import 'package:provider/provider.dart';

// class SearchAdsPage extends StatefulWidget {
//
//    SearchAdsPage({Key? key}) : super(key: key);
//
//   @override
//   State<SearchAdsPage> createState() => _SearchAdsPageState();
// }

class SearchAdsPage extends StatelessWidget {
  final scrollController = ScrollController();

  SearchAdsViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                                viewModel.loading.value = true;
                                ;
                                viewModel.searchForAd(value);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.addedNews.value.data.clear();
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
                Expanded(
                  child: viewModel.loading.value
                      ? Center(
                          child: LoadingWidget(),
                        )
                      : viewModel.addedNews.value.data.isEmpty
                          ? Center(
                              child: Text(
                                'لا توجد نتائج مطابقة للبحث',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(
                              child: NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (viewModel.addedNews.value.countPage >
                                          viewModel.page &&
                                      scrollController.offset ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                    if (!viewModel.subLoading.value) {
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
                                        height: 5,
                                      );
                                  },
                                  itemCount:
                                      viewModel.addedNews.value.data.length,
                                  itemBuilder: (context, index) {
                                    News news =
                                        viewModel.addedNews.value.data[index];
                                    return AdsItemWidget(
                                      news: news,
                                    );
                                  },
                                ),
                              ),
                              // color: Colors.red,
                            ),
                ),
                Container(
                  height: viewModel.subLoading.value ? 50.0 : 0,
                  color: Colors.transparent,
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
