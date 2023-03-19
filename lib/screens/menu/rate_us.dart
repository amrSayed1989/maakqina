import 'package:flutter/material.dart';
import 'package:maak/screens/menu/rate/padding.dart';
import 'package:maak/screens/menu/rate/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUs extends StatelessWidget {
  const RateUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            Image.asset('assets/images/2.jpg'),
            SizedBox(
              height: size.height * .07,
            ),
            RTextB5('حقاً إنه تطبيق رائع نتمني تطويره'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  5,
                  (i) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: size.width * .1,
                      )),
            ),
            DPadding(
                child:
                    BTextB4('ادعمنا وشجعنا علي المزيد من التطوير في التطبيق')),
            DPadding(child: BTextB4(' وقم بتقييم التطبيق علي المتجر  ')),
            DPadding(
                child:
                    BTextB4(' فإن ذلك يرفع من معنواياتنا لتقديم المزيد إليكم')),
            SizedBox(
              height: size.width * .06,
            ),
            GestureDetector(
                onTap: () {
                  launch('https://onelink.to/9dm7hk');
                },
                child: Image.asset('assets/images/play.png')),
            SizedBox(
              height: size.width * .06,
            ),
            DPadding(child: BTextB5('إضغط علي المتجر ثم قيمنا من عليه')),
          ],
        ),
      ),
    );
  }
}
