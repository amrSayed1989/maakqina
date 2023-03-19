// ignore_for_file: unused_import

import 'package:maak/utils/consts/urls.dart';

import 'custom_properities.dart';

class Photo {
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
  String _url = '';
  String? thumbnail;
  String? preview;

  Photo.fromJson(Map<String, dynamic> json) {
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

  String get photoUrl {
    return _url;
  }
}
