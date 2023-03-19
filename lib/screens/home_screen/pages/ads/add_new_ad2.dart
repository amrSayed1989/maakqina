// ignore_for_file: unused_import

import 'dart:io';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imagePackage;
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/utils/widgets/choosing_file_widget.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/my_text_field.dart';
import 'package:maak/view_models/add_new_ads_app.dart';

import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';

import 'buttom_sheet_add_ad.dart';

class AddNewAdPage2 extends StatefulWidget {
  const AddNewAdPage2({Key? key}) : super(key: key);

  @override
  _AddNewAdPage2State createState() => _AddNewAdPage2State();
}

class _AddNewAdPage2State extends State<AddNewAdPage2> {
  bool sendingData = false;

  // Future<String?> _pickUpImage(
  //     {ImageSource imageSource = ImageSource.gallery}) async {
  //   final XFile? image = await _picker.pickImage(
  //       source: imageSource, preferredCameraDevice: CameraDevice.front);
  //   if (image == null) return null;
  //
  //   return image.path;
  // }

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();

    return Consumer<AddNewAdsAppViewModel>(builder: (_, viewModel, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar(
              title: 'ادخال إعلان جديد',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    GestureDetector(
                      onTap: () async {
                        viewModel.files.clear();
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: file_picker.FileType.image,
                          allowCompression: true,
                        );

                        if (result != null) {
                          println(
                              '-------------- length ${result.files.length}');
                          if (result.files.length > 4) {
                            var files = result.files.getRange(0, 5).toList();
                            for (var file in files) {
                              viewModel.files.add(File(file.path ?? ''));
                            }
                          } else {
                            for (var file in result.files) {
                              viewModel.files.add(File(file.path ?? ''));
                            }
                          }

                          setState(() {});
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: SizedBox(
                        height: 100,
                        child: viewModel.files.length > 0
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.files.length,
                                itemBuilder: (context, indx) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.mainOrange,
                                            width: 2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Center(
                                            child: viewModel.files.isEmpty
                                                ? Icon(
                                                    Icons.photo_camera_outlined,
                                                    size: 50,
                                                    color: AppColors.mainOrange,
                                                  )
                                                : Image.file(
                                                    viewModel.files[indx],
                                                    width: 95.0,
                                                    height: 95.0,
                                                    fit: BoxFit.cover,
                                                  )),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 95,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.mainOrange,
                                          width: 2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Center(
                                          child: Icon(
                                        Icons.photo_camera_outlined,
                                        size: 50,
                                        color: AppColors.mainOrange,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'اضف صورة الإعلان',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'عاوز تشتري ايه ؟',
                      height: 50.0,
                      onSaved: (value) {
                        viewModel.name = value;
                      },
                      hint: 'ادخل اسم الإعلان ',
                    ),
                    SizedBox(height: 10),
                    MyTextFormField(
                        name: 'تفاصيل الاعلان',
                        onSaved: (value) {
                          viewModel.adDetails = value;
                        },
                        hint:
                            'قرب الفكرة اكتر بالتفاصيل عشان تلاقيها معاك بسرعة',
                        height: 5.0 * 24.0,
                        maxLines: 7),
                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'السعر',
                      hint: 'اكتب هنا عاوزها في حدود كام',
                      onSaved: (value) {
                        viewModel.price = value;
                      },
                      height: 50.0,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),

                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'العنوان التفصيلي',
                      height: 50.0,
                      onSaved: (value) {
                        viewModel.address = value;
                      },
                      hint: 'ادخل العنوان التفصيلي ',
                      keyboardType: TextInputType.streetAddress,
                    ),
                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'رقم الهاتف',
                      onSaved: (value) {
                        viewModel.phoneNumber = value;
                      },
                      height: 50.0,
                      hint: 'ادخل رقم الهاتف',
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'رقم الواتس اب',
                      onSaved: (value) {
                        viewModel.whatsappNumber = value;
                      },
                      height: 50.0,
                      hint: 'ادخل رقم الواتس اب',
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 10),
                    // category + city
                    InkWell(
                      onTap: viewModel.loadingCats
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              showMyBottomSheetAddCategories(context,
                                  title: 'تصنيف الاعلانات',
                                  categories:
                                      viewModel.adCategoriesService.categories,
                                  onItemSelected: (selectedCategory,
                                      selectedAdSubCategory) {
                                viewModel.selectedAdSubCategory =
                                    selectedAdSubCategory;
                                viewModel.selectedCategory = selectedCategory;
                                setState(() {});
                              });
                            },
                      child: choosingFieldWidget(
                          viewModel.selectedCategory == null
                              ? 'تصنيف الاعلانات الرئيسي والفرعي'
                              : viewModel.selectedAdSubCategory!.name),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showMyBottomSheet(context,
                              title: 'المدن',
                              data: initAppViewModel.cities.data!
                                  .map((e) => e.name!)
                                  .toList(), onItemSelected: (index) {
                            viewModel.city =
                                initAppViewModel.cities.data![index];
                            setState(() {});
                          });
                        },
                        child: choosingFieldWidget(
                          // choosingCity[1].isNotEmpty ?   'المدينة' + " : "  + choosingCity[1] : 'اختر المدينة',

                          viewModel.city == null
                              ? 'اختر المدينة'
                              : viewModel.city!.name ?? '',
                        )),

                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        // color:  Color(0xffF15412),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          sendingData = true;
                          setState(() {});

                          String message = await viewModel.sendAdData();
                          sendingData = false;
                          setState(() {});
                          if (message ==
                              'تم انشاء الاعلان بنجاح وفي انتظار المراجعة')
                            alertErrorDialog(message, closeOverlays: true);
                          else
                            alertErrorDialog(message);
                          return;
                          // ignore: dead_code
                          if (message == 'EmptyFields') {
                            alertErrorDialog('يجب اكمال جميع البيانات');
                          } else if (message == 'Created') {
                            alertErrorDialog(
                                "سوف يتم مراجعة اعلانك ويتم الموفقة عليه خلال 12 ساعة",
                                closeOverlays: true);
                          }
                        },
                        child: Text(
                          'ارسال',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          sendingData
              ? Container(
                  child: UpLoadingWidget(),
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                )
              : SizedBox()
        ],
      );
    });
  }
}
