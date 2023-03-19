
import 'package:maak/utils/consts/print_utils.dart';

class Cv {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? url;
  String? thumbnail;
  String? preview;

  Cv(
      {this.id,
        this.modelType,
        this.modelId,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.size,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.url,
        this.thumbnail,
        this.preview});

  Cv.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
     println('$key: $value');
    });
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];



    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

}