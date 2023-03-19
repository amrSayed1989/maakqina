// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/screens/home_screen/pages/jobs/send_job_request.dart';
import 'package:maak/utils/widgets/circular_image.dart';
import 'package:maak/utils/widgets/curved_shadow_container.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/available_job_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/consts/app_colors.dart';
import '../../../../utils/consts/print_utils.dart';
import '../../../../view_models/init_app_viewmodel.dart';

class SingleAvailableJobPage extends StatelessWidget {
  const SingleAvailableJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableJobViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'تفاصيل الوظيفة',
          ),
          body: viewModel.loading
              ? Center(
                  child: LoadingWidget(),
                )
              : Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 16, right: 16),
                            child: Column(
                              children: [
                                CircularWidget(
                                    width: 100,
                                    child: imageFromServer(
                                        imageUrl: viewModel.job!.jobImage)),
                                SizedBox(
                                  height: 8,
                                ),
                                CurvedShadowedContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("اسم المكان" + " :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: Text(
                                                viewModel.job!.titleOfJob,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("التخصص" + " :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: Text(
                                                viewModel.job!.nameOfSpecialist,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("التاريخ" + " :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: Text(
                                                viewModel.job!.dateOfAddingJob,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("المدينة" + " :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.mainOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: Text(viewModel.job!.cityName,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Cairo')),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                CurvedShadowedContainer(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('تفاصيل الوظيفة :',
                                            style: TextStyle(
                                                // decoration: TextDecoration.underline,
                                                fontSize: 16,
                                                color: AppColors.mainOrange,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo')),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: Text(viewModel.job!.details,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          // color: Color(0xffF15412)  , //Colors.whit
                          onPressed: () {
                            MainAppViewModel mainApp = Get.find();
                            if (!mainApp.isLogged) {
                              Go.to(
                                  context,
                                  ChangeNotifierProvider(
                                    create: (_) => AccountViewModel(),
                                    child: LoginPage(
                                      onLoginComplete: () {
                                        Go.to(
                                            context,
                                            SendingJobRequestPage(
                                              titleOfJob:
                                                  viewModel.job!.titleOfJob,
                                              ownerPhoneNumber:
                                                  viewModel.job!.whatsappNumber,
                                            ));
                                      },
                                    ),
                                  ));
                            } else {
                              Go.to(
                                  context,
                                  SendingJobRequestPage(
                                    titleOfJob: viewModel.job!.titleOfJob,
                                    ownerPhoneNumber:
                                        viewModel.job!.whatsappNumber,
                                  ));
                            }
                          },
                          child: Center(
                            child: Text(
                              'قدم الان',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Cairo'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
