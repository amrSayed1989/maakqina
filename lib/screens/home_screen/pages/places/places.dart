import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/place.dart';
import 'package:maak/models/services.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/screens/home_screen/pages/places/place_page.dart';
import 'package:maak/screens/home_screen/pages/places/services_view.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/place_item_widget.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/places_view_model.dart';
import 'package:maak/view_models/search/place.dart';
import 'package:provider/provider.dart';

import '../../../../utils/consts/app_colors.dart';

class PlacesPage extends StatelessWidget {
  PlacesPage({Key? key}) : super(key: key);
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

    return Consumer<PlacesViewModel>(
      builder: (_, viewModel, child) {
        SearchPlacesViewModel searchPlacesViewModel =
            Get.put(SearchPlacesViewModel());
        searchPlacesViewModel.city = viewModel.city;
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
                              MainAppViewModel mainApp = Get.find();
                              if (!mainApp.isLogged) {
                                Go.to(
                                    context,
                                    ChangeNotifierProvider(
                                      create: (_) => AccountViewModel(),
                                      child: LoginPage(
                                        onLoginComplete: () {
                                          Get.to(() => ChangeNotifierProvider(
                                                create: (_) =>
                                                    PlacesViewModel(),
                                                child: PlacePage(),
                                              ));
                                        },
                                      ),
                                    ));
                                return;
                              }
                              Get.to(() => ChangeNotifierProvider(
                                    create: (_) => PlacesViewModel(),
                                    child: PlacePage(),
                                  ));
                              showMyBottomSheet(context,
                                  title: 'المدن',
                                  data: cities, onItemSelected: (index) async {
                                println("==----==>>>>> المدن index $index");
                                if (index == 0) {
                                  viewModel.city = null;
                                  searchPlacesViewModel.city = null;
                                } else {
                                  viewModel.city =
                                      Provider.of<MainAppViewModel>(context,
                                              listen: false)
                                          .cities
                                          .data![index - 1];
                                  searchPlacesViewModel.city = viewModel.city;
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                                  viewModel.commercial = services.name ?? '';
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
                              maxLines: 1,
                              // overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  // overflow: TextOverflow.fade,
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
                                  viewModel.service = services.name ?? '';
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
                              maxLines: 1,
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
                  : viewModel.placesService.places.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد اماكن في هذه المدينة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          child: RefreshIndicator(
                            color: AppColors.mainOrange,
                            onRefresh: () async {
                              viewModel.reloadData();
                            },
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (viewModel.placesService.countPage >
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
                                itemCount:
                                    viewModel.placesService.places.length,
                                itemBuilder: (context, index) {
                                  Place place =
                                      viewModel.placesService.places[index];
                                  return PlaceItemWidget(
                                    place: place,
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
        );
      },
    );
  }
}
