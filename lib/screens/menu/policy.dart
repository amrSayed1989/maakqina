// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';

class PrivacyPolicy extends StatelessWidget {
  String test = """ 
                                                     عزيزنا مستخدم  تطبيق معاك
1- جميع المعلومات الموضحة فى تعريف اصحاب الاماكن التجارية او الخدمية نقوم بنقلها اليك لتسهيل عليك البحث او الوصول اليها وتحديثها يتم من قبل اصحاب الانشطة التجارية والخدمية وغير مسؤلين اذا وجد اختلاف بين مواعيد او عنواين الاماكن او ارقام التواصل المعلن عنها  فى التطبيق 
2- التطبيق غير مسؤل عن اتمام النهائى  لعملية الشراء من اصحاب السلع التجارية او الخدمية  مثل معاد االوصول او تاخيرها او طريقة السداد اوحالتها  او كيفية الارتجاع 
3- التطبيق غير مسؤل عن اتمام عملية بيع سلعة من قبل المستخدمين فى قسم الاعلانات  او اى خلافات تجرى بين عارض السلعة وشاريها
4- التطبيق غير مسؤل عن صحة السيرة الذاتية عن الافراد المعلنة لسيرتهم الذاتية 
5- التطبيق غير مسؤل عن تنفيذ العروض المعلن عنها من قبل اصحاب الاماكن والخدمات فى قسم العروض  فى حين الغاء العرض او فترتة من قبلهم 
                                                                عزيزى مستخدم التطبيق معاك
فى حين وجود  اى شكوى  سواء فى سياسة وصول السلع او الخدمة معينة من قبل اصحاب الانشطة التجارية  يرجى الارسال لادارة التطبيق لاخذ اجراء الغاء التعامل او الغاء الصنف المعلن عنة من صاحب السلعة او الخدمة 
حذر العروض الغير صحيحة فى تنفيذها بعد الاعلان عنها لاصحاب الانشطة 
حذر الوظائف المعلن عنها من قبل اصحاب الانشطة اذا وجد شكاوى من المستخدمين 

""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'سياسة الاستخدام',
      ),
      body: ListView(
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
    );
  }
}
