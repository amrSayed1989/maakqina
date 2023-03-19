import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../models/specialization.dart';

showSpecializationBottomSheet(context,
    {required title,
    required List<Specialization> data,
    required onItemSelected}) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(
      title: title,
      onItemSelected: onItemSelected,
      data: data,
    ),
  );
}

class _MyBottomSheet extends StatefulWidget {
  final title;
  final List<Specialization> data;
  final onItemSelected;
  _MyBottomSheet(
      {Key? key,
      required this.title,
      required this.data,
      required this.onItemSelected})
      : super(key: key);

  @override
  State<_MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<_MyBottomSheet> {
  @override
  void initState() {
    super.initState();
    for (var s in widget.data) {
      s.selected = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Container(
          width: double.infinity,
          height: 50,
          color: AppColors.mainOrange,
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
              InkWell(
                onTap: () {
                  // solidController.hide();
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              // height: 30,
              child: widget.data.length != 0
                  ? ListView.separated(
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        Specialization e = widget.data[index];
                        if (widget.data.length == 0) {
                          return Container(
                              height: 300,
                              child: Center(
                                child: Text('لا توجد نتائج مطابقة للبحث '),
                              ));
                        }
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Text(e.name ?? '',
                                  // textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                              decoration: BoxDecoration(
                                  // color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.5)
                                  ),
                            ),
                            Spacer(),
                            Checkbox(
                                value: e.selected,
                                onChanged: (value) {
                                  e.selected = value!;
                                  if (e.id == -1 && e.selected) {
                                    for (var s in widget.data) {
                                      s.selected = true;
                                    }
                                  } else {
                                    widget.data[0].selected = false;
                                  }
                                  setState(() {});
                                }),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )
                  : Center(
                      child: Text(
                        'لا يوجد بيانات',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    widget.onItemSelected();
                    Get.back();
                  },
                  child: Text(
                    'بحث',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
