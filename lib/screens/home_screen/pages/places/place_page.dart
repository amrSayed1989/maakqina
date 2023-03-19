// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/screens/home_screen/pages/places/tabs/offers_tab.dart';
import 'package:maak/screens/home_screen/pages/places/tabs/shop_tab.dart';
import 'package:maak/screens/home_screen/pages/places/tabs/trader_about.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/widgets/app_carosel.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:maak/view_models/places_view_model.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class PlacePage extends StatelessWidget {
  final int initialIndex;
  const PlacePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceViewModel>(builder: (_, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              viewModel.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: LoadingWidget(
                        color: Colors.white,
                      ),
                    )
                  : Text(viewModel.traderService.data?.name ?? ""),
            ],
          ),
          centerTitle: true,
          leading: Container(),
          actions: [
            // Text(viewModel.placeService.data?.name ?? ""),
            InkWell(
              onTap: () {
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
        body: viewModel.isLoading
            ? LoadingWidget()
            : DefaultTabController(
                initialIndex: initialIndex,
                length: 3,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.greyBackground,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        child: Center(
                          child: TabBar(
                            indicatorColor: Colors.white,
                            indicator: BoxDecoration(
                                color: AppColors.mainOrange,
                                borderRadius: BorderRadius.circular(50)),
                            labelColor: Colors.white,
                            indicatorPadding: EdgeInsets.all(5),
                            indicatorWeight: 0,
                            unselectedLabelColor: Colors.white,
                            onTap: (index) async {},
                            tabs: [
                              Tab(
                                text: 'نبذة عن',
                              ),
                              Tab(
                                text: (viewModel.traderService.data?.type ??
                                            '') ==
                                        'service'
                                    ? 'الخدمات'
                                    : 'المتجر',
                              ),
                              Tab(
                                text: 'العروض',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            TraderAboutTab(
                              data: viewModel.traderService.data!,
                            ),
                            ShopTabWidget(
                              viewModel: viewModel,
                            ),
                            OffersTabWidget(
                                traderId: viewModel.traderService.data!.id!)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
