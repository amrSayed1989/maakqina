import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/utils/consts/app_colors.dart';

Future<void> showMyDialog(context,{
  required String title,
  required String message,
  required List<Widget> actions
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(message ),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}

alertErrorDialog(String errorMsg,{closeOverlays = false}){
  Get.defaultDialog(
      title: 'تنبيه',
      middleText: errorMsg,
      cancel: InkWell(
        onTap: (){

          Get.back(closeOverlays: closeOverlays);
        },
        child: Container(
          width: double.infinity,
          child: Center(child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('إغلاق',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          )),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

  );
}

alertWarningDialog(String errorMsg,{required String confirmButton,required Function onConfirm }){
  Get.defaultDialog(
    title: 'تنبيه',
    middleText: errorMsg,
    contentPadding: EdgeInsets.all(0),

    cancel: SizedBox(
      // width: double.infinity,
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.back();
              onConfirm();

            },
            child: Container(
              // width: double.infinity,
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 45),
                child: Text(confirmButton,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              )),
              decoration: BoxDecoration(
                color: AppColors.mainOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(width: 6,height: 6,),
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              // width: double.infinity,
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 45),
                child: Text('إغلاق',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              )),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

  );
}

alertWith2OptionsDialog({required String title,required String middleText,required String confirmButton,required Function onConfirm }){
  Get.defaultDialog(
    title: title,
    middleText: middleText,
    contentPadding: EdgeInsets.all(0),

    cancel: SizedBox(
      // width: double.infinity,
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.back();
              onConfirm();

            },
            child: Container(
              // width: double.infinity,
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 45),
                child: Text(confirmButton,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              )),
              decoration: BoxDecoration(
                color: AppColors.mainOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(width: 6,height: 6,),
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              // width: double.infinity,
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 45),
                child: Text('إغلاق',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              )),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

  );
}

alertPromptDialog({required String errorMsg,required String title,required child }){
  Get.defaultDialog(
    title: title,
    middleText: errorMsg,
    contentPadding: EdgeInsets.all(0),

    cancel: child,

  );
}