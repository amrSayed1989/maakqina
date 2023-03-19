import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/offer.dart';
import 'package:maak/utils/widgets/offer_item_widget.dart';

import '../../../../../utils/widgets/loading_widget.dart';
import 'controllers/offers.dart';

class OffersTabWidget extends StatelessWidget {

  final traderOffersController = Get.put(OffersController());
  final int traderId;

   OffersTabWidget({Key? key,required this.traderId}) : super(key: key){

   }

   getOffers(){
     traderOffersController.retrieveOffer(traderId);
   }
  @override
  Widget build(BuildContext context) {
    getOffers();

    return Obx(()=>traderOffersController.loading.value ? Center(
      child: LoadingWidget(),
    ) : Container(
      child:traderOffersController.traderOffers.value.offers.length == 0 ? Center(
        child: Text(
          'لا توجد عروض',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ) : Container(
        child: ListView.separated(
          // controller: scrollController,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Container(
              color: Colors.white,
              height: 20,
            );
          },
          itemCount: traderOffersController.traderOffers.value.offers.length,
          itemBuilder: (context, index) {
            Offer offer = traderOffersController.traderOffers.value.offers[index];
            return InkWell(
              onTap: (){
                print('==============================');

              },
              child: OfferItemWidget(
                price: offer.price,
                title: offer.name,
                id: offer.id ,
                image: offer.image,
                about: offer.addDate ,
                address: offer.location,
                endDate: offer.endDate,
                phoneNumber: offer.phoneNumber,
                traderName: offer.traderName,
              ),
            );
          },
        ),
      ),
    ));
  }
}
