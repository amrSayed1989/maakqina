
class GeneratedConversions {
  bool? thumb;
  bool? preview;

  GeneratedConversions({this.thumb, this.preview});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    preview = json['preview'];
  }

}