
 String get mainUrl {
  // return 'https://yallservice.com';
  return 'https://m3akm3ak.com';
}

String get imageBaseUrl{
  if(mainUrl.contains("yallservice") ){
    return mainUrl;
  }

  return '';
}
 String apiVersion = '$mainUrl/api/v1';


class AppUrl {
  static String cities = '$apiVersion/cities';

  static String places = '$apiVersion/departments';

  static String notifications = '$apiVersion/notifications';

  static String offers = '$apiVersion/offers';

  static String slideImagesInHome = '$apiVersion/mainpageimages';

  static String ads = '$apiVersion/item_advertisements';

  static var products = '$apiVersion/products';

  static var getTradersWithProducts = '$apiVersion/getTradersWithProducts';


  static String jobs = '$apiVersion/jobs';

  static String jobOffers = '$apiVersion/job-offers';

  static String placesServices = '$apiVersion/categories?type=';

  static String news = '$apiVersion/news';

  static String specializations = '$apiVersion/specializations';

  static String newsCategories = '$apiVersion/news_categories';

  // static String traders = '$apiVersion/traders';
  static String traders = '$apiVersion/getTraderById';
  static String coupons = '$apiVersion/coupons';
//https://m3akm3ak.com/api/v1/news

//https://m3akm3ak.com/api/v1/news_sub_categories
}