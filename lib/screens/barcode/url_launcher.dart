// import 'package:flutter/material.dart';
// import 'package:maak/models/slider_item.dart';
// import 'package:maak/screens/account/widgets/global_widget.dart';

// import 'package:maak/utils/consts/urls.dart';
// import 'package:url_launcher/url_launcher.dart';

// class UrlLauncher1Page extends StatefulWidget {
//   @override
//   _UrlLauncher1PageState createState() => _UrlLauncher1PageState();
// }

// class _UrlLauncher1PageState extends State<UrlLauncher1Page> {
//   List<SliderItem>? data;
//   // initialize global widget
//   final _globalWidget = GlobalWidget();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(new SliderItem.fromJson(v));
//       });
//     }
//   }

//   getHomeSlider(Map<String, String> params, onDone) async {
//     var queryParameters = '?';

//     params.forEach((key, value) {
//       queryParameters += '$key=$value&';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _globalWidget.globalAppBar(),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 8),
//               child: _globalWidget.createButton(
//                   buttonName: 'التجربة الثالثة',
//                   onPressed: () {
//                     //[For Test Other Site]
//                     _launchInWebViewWithJavaScript(
//                         '${AppUrl.slideImagesInHome}/${'queryParameters'}' +
//                             'https://m3akm3ak.com/api/v1/mainpageimages/?city_id=27&show_in_main_page=1&');
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // javascript function will not work
//   // Future<void> _launchInWebViewWithJavaScript(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(
//   //       url,
//   //       forceSafariVC: true,
//   //       forceWebView: true,
//   //       headers: <String, String>{'my_header_key': 'my_header_value'},
//   //     );
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }

//   // javascript function will work
//   Future<void> _launchInWebViewWithJavaScript(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: true,
//         forceWebView: true,
//         enableJavaScript: true,
//       );
//     } else {
//       throw 'يوجد خطاء يا عم عمرو $url';
//     }
//   }
// }
