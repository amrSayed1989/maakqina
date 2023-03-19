import 'package:flutter/material.dart';
import 'package:maak/models/place.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/share.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/screens/home_screen/pages/places/place_page.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../screens/account/login_page.dart';
import '../../view_models/account.dart';
import '../../view_models/init_app_viewmodel.dart';
import '../consts/app_colors.dart';
import '../consts/navigation.dart';

class PlaceItemWidget extends StatelessWidget {
  final Place place;
  final MainAppViewModel mainApp = Get.find();
  PlaceItemWidget({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                // height: 100,
                child: InkWell(
                  onTap: () {
                    println(
                        '------------???????????/ trader ${place.traderId}');
                    println('------------???????????/ trader ${place.name}');
                    if (!mainApp.isLogged) {
                      Go.to(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => AccountViewModel(),
                            child: LoginPage(
                              onLoginComplete: () {
                                Get.to(() => ChangeNotifierProvider(
                                      create: (BuildContext context) {
                                        return PlaceViewModel(place.traderId);
                                      },
                                      child: PlacePage(),
                                    ));
                              },
                            ),
                          ));
                      return;
                    }
                    Get.to(() => ChangeNotifierProvider(
                          create: (BuildContext context) {
                            return PlaceViewModel(place.traderId);
                          },
                          child: PlacePage(),
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10.0)),
                        child: Container(
                          height: size.width / 3.5,
                          width: size.width / 3,
                          decoration: BoxDecoration(),
                          child: Container(
                            child: imageFromServer(imageUrl: place.image),
                          ),
                        ),
                      ),
                      // SizedBox(width: 10,),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  place.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: AppColors.mainOrange,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                                Text(
                                  place.about,
                                  textAlign: TextAlign.start,
                                  // maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF15412), // Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (BuildContext context) {
                                              return PlaceViewModel(
                                                  place.traderId);
                                            },
                                            child: PlacePage(
                                              initialIndex: 2,
                                            ),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }
                          sharePlaceWith(
                              title: place.name,
                              about: place.about,
                              phone: place.phoneNumber,
                              city: place.cityName);
                          // Share.share(
                          //     'title : ${widget.data[widget.index].title} \n'
                          //         'about  : ${widget.data[widget.index].about} \n'
                          //         'phoneNumber : ${widget.data[widget.index].phoneNumber}  \n'
                          //         'city : ${widget.data[widget.index].city} \n\n\n'
                          //         'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
                          //         'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'مشاركة',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (BuildContext context) {
                                              return PlaceViewModel(
                                                  place.traderId);
                                            },
                                            child: PlacePage(
                                              initialIndex: 2,
                                            ),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }

                          // launchWhatsApp(
                          //     phone: widget.data[widget.index].phoneNumber,
                          //     message: 'مرحبا، اريد مساعدتكم!');

                          launch("tel://${place.phoneNumber}");
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'اتصال',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (BuildContext context) {
                                              return PlaceViewModel(
                                                  place.traderId);
                                            },
                                            child: PlacePage(
                                              initialIndex: 2,
                                            ),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }
                          Get.to(() => ChangeNotifierProvider(
                                create: (BuildContext context) {
                                  return PlaceViewModel(place.traderId);
                                },
                                child: PlacePage(
                                  initialIndex: 2,
                                ),
                              ));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_offer,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'عروض',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (BuildContext context) {
                                              return PlaceViewModel(
                                                  place.traderId);
                                            },
                                            child: PlacePage(
                                              initialIndex: 1,
                                            ),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }
                          Get.to(() => ChangeNotifierProvider(
                                create: (BuildContext context) {
                                  return PlaceViewModel(place.traderId);
                                },
                                child: PlacePage(
                                  initialIndex: 1,
                                ),
                              ));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                place.typeOfCategory,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
