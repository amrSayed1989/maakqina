

import 'generated_conversion.dart';

class CustomProperties {
  GeneratedConversions? generatedConversions;

  CustomProperties({this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
  }

}