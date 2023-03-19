import 'dart:io';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:url_launcher/url_launcher.dart';

void launchWhatsApp({
   required String phone,
   required String message,
}) async {
  String url() {
    if (Platform.isIOS) {
      return "https://wa.me/$phone/?text=$message";
      // return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      return "whatsapp://send?phone=$phone&text=$message";
    }
  }

  try{
    await launch(Uri.encodeFull(url()));
  }catch(e){
    println('---->>>> exp $e');
  }

  // if (await canLaunch(url())) {
  // //   await launch(Uri.encodeFull(url()));
  // } else {
  //   throw 'Could not launch ${url()}';
  // }
}


void launchWhatsAppForFile({
  required String phone,
  required String message,
}) async {
  String url() {
    if (Platform.isIOS) {
      return "https://wa.me/$phone/?file=$message";
      // return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      return "whatsapp://send?phone=$phone&file=$message";
    }
  }

  // if (await canLaunch(url())) {
  await launch(Uri.encodeFull(url()));
  // } else {
  //   throw 'Could not launch ${url()}';
  // }
}

void launchPhoneCall(String phoneNumber){
  launch(
      ('tel://$phoneNumber'));
}

Future<bool> launchUrl(String url) async {
  println('------------ ??? $url');

  try{
    await launch(url);
    return true;
  }catch(e){
    return false;
  }



}

launchEmailApp({required String toMailId, required String subject, required String body}) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}