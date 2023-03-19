// ignore_for_file: unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maak/utils/widgets/curved_shadow_container.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/view_models/offer_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/widgets/app_carosel.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferDetailsViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: viewModel.offerController.offerName != ''
                ? viewModel.offerController.offerName
                : viewModel.isLoading
                    ? ''
                    : viewModel.offerController.offerDetail.offerName,
          ),
          // backgroundColor: Colors.black.withOpacity(0.1),
          body: viewModel.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Container(
                  color: AppColors.greyBackground,
                  child: Column(
                    children: [
                      // SizedBox(height: AppBar().preferredSize.height,),
                      Container(
                        // height: 190,

                        child: Stack(
                          children: [
                            AppCarousel(
                              images:
                                  viewModel.offerController.offerDetail.images,
                              autoPlay: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: CurvedShadowedContainer(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    viewModel
                                                        .setExpandingDetails();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 0),
                                                    // color: Colors.black.withOpacity(0.1),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'التفاصيل: ',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .mainOrange,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Cairo'),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          viewModel
                                                                  .expandingDetails
                                                              ? Icons
                                                                  .keyboard_arrow_down_outlined
                                                              : Icons
                                                                  .keyboard_arrow_left,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: viewModel
                                                          .expandingDetails
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 18.0),
                                                          child: Text(
                                                            viewModel
                                                                .offerController
                                                                .offerDetail
                                                                .description,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'Cairo'),
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        viewModel.offerController.offerDetail
                                                .isTraderOffer
                                            ? Divider()
                                            : SizedBox(),
                                        viewModel.offerController.offerDetail
                                                .isTraderOffer
                                            ? CurvedShadowedContainer(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'اسم التاجر: ',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainOrange,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 18.0),
                                                      child: Text(
                                                        viewModel
                                                            .offerController
                                                            .offerDetail
                                                            .traderName,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Cairo'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),
                                        Divider(),
                                        CurvedShadowedContainer(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'العنوان: ',
                                                style: TextStyle(
                                                    color: AppColors.mainOrange,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18.0),
                                                child: Text(
                                                  viewModel.offerController
                                                      .offerDetail.address,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        CurvedShadowedContainer(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'السعر: ',
                                                style: TextStyle(
                                                    color: AppColors.mainOrange,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18.0),
                                                child: Text(
                                                  viewModel.offerController
                                                          .offerDetail.price +
                                                      " " +
                                                      "ج.م",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        CurvedShadowedContainer(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'العرض مضاف في: ',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainOrange,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    Text(
                                                      viewModel
                                                          .offerController
                                                          .offerDetail
                                                          .offerDate,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'العرض ساري حتى: ',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainOrange,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    Text(
                                                      viewModel.offerController
                                                          .offerDetail.endDate,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
