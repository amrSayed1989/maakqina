import 'package:flutter/material.dart';
import 'package:maak/model_services/trader_service.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/widgets/app_carosel.dart';

import '../../../../../utils/consts/app_colors.dart';

class TraderAboutTab extends StatefulWidget {

  final Data data;

   TraderAboutTab({Key? key,required this.data}) : super(key: key);

  @override
  State<TraderAboutTab> createState() => _TraderAboutTabState();
}

class _TraderAboutTabState extends State<TraderAboutTab> {
  var activity = true;

  var address = false;

  var phoneNumber = false;

  var details = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  AppCarousel(images: widget.data.images!,),
                  SizedBox(height: 2,),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('النشاط : ',style: TextStyle(
                              color: AppColors.mainOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child:Text("${widget.data.activeness ?? ''}",style: TextStyle(
                                // color: AppColors.mainOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              details = !details;
                              setState(() {

                              });
                            },
                            child: Row(
                              children: [
                                Text('تفاصيل أخرى : ',style: TextStyle(
                                    color: AppColors.mainOrange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18
                                ),),
                                Spacer(),
                                InkWell(
                                  onTap: (){
                                    details = !details;
                                    setState(() {

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(details? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_left,size: 20,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child:details ? Text("${widget.data.details ?? ''}",style: TextStyle(
                                // color: AppColors.mainOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                            ) : SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('العنوان : ',style: TextStyle(
                              color: AppColors.mainOrange,
                              fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child:Text("${widget.data.address ?? ''}",
                              style: TextStyle(
                                  // color: AppColors.mainOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                      child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('رقم الهاتف : ',style: TextStyle(
                                  color: AppColors.mainOrange,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18
                              ),),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child:Text("${widget.data.phoneNumber ?? ''}",style: TextStyle(
                                    // color: AppColors.mainOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        Container(
            width: double.infinity,
            // height: 65,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: GestureDetector(
                    child: Container(
                        color: Colors.green,
                        child:Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/images/whatsapp.png',height: 35,color:Colors.white ,),
                        )),
                    onTap: () async {
                      launchWhatsApp(phone: widget.data.whatsapp ?? '', message: 'مرحبا، اريد مساعدتكم!');
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                        color: AppColors.mainOrange,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.location_on_outlined,size: 35,color: Colors.white,),
                        )),
                    onTap: () async {
                      launchUrl(widget.data.facebookUrl);
                      // launch(('tel://${snapshot.data[0][6]}'));
                    },
                  ),
                ),


              ],)
        ),
      ],
    );
  }
}
