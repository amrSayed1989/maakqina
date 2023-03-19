// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/ads/ad_category.dart';
import 'package:maak/models/ads/ad_sub_category.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showMyBottomSheetAddCategories(context,
    {required title,
    required List<AdCategory> categories,
    required onItemSelected,
    bool inFilter = false}) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(
      title: title,
      inFilter: inFilter,
      onItemSelected: onItemSelected,
      categories: categories,
    ),
  );
}

class _MyBottomSheet extends StatelessWidget {
  final title;
  final List<AdCategory> categories;
  final onItemSelected;
  final inFilter;
  _MyBottomSheet(
      {Key? key,
      required this.title,
      required this.categories,
      required this.onItemSelected,
      required this.inFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Container(
          width: double.infinity,
          height: 50,
          color: AppColors.mainOrange,
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                title,
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              // height: 30,
              child: categories.length != 0
                  ? ListView.separated(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        if (categories.length == 0) {
                          return Container(
                              height: 300,
                              child: Center(
                                child: Text('لا توجد نتائج مطابقة للبحث '),
                              ));
                        }
                        if (inFilter) {
                          if ((categories[index].subCategories.length == 0 ||
                                  categories[index].subCategories[0].id !=
                                      -1) &&
                              index != 0)
                            categories[index]
                                .subCategories
                                .insert(0, AdSubCategory(-1, 'الكل'));
                        }
                        return ExpansionTile(
                          title: InkWell(
                            onTap: categories[index].name == 'الكل'
                                ? () {
                                    onItemSelected(null, null);
                                    Get.back();
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              child: Text(categories[index].name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ),
                          trailing: index == 0 ||
                                  categories[index].subCategories.length == 0
                              ? SizedBox()
                              : null,
                          children: categories[index].subCategories.map((e) {
                            return InkWell(
                              onTap: () async {
                                onItemSelected(
                                    categories[index], e.id != -1 ? e : null);
                                Get.back();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 50),
                                child: Text(e.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            );
                          }).toList(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                          width: double.infinity,
                          height: 0.5,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'لا يوجد بيانات',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
