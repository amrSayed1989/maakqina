import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/offer.dart';
import 'package:maak/models/services.dart';
import 'package:maak/screens/home_screen/pages/places/services_view.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';

import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/offer_item_widget.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';

import 'package:maak/view_models/offers_view_model.dart';
import 'package:maak/view_models/search/offers.dart';
import 'package:provider/provider.dart';

import '../../../../utils/consts/app_colors.dart';
import '../../../../utils/widgets/image_from_server.dart';

class OffersPage extends StatelessWidget {
  final scrollController = ScrollController();

  OffersPage({Key? key}) : super(key: key);

  Future refreshFun() async {
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var cities = Provider.of<MainAppViewModel>(context, listen: false)
        .cities
        .data!
        .map((e) => e.name!)
        .toList();
    cities.insert(0, "الكل");

    return Consumer<OffersViewModel>(
      builder: (_, viewModel, child) {
        var searchViewmodel = Get.put(SearchOffersViewModel(viewModel.city));
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
                                  searchViewmodel.city = null;
                                } else {
                                  viewModel.city =
                                      Provider.of<MainAppViewModel>(context,
                                              listen: false)
                                          .cities
                                          .data![index - 1];
                                  searchViewmodel.city = viewModel.city;
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
                              showServicesBottomSheet(context,
                                  type: 'commercial',
                                  onItemSelected: (Service? services) {
                                if (services == null) {
                                  viewModel.services = null;
                                  viewModel.service = null;
                                  viewModel.commercial = null;
                                } else {
                                  viewModel.commercial = services.id == -2
                                      ? 'العروض التجارية'
                                      : (services.name ?? '');
                                  viewModel.service = null;
                                  viewModel.services = services;
                                }
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
                              // snapshot.data[2] == null
                              //     ? ' تجاري' : snapshot.data[2][4] == 'commercial'
                              //         ? snapshot.data[2][3] : ' تجاري',
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
                              showServicesBottomSheet(context, type: 'service',
                                  onItemSelected: (Service? services) {
                                if (services == null) {
                                  viewModel.services = null;
                                  viewModel.service = null;
                                  viewModel.commercial = null;
                                } else {
                                  viewModel.service = services.id == -2
                                      ? 'العروض الخدمية'
                                      : (services.name ?? '');
                                  viewModel.commercial = null;
                                  viewModel.services = services;
                                }
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
            Expanded(
              child: viewModel.isLoading
                  ? Container(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    )
                  : viewModel.offers.offers.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد عروض في هذه المدينة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          child: RefreshIndicator(
                            color: AppColors.mainOrange,
                            onRefresh: refreshFun,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (viewModel.offers.countPage >
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
                                      height: 3,
                                    );
                                },
                                itemCount: viewModel.offers.offers.length,
                                itemBuilder: (context, index) {
                                  Offer offer = viewModel.offers.offers[index];

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
