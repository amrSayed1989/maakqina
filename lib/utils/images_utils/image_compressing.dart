import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:path_provider/path_provider.dart';


 Future<File?> compressImage(File file) async {

   Directory tempDir = await getTemporaryDirectory();
   String tempPath = tempDir.path;
   println('====>>> file name ${file.path.split('/').last}');
   var result = await FlutterImageCompress.compressAndGetFile(
     file.absolute.path, '$tempPath/${file.path.split('/').last}',
     quality: 25,
   );

   print(file.lengthSync());
   print(result?.lengthSync());

   return result;
 }