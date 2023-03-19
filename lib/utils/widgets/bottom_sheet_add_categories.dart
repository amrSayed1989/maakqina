import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/ads/ad_category.dart';
import 'package:maak/models/ads/ad_sub_category.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../models/ads/ad_service.dart';


showMyBottomSheetAddCategories(context,{required title,required onItemSelected,bool inFilter = false}){

  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(
      title: title,
      inFilter: inFilter,
      onItemSelected: onItemSelected,
    ),
  );
}

class _MyBottomSheet extends StatefulWidget {

  final title;
  // final List<AdCategory> categories;
  final onItemSelected;
  final inFilter;

  _MyBottomSheet({Key? key,
    required this.title,
    // required this.categories,
    required this.onItemSelected,
    required this.inFilter
  }) : super(key: key);

  @override
  State<_MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<_MyBottomSheet> {
  AdCategory? adCategory;
  AdCategoriesService adCategoriesService = AdCategoriesService();
  bool loading = true;
  @override
  initState(){
    super.initState();
    retrieveCategories();
  }
  retrieveCategories() {
    adCategoriesService.getAdsCategories(onDone: () {
      this.adCategoriesService.categories.insert(0, AdCategory(id: -1, name: 'الكل'));
      setState(() {
        loading = false;
      });
      // loadingCats = false;
      // notifyListeners();
    });
  }
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
              Expanded(child: Center(child:Text(widget.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),))),
              InkWell(
                onTap: (){
                  // solidController.hide();
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close,color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      ),
      body:loading ? Center(child: LoadingWidget(),) : Column(
        children: [

          Expanded(
            child: Container(
              color: Colors.white,
              // height: 30,
              child:adCategoriesService.categories.length != 0 ?
              ListView.separated(
                itemCount: adCategoriesService.categories.length ,
                itemBuilder: (context, index) {
                  if (adCategoriesService.categories.length == 0) {
                    return Container(
                        height: 300,
                        child: Center(
                          child: Text('لا توجد نتائج مطابقة للبحث '),
                        ));
                  }
                  if(widget.inFilter){
                    if((adCategoriesService.categories[index].subCategories.length == 0 || adCategoriesService.categories[index].subCategories[0].id != -1) && index != 0)
                      adCategoriesService.categories[index].subCategories.insert(0, AdSubCategory( -1, 'الكل'));
                  }
                  return ExpansionTile(
                    title:InkWell(
                      onTap:adCategoriesService.categories[index].name == 'الكل' ? (){
                        widget.onItemSelected(null);
                        Get.back();
                      } : null,
                      child: Container(

                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                        child: Text(adCategoriesService.categories[index].name ,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,)),),
                    ),

                    trailing:index == 0 || adCategoriesService.categories[index].subCategories.length == 0 ? SizedBox() : null,
                    children: adCategoriesService.categories[index].subCategories.map((e) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 50),
                        child: Row(
                          children: [
                            Text(e.name ,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,)),
                            Spacer(),
                            Checkbox(value: e.selected, onChanged: (value){
                              e.selected = value!;
                              adCategory = adCategoriesService.categories[index];

                              if(e.id == -1 && e.selected){
                                for(var sub in adCategoriesService.categories[index].subCategories){
                                  sub.selected = true;
                                }
                              }else {
                                for(var sub in adCategoriesService.categories[index].subCategories){
                                  if(sub.id == -1){
                                    sub.selected = false;
                                  }
                                }
                              }

                              for(var main in adCategoriesService.categories){

                                if(main.id != adCategoriesService.categories[index].id){
                                  println(main.name);

                                  for(var sub in main.subCategories){
                                    sub.selected = false;
                                  }
                                }
                              }

                              setState(() {

                              });
                            }),
                          ],
                        ),);
                    }).toList(),
                  );
                }, separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(color: Colors.grey.withOpacity(0.5),width: double.infinity,height: 0.5,),
              ),
              )
                  : Center(
                child: Text(
                  'لا يوجد بيانات',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                // widget.viewModel.HigherPrice = highestPriceCtl.text;
                // widget.viewModel.LowerPrice = lowestPriceCtl.text;

                // println(service?.name);
                //
                // for(var sub in service!.subCategories){
                //   if(sub.selected){
                //     println(sub.name);
                //   }
                // }

                widget.onItemSelected(adCategory);
                Get.back();
              }, child: Text('بحث',style: TextStyle(
                  color: Colors.white
              ),)),
            ),
          )
        ],
      ),
    );
  }
}


