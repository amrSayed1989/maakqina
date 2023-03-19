// ignore_for_file: unnecessary_question_mark

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/product.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../model_services/offer_controller.dart';
import '../../model_services/product_service.dart';
import '../../models/city.dart';
import '../../utils/consts/navigation.dart';
import '../../utils/consts/print_utils.dart';
import '../../utils/consts/urls.dart';
import '../../utils/network/api.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../../view_models/available_job_view_model.dart';
import '../../view_models/init_app_viewmodel.dart';
import '../../view_models/offer_view_model.dart';
import '../../view_models/place_view_model.dart';
import '../../view_models/show_single_ad.dart';
import '../../view_models/single_product.dart';
import '../home_screen/pages/ads/show_single_ad.dart';
import '../home_screen/pages/jobs/single_available_job.dart';
import '../home_screen/pages/offers/offer_page.dart';
import '../home_screen/pages/places/place_page.dart';
import '../home_screen/pages/products/single_product.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  NotificationsServices notificationsServices = NotificationsServices();
  var loading = true;

  @override
  void initState() {
    super.initState();
    notificationsServices.getNotifications(() {
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الاشعارات',
      ),
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: LoadingWidget(),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    AppNotification notif = notificationsServices.data[index];
                    return Container(
                      child: ListTile(
                        title: Text(notif.title ?? ''),
                        subtitle: Text(notif.modelType ?? ''),
                        leading: Text('${notif.modelId}'),
                        trailing: Text(notif.city?.name ?? ''),
                        onTap: () {
                          if (('${notif.modelType}').toLowerCase() == 'job') {
                            Get.to(() => ChangeNotifierProvider(
                                  create: (_) => AvailableJobViewModel(
                                      jobId: notif.modelId),
                                  child: SingleAvailableJobPage(),
                                ));
                          } else if ((('${notif.modelType}').toLowerCase() ==
                              'offer')) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          create: (_) => OfferDetailsViewModel(
                                              OfferController(
                                                  offerId: notif.modelId ?? 0,
                                                  offerName: '')),
                                          child: OfferPage(),
                                        )));
                          } else if ((('${notif.modelType}').toLowerCase() ==
                              'department')) {
                            Get.to(() => ChangeNotifierProvider(
                                  create: (BuildContext context) {
                                    return PlaceViewModel(notif.traderId ?? 0);
                                  },
                                  child: PlacePage(),
                                ));
                          } else if ((('${notif.modelType}').toLowerCase() ==
                              'product')) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => SingleProductViewModel(
                                      ProductService(
                                          Product(id: notif.modelId ?? 0)),
                                      isFromNotif: true),
                                  child: SingleProductPage(),
                                ));
                          } else if ((('${notif.modelType}').toLowerCase() ==
                              'news')) {
                            Get.to(() => ChangeNotifierProvider(
                                  create: (_) =>
                                      ShowSingleAdViewModel(notif.modelId ?? 0),
                                  child: ShowSingleAdPage(),
                                ));
                          }
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: notificationsServices.data.length),
            ),
    );
  }
}

class NotificationsServices {
  List<AppNotification> data = <AppNotification>[];

  NotificationsServices();

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      if (json['data'][0] != null) {
        json['data'][0].forEach((v) {
          data.add(new AppNotification.fromJson(v));
        });
      }
    }
  }

  getNotifications(onDone) async {
    MainAppViewModel mainApp = Get.find<MainAppViewModel>();

    var params = {"city_id": '${mainApp.cityId}'};

    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value';
    });

    println(queryParameters);
    AppApiHandler.getData(
        url: '${AppUrl.notifications}/$queryParameters',
        apiKind: 'notifications',
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}

class AppNotification {
  int? id;
  String? title;
  String? content;
  int? cityId;
  String? modelType;
  int? modelId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  City? city;
  int? traderId;

  AppNotification(
      {this.id,
      this.title,
      this.content,
      this.cityId,
      this.modelType,
      this.modelId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.traderId,
      this.city});

  AppNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    cityId = json['city_id'];
    modelType = json['model_type'];
    modelId = int.tryParse('${json['model_id']}');
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    traderId = int.tryParse('${json['trader_id']}');
  }
}

// class City {
//   int? id;
//   String? name;
//
//   City({this.id, this.name});
//
//   City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
// }
