class AdSubCategory {
  int id = 0;
  String name = '';
  int categoryId = 0;
  bool selected = false;

  AdSubCategory(this.id,this.name);
  AdSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['news_category_id'];

  }

}
