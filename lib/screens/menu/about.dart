// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutTheApp extends StatelessWidget {
  String test = """
تطبيق معاك      
مين معاك 
معاك دايما معاك 
معاك فى اى مكان 
معاك فى كل لحظة بدوسة واحدة هاتعرف كل الى حاوليك واى شء بتبحث عنة تقدر توصلة بسهولة وتطلب كمان الى انتا عايزة سواء اكل او شرب او لبس او اى سلعة اخرى او خدمات معينة
لكى نسهل الربط بين اصحاب الانشطة التجارية والخدمية وحضرتك مستخدم التطبيق   
                             اقسام التطبيق                                                          
                            قسم الاماكن   
-دليل خاص باماكن الانشطة التجارية والخدمية بالمدينة واى تفاصيل اخرى عن النشاط وارقام التواصل والعنوان واية الخدمات الى بيقدمها سواء تجارى او خدمى 
مشاهدة السلع الى بيقدمها او الخدمة وانواعها واسعارها وتفاصيلها وامكانية طلب شراء السلعة او الخدمة اونلاين
لكى نسهل عرض السلع الخاصة بالتاجر وامكانة مشاهدة الاصناف فى اى وقت والبحث واخيار ما تريد قبل الشراء - 
مشاهدة العروض الخاصة بالتاجر او صاحب الخدمة 
                             قسام العروض     
متابعة ومشاهدة العروض من كل التجار او اصحاب الخدمات  مصنفة حسب نوع النشاط سواء تجارى او خدمى
مثل عروض كل المطاعم او الملابس او اى تصنيف اخر سواء تجارى او خدمى 
                             قسم الوظائف
هدفنا سهولة الاعلان عن الوظائف من اصحاب المشاريع التجارية والخدمية وسهولة وصول الاعلان عن الباحث عن وظيفة 
وايضا خدمة طلب وظيفة التى تتيح للمستخدم بعرض السيرة الذاتية الخاصة بة فى التطبيق للباحثين عن تعين افراد او اختيار مجلات محددة من الانشطة 
                                قسم الاعلانات 
قسم خدمى خاصة بالمستخدمين الافراد وليس اصحاب الانشطة التجارية والخدمية  بالاعلان عن اى سلعة او خدمة يريد عرضها للمستخدمين التطبيق 
وايضا يوجد اعلانات من قبل ادارة التطبيق خاصة بلاخبار والاعلانات عن المدينة  سواء خدمية او تجارية 
او اى امر يخص اهل المدينة بالتنوية عنة 
                              قسم الرئيسة    
بنعرف المستخدم باخر المشاريع او المجالات التى تفتح فى المدينة
وعروض خاصة من قبل اصحاب المشاريع التجارية والخدمية
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'عن التطبيق',
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        test,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                // const url = 'https://mjacksi.com';
                // if (await canLaunch(url)) {
                //   await launch(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey.shade800,
                  height: 60,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                    child: InkWell(
                      onTap: () {
                        launchUrl('https://www.facebook.com/bramj.bramj.7');
                      },
                      child: Center(
                        child: RichText(
                          text: new TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Powered by  ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: 'Bramj ',
                                style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
