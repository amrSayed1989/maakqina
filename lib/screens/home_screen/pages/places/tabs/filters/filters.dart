import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../models/brand.dart';
import '../../../../../../models/color.dart';
import '../../../../../../utils/consts/app_colors.dart';
import '../../../../../../utils/consts/urls.dart';
import '../../../../../../utils/network/api.dart';
import '../../../../../../utils/widgets/loading_widget.dart';
import '../controllers/products.dart';

showFiltersBottomSheet(
  context,
) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(),
  );
}

class _MyBottomSheet extends StatefulWidget {
  final viewModel = Get.find<TraderProductsControllers>();
  // final onItemSelected;
  _MyBottomSheet({
    Key? key,
    // required this.onItemSelected,
  }) : super(key: key);

  @override
  State<_MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<_MyBottomSheet> {
  var loadingColors = false;
  var loadingSizes = false;
  // var loadingTraders = true;
  var loadingBrands = false;

  final highestPriceCtl = TextEditingController();
  final lowestPriceCtl = TextEditingController();

  bool get isLoading {
    return loadingBrands || loadingColors || loadingSizes;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    highestPriceCtl.text = widget.viewModel.HigherPrice;
    lowestPriceCtl.text = widget.viewModel.LowerPrice;

    //getting all colors
    if (widget.viewModel.colors.isEmpty) {
      loadingColors = true;
      AppApiHandler.getData(
          url: '$apiVersion/colors',
          body: null,
          callback: (json) {
            loadingColors = false;
            if (json['data'] != null) {
              json['data'].forEach((v) {
                widget.viewModel.colors.add(new AppColor.fromJson(v));
              });
            }
            setState(() {});
          });
    }

    // getting all sizes
    if (widget.viewModel.sizes.isEmpty) {
      loadingSizes = true;
      AppApiHandler.getData(
          url: '$apiVersion/sizes',
          body: null,
          callback: (json) {
            loadingSizes = false;
            if (json['data'] != null) {
              json['data'].forEach((v) {
                widget.viewModel.sizes.add(new AppSize.fromJson(v));
              });
            }
            setState(() {});
          });
    }

    // getting all brands
    if (widget.viewModel.brands.isEmpty) {
      loadingBrands = true;
      AppApiHandler.getData(
          url: '$apiVersion/brands',
          body: null,
          callback: (json) {
            loadingBrands = false;
            if (json['data'] != null) {
              json['data'].forEach((v) {
                widget.viewModel.brands.add(new Brand.fromJson(v));
              });
            }
            setState(() {});
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Container(
          width: double.infinity,
          height: 50,
          color: AppColors.mainOrange,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.viewModel.PriceAfterDiscount = '';
                  widget.viewModel.RecentlyAdded = '';
                  widget.viewModel.SortByLowerPrice = '';
                  widget.viewModel.LowerPrice = '';
                  widget.viewModel.HigherPrice = '';
                  highestPriceCtl.text = '';
                  lowestPriceCtl.text = '';
                  for (AppColor c in widget.viewModel.colors) {
                    c.selected = false;
                  }
                  for (AppSize c in widget.viewModel.sizes) {
                    c.selected = false;
                  }
                  for (Brand c in widget.viewModel.brands) {
                    c.selected = false;
                  }
                  for (FilterTrader c in widget.viewModel.traders) {
                    c.selected = false;
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    Text('مسح الكل',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo')),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                'الفلاتر',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
              InkWell(
                onTap: () {
                  // solidController.hide();
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: LoadingWidget(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text('أقل سعر فأكثر',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          Spacer(),
                          Checkbox(
                              value: widget.viewModel.SortByLowerPrice == '1',
                              onChanged: (value) {
                                widget.viewModel.SortByLowerPrice =
                                    value! ? '1' : '';
                                // if(lowestPrice) highestPrice = false;
                                setState(() {});
                              }),
                        ],
                      ), //lowest to highest
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text('أعلى سعر فأقل',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          Spacer(),
                          Checkbox(
                              value: widget.viewModel.SortByLowerPrice == '0',
                              onChanged: (value) {
                                widget.viewModel.SortByLowerPrice =
                                    value! ? '0' : '';
                                setState(() {});
                              }),
                        ],
                      ), // highest to lowest
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      rangePrice(), //between to prices
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text('وصل حديثاً',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          Spacer(),
                          Checkbox(
                              value: widget.viewModel.RecentlyAdded == '1',
                              onChanged: (value) {
                                widget.viewModel.RecentlyAdded =
                                    value! ? '1' : '';
                                setState(() {});
                              }),
                        ],
                      ), // highest to lowest
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text('خصم',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          Spacer(),
                          Checkbox(
                              value: widget.viewModel.PriceAfterDiscount == '1',
                              onChanged: (value) {
                                widget.viewModel.PriceAfterDiscount =
                                    value! ? '1' : '';
                                setState(() {});
                              }),
                        ],
                      ), // highest to lowest
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      ExpansionTile(
                        title: Text('اللون',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                        children: widget.viewModel.colors
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(e.name ?? ''),
                                    Spacer(),
                                    Checkbox(
                                        value: e.selected,
                                        onChanged: (value) {
                                          e.selected = value!;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      ExpansionTile(
                        title: Text('الحجم',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                        children: widget.viewModel.sizes
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(e.name ?? ''),
                                    Spacer(),
                                    Checkbox(
                                        value: e.selected,
                                        onChanged: (value) {
                                          e.selected = value!;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                      ExpansionTile(
                        title: Text('اسم الماركة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                        children: widget.viewModel.brands
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(e.name ?? ''),
                                    Spacer(),
                                    Checkbox(
                                        value: e.selected,
                                        onChanged: (value) {
                                          e.selected = value!;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: 1,
                      ),
                    ],
                  )),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          widget.viewModel.HigherPrice = highestPriceCtl.text;
                          widget.viewModel.LowerPrice = lowestPriceCtl.text;
                          widget.viewModel.reloadData();
                          Get.back();
                        },
                        child: Text(
                          'بحث',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
    );
  }

  Widget rangePrice() {
    return Container(
      // width: double.infinity,
      // height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Text('بين سعرين',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
            Container(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 45,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: lowestPriceCtl,
                    decoration: InputDecoration(
                      hintText: 'اقل سعر',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 45,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: highestPriceCtl,
                    decoration: InputDecoration(
                      hintText: 'اعلى سعر',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
