import 'package:flutter/material.dart';
import 'package:maak/models/init_page.dart';
import 'package:maak/utils/consts/print_utils.dart';

class InitPageScreenViewModel extends ChangeNotifier {
  bool _screensDone = false;
  List<InitPage> screens = [];

  InitPageScreenViewModel() {
    screens.add(InitPage(
      desc:
          'بتبحث عن اي نشاط تجاري أو خدمي ومش عارف توصل، دلوقتي تقدر توصل بأسرع وقت وما تسألش حد، اسأل معاك',
      image: 'assets/images/init_page/1.png',
      subTitle: 'الأماكن',
      title: 'بلدك بين إيديك',
    ));
    screens.add(InitPage(
      desc:
          'مستني عروض المحلات والتخفيضات ومش عارف متي، والعرض بيضيع عليك. دلوقتي العروض هتوصلك لغاية عندك، خليك معاك',
      image: 'assets/images/init_page/2.png',
      subTitle: 'العروض والتخفيضات',
      title: '',
    ));
    screens.add(InitPage(
      desc:
          'عايز تعلن عن خبر او عرض معين عشان يظهر للمهتمين بالإعلان، مستني ايه \n اعلن مع معاك',
      image: 'assets/images/init_page/3.png',
      subTitle: 'الاعلانات',
      title: '',
    ));
    screens.add(InitPage(
      desc:
          'بتبحث عن وظيفة أو عايز تعلن عن وظيفة معاك يوظفك ويوفر ليك الاشخاص المناسبين للعمل',
      image: 'assets/images/init_page/4.png',
      subTitle: 'وظائف',
      title: '',
    ));
    screens.add(InitPage(
      desc:
          'ما تلفش كثيىر عشان تقارن بين الاسعار وتختار افضل المنتجات مع معاك اتسوق وابحث واختار اجمل وافضل المنتجات وخد قرار واشترى صح',
      image: 'assets/images/init_page/4.png',
      subTitle: 'التسوق',
      title: '',
    ));
  }

  setScreensDone() {
    println('------------------- screensDone $_screensDone');
    _screensDone = true;
    println('------------------- screensDone $_screensDone');
    notifyListeners();
    // TutorialHighlighterPage();
  }

  bool get screensDone {
    return _screensDone;
  }
}
