import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/job_offer.dart';
import 'package:maak/screens/home_screen/pages/jobs/add_cv.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/job_offer_item_widget.dart';
import 'package:maak/utils/widgets/jobs_header.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/view_models/add_cv.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/job_offers_view_model.dart';
import 'package:maak/view_models/search/jobs.dart';
import 'package:provider/provider.dart';

import '../../../../utils/consts/navigation.dart';
import '../../../../view_models/account.dart';
import '../../../account/login_page.dart';
import 'bottom_sheet/bottom_jobs_sheet.dart';

class RequestedJobsPage extends StatelessWidget {
  RequestedJobsPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final SearchJobsViewModel searchJobsViewModel = Get.find();
    var cities = Provider.of<MainAppViewModel>(context,listen: false).cities.data!
        .map((e) => e.name!)
        .toList();
    cities.insert(0,"الكل");

    return Consumer<JobOffersViewModel>(builder: (_,viewModel,child){
      searchJobsViewModel.city = viewModel.city;
      return viewModel.loading ? Center(
        child: LoadingWidget(),
      ) :
      Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.mainOrange,
          onPressed: () {
            MainAppViewModel mainApp = Get.find();
            if (!mainApp.isLogged) {
              Go.to(
                  context,
                  ChangeNotifierProvider(
                    create: (_) => AccountViewModel(),
                    child: LoginPage(onLoginComplete: (){
                      Get.to(()=>ChangeNotifierProvider(create: (_)=>AddNewCVViewModel(),child: AddNewCVPage(),));
                    },),
                  ));
              return;
            }
            Get.to(()=>ChangeNotifierProvider(create: (_)=>AddNewCVViewModel(),child: AddNewCVPage(),));
          },
          label: Row(
            children: [

              Text('اضف السيرة الذاتية',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 17,
                  fontFamily: 'Cairo')),
              SizedBox(width: 5,),
              Icon(Icons.add,color: Colors.white,size: 25,),
            ],
          ),

        ),
        body: Column(
          children: [
            JobsHeaderWidget(city: viewModel.city,career: 'المجالات',onChangeCity: (){
              showMyBottomSheet(context,
                  title: 'المدن',
                  data: cities, onItemSelected: (index) async {
                    if(index == 0){
                      viewModel.city = null;
                      searchJobsViewModel.city = null;
                    }else{
                      viewModel.city = Provider.of<MainAppViewModel>(context,listen: false).cities.data![index - 1];
                      searchJobsViewModel.city = viewModel.city;
                    }
                    viewModel.reloadData();
                  });
            },onCareerChanged: (){
              showSpecializationBottomSheet(context,
                  title: 'المجال',
                  data: viewModel.specializations, onItemSelected: () {

                    viewModel.reloadData();
                    // setState(() {});
                  });
            },),
            Container(color: Colors.white, height: 2),
            Expanded(
              child:viewModel.loading ? Center(
                child: LoadingWidget(),
              ) :
              viewModel.jobs.data.isEmpty ? Center(
                child: Text(
                  'لا توجد وظائف في هذه المدينة',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ) :  Container(
                child: RefreshIndicator(
                  color: AppColors.mainOrange,
                  onRefresh: ()async{
                    // viewModel.jobs.data.clear();
                    // viewModel.page = 0;
                    // viewModel.loading = true;
                    viewModel.reloadData();
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo){
                      if (viewModel.jobs.countPage > viewModel.page && scrollController.offset == scrollInfo.metrics.maxScrollExtent) {
                        if(!viewModel.subLoading){
                          viewModel.subLoading = true;
                          viewModel.loadMore();
                        }
                      }
                      return true;
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {

                        if(index % 6 == 0 && index != 0){

                          return viewModel.ads.data.length > 0 ?  Container(
                            width: double.infinity,
                            height: size.width/2,
                            color: Colors.white,
                            child: imageFromServer(
                                fit: BoxFit.contain,
                                imageUrl: viewModel.ads.data[((index ~/ 6)-1) % viewModel.ads.data.length].imageUrl ),
                          ) : SizedBox();
                        }
                        else return SizedBox(height: 5,);
                      },
                      itemCount: viewModel.jobs.data.length,
                      itemBuilder: (context, index) {
                        JobOffer job = viewModel.jobs.data[index];
                        return JobOffersItemWidget(job: job,);
                      },
                    ),
                  ),
                ),
                // color: Colors.red,
              ),
            ),
            Container(
              height: viewModel.subLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: LoadingWidget(),
              ),
            ),
          ],

        ),
      );
    });
  }
}
