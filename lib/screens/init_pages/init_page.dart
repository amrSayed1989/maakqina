// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/init_page.dart';
import 'package:maak/screens/home_screen/main_page.dart';
import 'package:maak/screens/init_pages/choose_city.dart';
import 'package:maak/screens/init_pages/slider_pages.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/init_page_screen.dart';
import 'package:provider/provider.dart';

class InitPageScreen extends StatefulWidget {
  const InitPageScreen({Key? key}) : super(key: key);

  @override
  _InitPageScreenState createState() => _InitPageScreenState();
}

class _InitPageScreenState extends State<InitPageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitPageScreenViewModel>(builder: (_, viewModel, child) {
      return Scaffold(
        appBar: viewModel.screensDone
            ? AppBar(
                title: Text('اختر المدينة'.tr()),
              )
            : null,
        body: SafeArea(
          child: viewModel.screensDone
              ? ChooseCity()
              : SliderPagesWidget(
                  initPageViewModel: viewModel,
                ),
        ),
      );
    });
  }
}
