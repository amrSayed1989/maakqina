import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/screens/home_screen/pages/jobs/reuested_jobs.dart';
import 'package:maak/view_models/job_offers_view_model.dart';
import 'package:maak/view_models/jobs_view_model.dart';
import 'package:maak/view_models/search/jobs.dart';
import 'package:provider/provider.dart';
import 'available_added_jobs.dart';

// class JobsPage extends StatefulWidget {
//
//
//   JobsPage({Key? key}) : super(key: key);
//
//   @override
//   State<JobsPage> createState() => _JobsPageState();
// }

class JobsTabsPage extends StatefulWidget {
  JobsTabsPage({Key? key}) : super(key: key);

  @override
  State<JobsTabsPage> createState() => _JobsTabsPageState();
}

class _JobsTabsPageState extends State<JobsTabsPage> {
  Color _color1 = Color(0xFFe75f3f);
  Color _color2 = Color.fromARGB(255, 255, 250, 250);
  int currentPage = 0;

  PageController _pageController = PageController();
  SearchJobsViewModel searchJobsViewModel = Get.put(SearchJobsViewModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    searchJobsViewModel.currentJobPage = 'وظائف خالية';
                    setState(() {
                      currentPage = 0;
                    });
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('وظائف خالية',
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentPage == 0 ? _color1 : _color2),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    searchJobsViewModel.currentJobPage = 'طلب وظيفة';
                    setState(() {
                      currentPage = 1;
                    });
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('طلب وظيفة',
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentPage == 0 ? _color2 : _color1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                    ),
                  ),
                )),
              ],
            ),
            color: Colors.black,
          ),
          Container(color: Colors.white, height: 2),
          Expanded(
            child: Consumer<JobOffersViewModel>(
              //JobsViewModel
              builder: (_, jobsViewModel, child) {
                return Consumer<JobsViewModel>(
                    builder: (_, jobsOfferViewModel, child) {
                  //JobOffersViewModel
                  return PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      // setState(() => currentPage = index);
                    },
                    children: <Widget>[
                      AvailableJobsPage(),
                      RequestedJobsPage()
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
