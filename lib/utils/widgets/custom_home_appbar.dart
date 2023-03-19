// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/screens/home_screen/main_page.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet.dart';
import 'loading_widget.dart';

class CustomHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final int currentPage;

  CustomHomeAppBar({Key? key, required this.title, required this.currentPage})
      : super(key: key);

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  bool search = false;

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();
    return Container(
      color: AppColors.mainOrange,
      height: AppBar().preferredSize.height +
          MediaQuery.of(context).viewPadding.top,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 3000),
                              height: AppBar().preferredSize.height - 16,
                              width: search ? double.infinity : 0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: AppColors.unSelectedGray),
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.currentPage == 0
                      ? InkWell(
                          onTap: () {
                            showMyBottomSheet(context,
                                title: 'المدن',
                                data: initAppViewModel.cities.data!
                                    .map((e) => e.name!)
                                    .toList(), onItemSelected: (index) async {
                              await initAppViewModel.setCity(
                                  initAppViewModel.cities.data![index]);
                              Go.off(context, MainPageScreen());
                            });
                          },
                          child: Row(
                            children: [
                              Text('${initAppViewModel.cityName}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  widget.currentPage != 0
                      ? InkWell(
                          onTap: () {
                            search = !search;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

dsfhj() {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 50.0),
        decoration: BoxDecoration(
            // color: Colors.white,
            border: Border.all(color: Colors.black, width: 3)),
        child: TextFormField(
          style: TextStyle(backgroundColor: Colors.green),
          decoration: InputDecoration(fillColor: Colors.red),
        ),
      ),
    ), //Text(titles[currentPage]),
    centerTitle: true,
    leading: Icon(
      Icons.menu,
      color: Colors.white,
    ),
    actions: [],
  );
}
