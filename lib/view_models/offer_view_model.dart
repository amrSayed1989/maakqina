import 'package:flutter/material.dart';
import 'package:maak/model_services/offer_controller.dart';

class OfferDetailsViewModel extends ChangeNotifier{

  final OfferController offerController;
  bool isLoading = true;
  bool expandingDetails = true;

  OfferDetailsViewModel(this.offerController){
    offerController.retrieveOffer((){
      isLoading = false;
      notifyListeners();
    });

  }

  setExpandingDetails(){
    print('------------ expandingDetails $expandingDetails');
    expandingDetails = !expandingDetails;
    notifyListeners();
  }

}