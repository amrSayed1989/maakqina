import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';

import 'custom_properities.dart';

class AppImage {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  CustomProperties? customProperties;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? _url;
  String? thumbnail;
  String? preview;

  AppImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];

    customProperties = json['custom_properties'] != null
        ? new CustomProperties.fromJson(json['custom_properties'])
        : null;

    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    _url = json['url'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  String get imageUrl{

    // println('------------------------->>> firstImage url');
    println(_url);
    var url = _url ?? '';
    if(url.contains(mainUrl))
       return url;
    return '$mainUrl/$url';
  }
}