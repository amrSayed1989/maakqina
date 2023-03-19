// ignore_for_file: unused_import, unused_local_variable

import 'package:maak/models/city.dart';
import 'package:maak/models/color.dart';
import 'package:maak/models/image.dart';
import 'package:maak/models/media.dart';
import 'package:maak/models/offer.dart';
import 'package:maak/models/product.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class TraderService {
  Data? data;

  TraderService({this.data});

  fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  getPlaces(int traderId, onDone) async {
    AppApiHandler.getData(
        url: '${AppUrl.traders}/$traderId',
        body: null,
        callback: (json) {
          println(json);
          this.fromJson(json);
          onDone();
        });
  }
}

class Data {
  int? id;
  String? type;
  String? name;
  String? address;
  int? cityId;
  String? phoneNumber;
  String? activeness;
  String? details;
  dynamic facebookUrl;
  String? whatsapp;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<AppImage>? images;
  String? typeOfTrader;
  List<MainCategories> mainCategories = [];
  List<SubCategories> subCategories = [];
  List<Product>? products;
  List<Offer>? offers;
  List<Media>? media;
  List<Departments>? departments;

  // Data(
  //     {this.id,
  //       this.type,
  //       this.name,
  //       this.address,
  //       this.cityId,
  //       this.phoneNumber,
  //       this.activeness,
  //       this.details,
  //       this.facebookUrl,
  //       this.whatsapp,
  //       this.createdAt,
  //       this.updatedAt,
  //       this.deletedAt,
  //       this.images,
  //       this.typeOfTrader,
  //
  //       this.products,
  //       this.offers,
  //       this.media,
  //       this.departments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    address = json['address'];
    cityId = json['city_id'];
    phoneNumber = json['phone_number'];
    activeness = json['activeness'];
    details = json['details'];
    facebookUrl = json['facebook_url'];
    whatsapp = json['whatsapp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['images'] != null) {
      images = <AppImage>[];
      json['images'].forEach((v) {
        images!.add(new AppImage.fromJson(v));
      });
    }
    typeOfTrader = json['type_of_trader'];
    if (json['main_cats'] != null) {
      json['main_cats'].forEach((v) {
        if (v != null) {
          var mainCat = new MainCategories.fromJson(v);
          if (v['type'] == null) {
            mainCategories.add(mainCat);
          }
        }
      });
    }
    if (json['sub_cats'] != null) {
      json['sub_cats'].forEach((v) {
        if (v != null) {
          subCategories.add(new SubCategories.fromJson(v));
        }
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      int count = 0;
      // json['products'].forEach((v) {
      //   println('=========== count ${count++}');
      //   products!.add(new Product.fromJson(v));
      // });
    }
    if (json['offers'] != null) {
      offers = <Offer>[];
      // json['offers'].forEach((v) {
      //   offers!.add(new Offer.fromJson(v));
      // });
    }
    if (json['media'] != null) {
      // media = <Media>[];
      // json['media'].forEach((v) {
      //   media!.add(new Media.fromJson(v));
      // });
    }
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
  }
}

class CustomProperties {
  GeneratedConversions? generatedConversions;

  CustomProperties({this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
  }
}

class GeneratedConversions {
  bool? thumb;
  bool? preview;

  GeneratedConversions({this.thumb, this.preview});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    preview = json['preview'];
  }
}

class MainCategories {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<SubCategories> subCategories = [];

  MainCategories({this.id, this.name, this.createdAt, this.updatedAt});

  MainCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class SubCategories {
  int? id;
  String? name;
  int? mainProductTypeId;
  String? createdAt;
  String? updatedAt;
  int? mainProductServiceTypeId;

  SubCategories(
      {this.id,
      this.name,
      this.mainProductTypeId,
      this.mainProductServiceTypeId,
      this.createdAt,
      this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainProductTypeId = json['main_product_type_id'];
    mainProductServiceTypeId = json['main_product_service_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Variants {
  int? id;
  String? price;
  int? sizeId;
  int? colorId;
  int? count;
  int? isAvailable;
  List<AppImage>? images;
  String? colorName;
  String? sizeName;
  Pivot? pivot;
  AppColor? color;
  AppColor? size;
  List<Media>? media;

  Variants(
      {this.id,
      this.price,
      this.sizeId,
      this.colorId,
      this.count,
      this.isAvailable,
      this.images,
      this.colorName,
      this.sizeName,
      this.pivot,
      this.color,
      this.size,
      this.media});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    sizeId = json['size_id'];
    colorId = json['color_id'];
    count = json['count'];
    isAvailable = json['is_available'];
    if (json['images'] != null) {
      images = <AppImage>[];
      json['images'].forEach((v) {
        images!.add(new AppImage.fromJson(v));
      });
    }
    colorName = json['color_name'];
    sizeName = json['size_name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    color = json['color'] != null ? new AppColor.fromJson(json['color']) : null;
    size = json['size'] != null ? new AppColor.fromJson(json['size']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }
}

class Pivot {
  int? productId;
  int? variantId;

  Pivot({this.productId, this.variantId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantId = json['variant_id'];
  }
}

class Brand {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Brand({this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}

class MainProductServiceType {
  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  MainProductServiceType({this.id, this.name, this.createdAt, this.updatedAt});

  MainProductServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class SubProductServiceType {
  int? id;
  String? name;
  int? mainProductServiceTypeId;
  dynamic createdAt;
  dynamic updatedAt;

  SubProductServiceType(
      {this.id,
      this.name,
      this.mainProductServiceTypeId,
      this.createdAt,
      this.updatedAt});

  SubProductServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainProductServiceTypeId = json['main_product_service_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Category {
  int? id;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Category(
      {this.id,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}

class Departments {
  int? id;
  String? name;
  int? showInMainPage;
  int? showInMainDepartmentsPage;
  String? about;
  String? phoneNumber;
  int? itemNumber;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? cityId;
  int? traderId;
  int? categoryId;
  int? subCategoryId;
  int? ordered;
  AppImage? logo;
  String? typeOfCategory;
  Category? category;
  SubCategory? subCategory;
  List<Media>? media;

  Departments(
      {this.id,
      this.name,
      this.showInMainPage,
      this.showInMainDepartmentsPage,
      this.about,
      this.phoneNumber,
      this.itemNumber,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.cityId,
      this.traderId,
      this.categoryId,
      this.subCategoryId,
      this.ordered,
      this.logo,
      this.typeOfCategory,
      this.category,
      this.subCategory,
      this.media});

  Departments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    showInMainPage = json['show_in_main_page'];
    showInMainDepartmentsPage = json['show_in_main_departments_page'];
    about = json['about'];
    phoneNumber = json['phone_number'];
    itemNumber = json['item_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    cityId = json['city_id'];
    traderId = json['trader_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    ordered = json['ordered'];
    logo = json['logo'] != null ? new AppImage.fromJson(json['logo']) : null;
    typeOfCategory = json['type_of_category'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }
}

class SubCategory {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Category? category;

  SubCategory(
      {this.id,
      this.name,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.category});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }
}
