class HomeSliderImage{
  int? _id;
  String? _name;

  HomeSliderImage.of(int id,String name){
    this._id = id;
    this._name = name;
  }

  int get id{
    return _id ?? 0;
  }

  String get name{
    return _name ?? '';
  }
}