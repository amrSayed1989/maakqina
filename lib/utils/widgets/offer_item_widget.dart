import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/offer_controller.dart';
import 'package:maak/screens/home_screen/pages/offers/offer_page.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/view_models/offer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/account/login_page.dart';
import '../../view_models/account.dart';
import '../../view_models/init_app_viewmodel.dart';
import '../consts/navigation.dart';
import '../consts/share.dart';

class OfferItemWidget extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String about;
  final String traderName;
  final String address;
  final String endDate;
  final String phoneNumber;
  final String price;

  OfferItemWidget(
      {Key? key,
      required this.image,
      required this.price,
      required this.about,
      required this.title,
      required this.traderName,
      required this.address,
      required this.endDate,
      required this.phoneNumber,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          child: InkWell(
            onTap: () {
              MainAppViewModel mainApp = Get.find();
              if (!mainApp.isLogged) {
                Go.to(
                    context,
                    ChangeNotifierProvider(
                      create: (_) => AccountViewModel(),
                      child: LoginPage(
                        onLoginComplete: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        create: (_) => OfferDetailsViewModel(
                                            OfferController(
                                                offerId: id, offerName: title)),
                                        child: OfferPage(),
                                      )));
                        },
                      ),
                    ));
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                            create: (_) => OfferDetailsViewModel(
                                OfferController(offerId: id, offerName: title)),
                            child: OfferPage(),
                          )));
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Container(
                    width: size.width * 0.3,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        // border: Border.all(color: AppColors.mainOrange),
                        ),
                    child: imageFromServer(imageUrl: image),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.mainOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          traderName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          address,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          ' العرض ساري حتى  $endDate',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 105,
                  padding: const EdgeInsets.only(
                      left: 4, top: 4, bottom: 4, right: 4),
                  decoration: BoxDecoration(
                    color: AppColors.mainOrange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          MainAppViewModel mainApp = Get.find();
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                    create: (_) =>
                                                        OfferDetailsViewModel(
                                                            OfferController(
                                                                offerId: id,
                                                                offerName:
                                                                    title)),
                                                    child: OfferPage(),
                                                  )));
                                    },
                                  ),
                                ));
                            return;
                          }
                          shareOfferWith(
                              title: title,
                              about: about,
                              phone: phoneNumber,
                              price: price,
                              address: address,
                              traderName: traderName,
                              dateEnd: endDate);
                        },
                        child: ClipOval(
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.share,
                              // color: Colors.grey,
                              color: Color(0xffF15412), //Colors.whit

                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          MainAppViewModel mainApp = Get.find();
                          if (!mainApp.isLogged) {
                            Go.to(
                                context,
                                ChangeNotifierProvider(
                                  create: (_) => AccountViewModel(),
                                  child: LoginPage(
                                    onLoginComplete: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                    create: (_) =>
                                                        OfferDetailsViewModel(
                                                            OfferController(
                                                                offerId: id,
                                                                offerName:
                                                                    title)),
                                                    child: OfferPage(),
                                                  )));
                                    },
                                  ),
                                ));
                            return;
                          }
                          launch("tel://$phoneNumber");
                        },
                        child: ClipOval(
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.phone,
                              // color: Colors.grey,
                              color: Color(0xffF15412), //Colors.whit

                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
