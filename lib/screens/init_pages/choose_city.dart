// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/screens/home_screen/main_page.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ChooseCity extends StatelessWidget {
  // final MainAppViewModel initPageViewModel;
  const ChooseCity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initPageViewModel = Get.find();
    return !initPageViewModel.loading
        ? Container(
            padding: const EdgeInsets.only(top: 8),
            child: initPageViewModel.cities.data?.length != 0
                ? ListView.separated(
                    itemCount: initPageViewModel.cities.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (initPageViewModel.cities.data?.length == 0) {
                        return Container(
                            height: 300,
                            child: Center(
                              child: Text('لا توجد نتائج مطابقة للبحث '),
                            ));
                      }
                      return GestureDetector(
                        onTap: () async {
                          await Cities.setCityToSF(
                              initPageViewModel.cities.data![index]);
                          await initPageViewModel
                              .setCity(initPageViewModel.cities.data![index]);
                          Future.delayed(Duration.zero, () {
                            Go.off(context, MainPageScreen());
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: Text(
                              initPageViewModel.cities.data?[index].name ?? '',
                              // textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                          decoration: BoxDecoration(
                              // color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.5)
                              ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                : Center(
                    child: Text(
                      tr('NoCitiesYet'),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
          )
        : Container(
            child: Center(
              child: LoadingWidget(),
            ),
          );
  }
}
