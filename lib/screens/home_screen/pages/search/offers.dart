// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/offer.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/offer_item_widget.dart';
import 'package:maak/utils/widgets/search_text_field.dart';
import 'package:maak/view_models/search/offers.dart';
import 'package:provider/provider.dart';

class SearchOffersPage extends StatelessWidget {
  SearchOffersPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  final viewModel = Get.find<SearchOffersViewModel>();
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
                                viewModel.isLoading.value = true;
                                ;
                                viewModel.searchOffers(value);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.offers.value.offers.clear();
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
                  child: viewModel.isLoading.value
                      ? Container(
                          child: Center(
                            child: LoadingWidget(),
                          ),
                        )
                      : viewModel.offers.value.offers.isEmpty
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
                                  if (viewModel.offers.value.countPage >
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
                                child: ListView.separated(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      color: Colors.white,
                                      height: 20,
                                    );
                                  },
                                  itemCount:
                                      viewModel.offers.value.offers.length,
                                  itemBuilder: (context, index) {
                                    Offer offer =
                                        viewModel.offers.value.offers[index];
                                    return InkWell(
                                      onTap: () {
                                        print('==============================');
                                      },
                                      child: OfferItemWidget(
                                        price: offer.price,
                                        title: offer.name,
                                        id: offer.id,
                                        image: offer.image,
                                        about: offer.addDate,
                                        address: offer.location,
                                        endDate: offer.endDate,
                                        phoneNumber: offer.phoneNumber,
                                        traderName: offer.traderName,
                                      ),
                                    );
                                  },
                                ),
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
