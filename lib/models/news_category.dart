
import 'news_sub_category.dart';

class NewsCategory {
  int? id;
  String? name;

  List<NewsSubCategories>? newsSubCategories;

  NewsCategory(
      {this.id,
        this.name,
        this.newsSubCategories});

  NewsCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['news_sub_categories'] != null) {
      newsSubCategories = [];
      json['news_sub_categories'].forEach((v) {
        newsSubCategories!.add(new NewsSubCategories.fromJson(v));
      });
    }
  }

}