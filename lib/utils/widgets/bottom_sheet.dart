import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showMyBottomSheet(context,{required title,required data,required onItemSelected}){

  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(
      title: title,
      onItemSelected: onItemSelected,
      data: data,
    ),
  );
}

class _MyBottomSheet extends StatelessWidget {

  final title;
  final data;
  final onItemSelected;
   _MyBottomSheet({Key? key,
     required this.title,
     required this.data,
     required this.onItemSelected
   }) : super(key: key);

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
              Expanded(child: Center(child:Text(title,
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
      body: Column(
        children: [

          Expanded(
            child: Container(
              color: Colors.white,
              // height: 30,
              child:data.length != 0 ?
              ListView.separated(
                itemCount: data.length ,
                itemBuilder: (context, index) {
                  if (data.length == 0) {
                    return Container(
                        height: 300,
                        child: Center(
                          child: Text('لا توجد نتائج مطابقة للبحث '),
                        ));
                  }
                  return GestureDetector(
                    onTap: () async {
                      onItemSelected(index);
                      Get.back();


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                      child: Text(data[index] ,
                          // textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,)),
                      decoration: BoxDecoration(
                        // color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.5)
                      ),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => const Divider(),
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
        ],
      ),
    );
  }
}

