// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../utils/consts/app_colors.dart';
import '../../../../../../utils/consts/print_utils.dart';
import '../../../../../../utils/widgets/loading_widget.dart';
import '../controllers/products.dart';

showProductServicesBottomSheet(
  context,
) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(),
  );
}

class _MyBottomSheet extends StatefulWidget {
  _MyBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<_MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<_MyBottomSheet> {
  bool _isLoading = false;
  final traderProductsController = Get.find<TraderProductsControllers>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
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
                'التصنيفات الرئيسية',
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
            child: _isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : Container(
                    color: Colors.white,
                    // height: 30,
                    child: traderProductsController.mainCategories.length != 0
                        ? ListView.separated(
                            itemCount:
                                traderProductsController.mainCategories.length,
                            itemBuilder: (context, index) {
                              if (traderProductsController
                                      .mainCategories.length ==
                                  0) {
                                return Container(
                                    height: 300,
                                    child: Center(
                                      child:
                                          Text('لا توجد نتائج مطابقة للبحث '),
                                    ));
                              }
                              // if(inFilter){
                              //   if((categories[index].subCategories.length == 0 || categories[index].subCategories[0].id != -1) && index != 0)
                              //     categories[index].subCategories.insert(0, AdSubCategory( -1, 'الكل'));
                              // }
                              return ExpansionTile(
                                title: InkWell(
                                  onTap: index == 0
                                      ? () {
                                          traderProductsController.catName =
                                              traderProductsController
                                                  .mainCategories[index].name!;

                                          traderProductsController
                                              .main_product_service_type_id = '';
                                          traderProductsController
                                              .sub_product_service_type_id = '';

                                          traderProductsController
                                              .sub_product_type_id = '';
                                          traderProductsController
                                              .main_product_type_id = '';

                                          traderProductsController.reloadData();
                                          Get.back();
                                        }
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 16),
                                    child: Text(
                                        traderProductsController
                                                .mainCategories[index].name ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                ),
                                trailing: index == 0 ? SizedBox() : null,
                                children: traderProductsController
                                    .mainCategories[index].subCategories
                                    .map((e) {
                                  return InkWell(
                                    onTap: () async {
                                      println(
                                          traderProductsController.traderType);
                                      if (traderProductsController.traderType ==
                                          'commercial') {
                                        traderProductsController
                                                .sub_product_type_id =
                                            e.id != -1 ? '${e.id}' : '';
                                        traderProductsController
                                                .main_product_type_id =
                                            '${traderProductsController.mainCategories[index].id}';
                                      } else {
                                        traderProductsController
                                                .main_product_service_type_id =
                                            e.id != -1 ? '${e.id}' : '';
                                        traderProductsController
                                                .sub_product_service_type_id =
                                            '${traderProductsController.mainCategories[index].id}';
                                      }
                                      traderProductsController.catName = e.id !=
                                              -1
                                          ? '${e.name}'
                                          : '${traderProductsController.mainCategories[index].name}';
                                      traderProductsController
                                          .reloadData(); // onItemSelected(categories[index],e.id != -1 ? e : null);
                                      Get.back();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 50),
                                      child: Text(e.name ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(),
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
