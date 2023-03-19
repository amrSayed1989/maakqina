import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maak/utils/consts/app_colors.dart';

class BottomNavigationWidget extends StatelessWidget {

  final int currentPage;
  final Function (int)onClick;

  const BottomNavigationWidget(this.currentPage,this.onClick,{Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            backgroundColor: Colors.black,
            activeIcon: Icon(Icons.home,color: AppColors.mainOrange,),
            label: 'الرئيسية'.tr(),
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.location_pin),
              backgroundColor: Colors.black,
              activeIcon: Icon(Icons.location_pin,color: AppColors.mainOrange,),
              label: 'الاماكن'.tr()),
          BottomNavigationBarItem(
              icon:Icon(Icons.shopping_cart),
              backgroundColor: Colors.black,
              activeIcon: Icon(Icons.shopping_cart,color: AppColors.mainOrange,),
              label: 'التسوق'.tr()),
          BottomNavigationBarItem(
            icon:Image.asset('assets/images/offerIcon1.png',color: Colors.white,height: 25,),
            backgroundColor: Colors.black,
            activeIcon: Image.asset('assets/images/offerIcon1.png',color: AppColors.mainOrange,height: 25,),
            label: 'العروض'.tr(),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.work_outlined),
            backgroundColor: Colors.black,
            activeIcon: Icon(Icons.work_outlined,color: AppColors.mainOrange,),
            label: 'الوظائف'.tr(),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.campaign),
            backgroundColor: Colors.black,
            activeIcon: Icon(Icons.campaign,color: AppColors.mainOrange,),
            label: 'الاعلانات'.tr(),
            // title: Text('الاعلانات'.tr(),style: TextStyle(fontSize: 16),)
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: AppColors.mainOrange,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        elevation: 50,
        onTap: onClick,
      ),
    );
  }
}
