import 'package:maak/models/place.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class PlaceService {
  Place? data;


  fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Place.fromJson(json['data']) : null;
  }

  getPlaces(int placeId,onDone) async {
     AppApiHandler.getData(url: '${AppUrl.places}/$placeId', body: null, callback: (json){

      this.fromJson(json);
      onDone();
    });



  }
}



