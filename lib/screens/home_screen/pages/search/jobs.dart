import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/job.dart';
import 'package:maak/models/job_offer.dart';
import 'package:maak/screens/home_screen/pages/jobs/single_available_job.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/job_offer_item_widget.dart';
import 'package:maak/utils/widgets/jobs_item_list.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/search_text_field.dart';
import 'package:maak/view_models/available_job_view_model.dart';
import 'package:maak/view_models/search/jobs.dart';
import 'package:provider/provider.dart';

class SearchJobsPage extends StatelessWidget {

   SearchJobsPage({Key? key}) : super(key: key);

   final SearchJobsViewModel viewModel = Get.find();
   final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Obx(()=>Scaffold(
      body: Container(
        color: AppColors.greyBackground,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top,
              decoration: BoxDecoration(
                  color: AppColors.mainOrange
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top,),
                  Row(
                    children: [
                      Expanded(
                        child: SearchTextForm( onChangeHandler: (value ) {
                          viewModel.searchData(value);
                        },),
                      ),
                      InkWell(
                        onTap: (){
                          viewModel.clearData();
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward ,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child:viewModel.loading.value ? Center(
                child: LoadingWidget(),
              ) :
              viewModel.isEmptyData ? Center(
                child: Text(
                  'لا توجد وظائف في هذه المدينة',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ) :   Container(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo){
                    if (viewModel.countPage > viewModel.page && scrollController.offset == scrollInfo.metrics.maxScrollExtent) {
                      if(!viewModel.subLoading.value){
                        viewModel.subLoading.value = true;
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

                        return viewModel.ads.value.data.length > 0 ?  Container(
                          width: double.infinity,
                          height: size.width/2,
                          color: Colors.white,
                          child: imageFromServer(
                              fit: BoxFit.contain,
                              imageUrl: viewModel.ads.value.data[((index ~/ 6)-1) % viewModel.ads.value.data.length].imageUrl ),
                        ) : SizedBox();
                      }
                      else return SizedBox(height: 5,);
                    },
                    itemCount: viewModel.dataLength,
                    itemBuilder: (context, index) {

                      if(viewModel.currentJobPage == 'وظائف خالية'){
                        Job job = viewModel.jobs.value.data[index];
                        return JobItemWidget(job: job, onClick: () {
                          Get.to(
                                  ()=> ChangeNotifierProvider(create: (_)=>AvailableJobViewModel(job:job),
                                child: SingleAvailableJobPage(),
                              )
                          );
                        },
                        );
                      }else{
                        JobOffer job = viewModel.jobsOffers.value.data[index];
                        return JobOffersItemWidget(job: job,);
                      }


                    },
                  ),
                ),
                // color: Colors.red,
              ),
            ),
            Container(
              height: viewModel.subLoading.value ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: LoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
