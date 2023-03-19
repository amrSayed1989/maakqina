import 'ad_sub_category.dart';

class AdCategory {
  int id = 0;
  String name = '';
  List<AdSubCategory> subCategories = [];


 AdCategory({
    required this.name,
   required this.id
});



  AdCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['news_sub_categories'] != null) {
      // subCategories.insert(0, AdSubCategory( -1, 'الكل'));
      json['news_sub_categories'].forEach((v) {
        subCategories.add(new AdSubCategory.fromJson(v));
      });
    }
  }

}
