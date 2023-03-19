import 'dart:io';
import 'package:image/image.dart' as imagePackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/utils/widgets/choosing_file_widget.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/my_text_field.dart';
import 'package:maak/view_models/add_job.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';

class AddNewJobPage extends StatefulWidget {
  AddNewJobPage({Key? key}) : super(key: key);

  @override
  _AddNewJobPageState createState() => _AddNewJobPageState();
}

class _AddNewJobPageState extends State<AddNewJobPage> {
  final ImagePicker _picker = ImagePicker();

  var _image;
  bool sendingData = false;

  Future<String?> _pickUpImage(
      {ImageSource imageSource = ImageSource.gallery}) async {
    final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 5);
    if (image == null) return null;

    return image.path;
  }

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();

    return Consumer<AddNewJobViewModel>(builder: (_, viewModel, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar(
              title: 'إدخال وظيفة جديدة',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    Center(
                      child:
                          // downloadingImage ? CircularProgressIndicator() :
                          GestureDetector(
                              onTap: () async {
                                showMyDialog(context,
                                    title: 'أختر صورة',
                                    message:
                                        'يرجى إختيار صورة شخصية من البوم الصور او الكاميرا',
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                Get.back();
                                                String? imgPath =
                                                    await _pickUpImage();
                                                if (imgPath != null) {
                                                  var decodedImage = imagePackage
                                                      .decodeImage(File(imgPath)
                                                          .readAsBytesSync());
                                                  if (decodedImage != null) {
                                                    if (decodedImage.width >
                                                        720) {
                                                      imagePackage.Image
                                                          thumbnail =
                                                          imagePackage
                                                              .copyResize(
                                                                  decodedImage,
                                                                  width: 720);

                                                      new File(imgPath)
                                                        ..writeAsBytesSync(
                                                            imagePackage
                                                                .encodePng(
                                                                    thumbnail));
                                                    }
                                                  }
                                                  viewModel.imagePath = imgPath;

                                                  setState(() {
                                                    _image = File(imgPath);
                                                  });
                                                }
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'ألبوم الصور ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColors.mainOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                Get.back();
                                                String? imgPath =
                                                    await _pickUpImage(
                                                        imageSource:
                                                            ImageSource.camera);
                                                if (imgPath != null) {
                                                  viewModel.imagePath = imgPath;
                                                  setState(() {
                                                    _image = File(imgPath);
                                                  });
                                                }
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'الكاميرا',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColors.mainOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]);
                              },
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: AppColors.mainOrange, width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                      child: _image == null
                                          ? Icon(
                                              Icons.photo_camera_outlined,
                                              size: 50,
                                              color: AppColors.mainOrange,
                                            )
                                          : Image.file(
                                              _image,
                                              width: 110.0,
                                              height: 110.0,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              )),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'اضف صورة للوظيفة',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'اسم المكان',
                      height: 50.0,
                      onSaved: (value) {
                        viewModel.placeName = value;
                      },
                      hint: 'ادخل اسم المكان ',
                    ),
                    SizedBox(height: 10),
                    MyTextFormField(
                        name: 'تفاصيل الوظيفة',
                        onSaved: (value) {
                          viewModel.details = value;
                        },
                        hint: 'اكتب رسالتك هنا',
                        height: 5.0 * 24.0,
                        maxLines: 7),
                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'رقم الواتس اب',
                      hint: 'ادخل رقم الواتس اب',
                      onSaved: (value) {
                        viewModel.whatsappNumber = value;
                      },
                      height: 50.0,
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 10),
                    MyTextFormField(
                      name: 'البريد الالكتروني',
                      height: 50.0,
                      onSaved: (value) {
                        viewModel.email = value;
                      },
                      hint: 'ادخل الايميل ',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 10),
                    // category + city
                    InkWell(
                        onTap: () {
                          showMyBottomSheet(context,
                              title: 'المجال',
                              data: viewModel.specializations
                                  .map((e) => e.name!)
                                  .toList(), onItemSelected: (index) {
                            viewModel.specialization =
                                viewModel.specializations[index];
                            setState(() {});
                          });
                        },
                        child: choosingFieldWidget(
                            viewModel.specialization == null
                                ? 'اختر المجال'
                                : viewModel.specialization!.name!)),
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () {
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
                          sendingData = true;
                          setState(() {});

                          String message = await viewModel.sendCvData();
                          sendingData = false;
                          setState(() {});
                          if (message == 'EmptyFields') {
                            alertErrorDialog('يجب اكمال جميع البيانات');
                          } else if (message == 'Created') {
                            alertErrorDialog(
                                "سوف يتم مراجعة إعلان الوظيفة ويتم الموفقة عليها خلال 12 ساعة",
                                closeOverlays: true);
                          } else {
                            alertErrorDialog(
                                "هناك خطأ ما, يرجي المحاولة في وقت لاحق",
                                closeOverlays: false);
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
