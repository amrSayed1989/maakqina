import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/shopping_cart.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/controller/controller.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/consts/navigation.dart';
import '../../../../../view_models/account.dart';
import '../../../../account/login_page.dart';
import 'continue.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  ShoppingCartController viewModel = Get.find();
  MainAppViewModel initApp = Get.find<MainAppViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'السلة',
      ),
      body: Obx(() => Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.greyBackground,
            child:viewModel.isEmptyCart.value ? Center(
              child: Text("السلة فارغة",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'),),
            ) : Column(
              children: [
                viewModel.traderName != null ? Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                    child: Row(
                      children: [
                        Text('منتجات من التاجر : ',style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(viewModel.traderName ?? '',style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                ) : SizedBox(),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          CartItem item = viewModel.shoppingItems[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 150,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            child: imageFromServer(
                                                imageUrl: item.image ?? '')),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  item.name ?? '',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                InkWell(
                                                  onTap: (){
                                                    Get.dialog(
                                                      AlertDialog(
                                                        // title: Text("This should not be closed automatically"),
                                                        content: Text("هل تريد حذف هذا المنتج؟"),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                            child: Text("نعم",style: TextStyle(
                                                              color: Colors.white
                                                            ),),
                                                            onPressed: () {
                                                              viewModel.removeItem(index);
                                                              setState(() { });
                                                              Get.back();
                                                            },
                                                          ),

                                                          ElevatedButton(
                                                            child: Text("لا",style: TextStyle(
                                                                color: Colors.white
                                                            ),),
                                                            onPressed: () {

                                                              Get.back();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      barrierDismissible: false,
                                                    );

                                                  },
                                                    child: Icon(
                                                  Icons.clear,
                                                  color: Colors.red,
                                                )),
                                              ],
                                            ),
                                            Text('اللون: ${item.color}'),
                                            Text('الحجم: ${item.size}'),
                                            Row(
                                              children: [
                                                Text('العدد: '),
                                                SizedBox(width: 8,),
                                                InkWell(
                                                  onTap: (){
                                                    // item.count = item.count! + 1;
                                                    viewModel.incrementItemCount(index);
                                                    setState(() {

                                                    });
                                                  },
                                                    child: Icon(Icons.add_circle_outline)),
                                                SizedBox(width: 8,),
                                                Text('${item.count}'),
                                                SizedBox(width: 8,),
                                                InkWell(
                                                    onTap: (){
                                                      if(item.count! > 1){
                                                        // item.count = item.count! - 1;
                                                        viewModel.decrementItemCount(index);
                                                      }
                                                      setState(() {

                                                      });
                                                    },child: Icon(Icons.remove_circle_outline)),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0,left: 8,right: 8),
                                    child: Row(
                                      children: [
                                        Text('السعر: ${item.price}'),
                                        Spacer(),
                                        Text(
                                            'الاجمالي: ${double.tryParse(item.price ?? '')! * (item.count ?? 0)}'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: viewModel.shoppingItems.length,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if(initApp.isLogged){
                      Get.to(FinishOrder());
                    }else{
                      Go.to(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => AccountViewModel(),
                            child: LoginPage(onLoginComplete: (){
                              Get.to(FinishOrder());
                            },),
                          ));
                    }

                  },
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'التالي',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: AppColors.mainOrange),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
