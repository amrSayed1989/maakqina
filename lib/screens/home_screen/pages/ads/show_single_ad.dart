// ignore_for_file: unused_import, unnecessary_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/widgets/app_carosel.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/show_single_ad.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/consts/print_utils.dart';

class ShowSingleAdPage extends StatelessWidget {
  ShowSingleAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowSingleAdViewModel>(builder: (_, viewModel, child) {
      return Scaffold(
          appBar: CustomAppBar(
            title: viewModel.singleAd?.name ?? '',
          ),
          body: viewModel.loading
              ? LoadingWidget()
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: AppColors.greyBackground,
                      // height: double.infinity,
                      child: ListView(
                        children: [
                          AppCarousel(
                            images: viewModel.singleAd!.images,
                          ),
                          SizedBox(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Text('التفاصيل :',
                                                  style: TextStyle(
                                                      // decoration: TextDecoration.underline,
                                                      fontSize: 18,
                                                      color:
                                                          AppColors.mainOrange,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Cairo')),
                                            ),
                                            Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  viewModel
                                                      .toggleOpenedDetails();
                                                },
                                                child: Icon(
                                                  viewModel.openedDetails
                                                      ? Icons
                                                          .keyboard_arrow_down
                                                      : Icons.keyboard_arrow_up,
                                                  color: AppColors.mainOrange,
                                                )),
                                            SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                        viewModel.openedDetails
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0),
                                                  child: Text(
                                                      viewModel
                                                          .singleAd!.details,
                                                      style: TextStyle(
                                                          // decoration: TextDecoration.underline,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo')),
                                                ),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Text('السعر :',
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 18,
                                                    color: AppColors.mainOrange,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                                '${viewModel.singleAd!.price} جنيه',
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                            Spacer(),
                                            Text(' المدينة :',
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 18,
                                                    color: AppColors.mainOrange,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                            Text(
                                                ' ${viewModel.singleAd!.cityName}',
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                            SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text('تاريخ إضافة الإعلان :',
                                              style: TextStyle(
                                                  // decoration: TextDecoration.underline,
                                                  fontSize: 18,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 18),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                                viewModel
                                                    .singleAd!.dateOffAdding,
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text('العنوان التفصيلي :',
                                              style: TextStyle(
                                                  // decoration: TextDecoration.underline,
                                                  fontSize: 18,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 18),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                                viewModel.singleAd!.address,
                                                style: TextStyle(
                                                    // decoration: TextDecoration.underline,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Container(
                        width: double.infinity,
                        // height: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'assets/images/whatsapp_ico.png',
                                        height: 35,
                                        color: Colors.white,
                                      ),
                                    )),
                                onTap: () async {
                                  var whatsappNumber =
                                      viewModel.singleAd?.whatsappNumber ?? '';
                                  println(whatsappNumber);
                                  if (whatsappNumber != '') {
                                    launchWhatsApp(
                                        phone: whatsappNumber,
                                        message: 'مرحبا، اريد مساعدتكم!');
                                  }
                                  // launchWhatsApp(phone: snapshot.data[0][6], message: 'مرحبا، اريد مساعدتكم!');
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                    color: AppColors.mainOrange,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    )),
                                onTap: () async {
                                  launch(
                                      "tel://${viewModel.singleAd?.phoneNumber}");
                                  // launch(('tel://${snapshot.data[0][6]}'));
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ));
    });
  }
}
