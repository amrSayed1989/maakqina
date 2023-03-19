
import 'package:share_plus/share_plus.dart';

void shareContentWith({
  required String title,
  required String about,
  required String phone,
  required String city,
}){
  Share.share(
      'title : $title\n'
          'about  : $about\n'
          'phoneNumber : $phone\n'
          'city : $city\n'
          'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
          'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');
}

shareJobWith({
  required String title,
  required String about,
  required String phone,
  required String city,
  required String email,
  required String nameOfSpecialist,
}){
  Share.share(' title Of Job : $title\n '
      'details Of Job  : $about\n '
      'email  : $email\n '
      'city : $city\n'
      'nameOfSpecialist : $nameOfSpecialist\n'
      ' phoneNumber : $phone\n'
      'link of the app on google play : https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
      'link of the app on app store : https://apps.apple.com/us/app/id1573237241');

}

shareOfferWith({
  required String title,
  required String about,
  required String phone,
  required String price,
  required String address,
  required String dateEnd,
  required String traderName,
}){
  Share.share('title : $title \n '
      'details  : $about \n '
      'price  : $price\n '
      'phoneNumber : $phone \n'
      'address : $address\n'
      'dateEnd : $dateEnd \n'
      'traderName : $traderName \n'
      '\n'
      'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
      'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');                              // }

}

void sharePlaceWith({
  required String title,
  required String about,
  required String phone,
  required String city,
}){
  Share.share(
      'title : $title\n'
          'about  : $about\n'
          'phoneNumber : $phone\n'
          'city : $city\n'
          'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
          'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');
}

shareProductWith({
  required String title,
  required String about,
  required String price,
  required String address,
  required String brand,
  required String priceAfter,
  required String traderName,
}){
  Share.share(' name : $title \n '
      'details : $about\n '
      'traderName : $traderName \n'
      'price : $price\n '
      'price After Discount : $priceAfter\n '
      'address : $address\n'
      ' brand : $brand\n'
      'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
      'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');

}