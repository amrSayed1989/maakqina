// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/place.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/place_item_widget.dart';
import 'package:maak/utils/widgets/search_text_field.dart';
import 'package:maak/view_models/search/place.dart';
import 'package:provider/provider.dart';

class SearchPlacesPage extends StatelessWidget {
  SearchPlacesPage({Key? key}) : super(key: key);

  final SearchPlacesViewModel viewModel = Get.find();
  final scrollController = ScrollController();

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
                                // viewModel.isLoading.value = true;;
                                viewModel.searchData(value);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.places.value.places.clear();
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
                Expanded(
                  child: viewModel.isLoading.value
                      ? Container(
                          child: Center(
                            child: LoadingWidget(),
                          ),
                        )
                      : viewModel.places.value.places.isEmpty
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
                                  if (viewModel.places.value.countPage >
                                          viewModel.page &&
                                      scrollController.offset ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                    if (!viewModel.subLoading.value) {
                                      viewModel.subLoading.value = true;

                                      viewModel.loadMore();
                                    }
                                  }
                                  return true;
                                },
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView.builder(
                                    controller: scrollController,
                                    // shrinkWrap: true,

                                    itemCount:
                                        viewModel.places.value.places.length,
                                    itemBuilder: (context, index) {
                                      Place place =
                                          viewModel.places.value.places[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: PlaceItemWidget(
                                          place: place,
                                        ),
                                      );
                                    },
                                  ),
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
