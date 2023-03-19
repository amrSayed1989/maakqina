
class NewsSubCategories {
  int? id;
  String? name;
  int? newsCategoryId;




  NewsSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    newsCategoryId = json['news_category_id'];

  }

}