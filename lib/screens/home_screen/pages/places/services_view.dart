// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/services.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../utils/consts/print_utils.dart';

showServicesBottomSheet(context,
    {required String type, required onItemSelected}) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => _MyBottomSheet(
      onItemSelected: onItemSelected,
      type: type,
    ),
  );
}

class _MyBottomSheet extends StatefulWidget {
  String type;
  final onItemSelected;
  _MyBottomSheet({Key? key, required this.type, required this.onItemSelected})
      : super(key: key);

  @override
  State<_MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<_MyBottomSheet> {
  bool _isLoading = true;

  Services? _services;
  Service? service;
  @override
  void initState() {
    _services = Services();
    _services!.type = widget.type;
    super.initState();
    _services!.retrieveServices(() {
      _isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            // solidController.hide();

            widget.onItemSelected(null);
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        title: Container(
          width: double.infinity,
          height: 50,
          color: AppColors.mainOrange,
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                widget.type == 'service' ? 'الخدمي' : 'التجاري',
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
            child: _isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : Container(
                    color: Colors.white,
                    child: _services!.data.length != 0
                        ? ListView.separated(
                            itemCount: _services!.data.length,
                            itemBuilder: (context, index) {
                              if (_services!.data.length == 0) {
                                return Container(
                                    height: 300,
                                    child: Center(
                                      child:
                                          Text('لا توجد نتائج مطابقة للبحث '),
                                    ));
                              }

                              return ExpansionTile(
                                title: InkWell(
                                  onTap: index == 0
                                      ? () {
                                          service = Service(
                                              id: -2,
                                              name: widget.type == 'service'
                                                  ? 'الأماكن الخدمية'
                                                  : 'الأماكن التجارية');
                                          for (var ser in _services!.data) {
                                            for (var sub in ser.subCategories) {
                                              sub.selected = true;
                                              service!.subCategories.add(sub);
                                            }
                                          }
                                          widget.onItemSelected(service);
                                          Get.back();
                                        }
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              _services!.data[index].name ?? '',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: index == 0 ? SizedBox() : null,
                                children: _services!.data[index].subCategories
                                    .map((e) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 50),
                                    child: Row(
                                      children: [
                                        Text(e.name ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        Spacer(),
                                        Checkbox(
                                            value: e.selected,
                                            onChanged: (value) {
                                              e.selected = value!;
                                              service = _services!.data[index];

                                              if (e.id == -1 && e.selected) {
                                                for (var sub in _services!
                                                    .data[index]
                                                    .subCategories) {
                                                  sub.selected = true;
                                                }
                                              } else {
                                                for (var sub in _services!
                                                    .data[index]
                                                    .subCategories) {
                                                  if (sub.id == -1) {
                                                    sub.selected = false;
                                                  }
                                                }
                                              }

                                              for (var main
                                                  in _services!.data) {
                                                if (main.id !=
                                                    _services!.data[index].id) {
                                                  println(main.name);

                                                  for (var sub
                                                      in main.subCategories) {
                                                    sub.selected = false;
                                                  }
                                                }
                                              }

                                              setState(() {});
                                            }),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Container(
                                color: Colors.grey.withOpacity(0.5),
                                width: double.infinity,
                                height: 0.5,
                              ),
                            ),
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
                    // widget.viewModel.HigherPrice = highestPriceCtl.text;
                    // widget.viewModel.LowerPrice = lowestPriceCtl.text;

                    println(service?.name);

                    for (var sub in service!.subCategories) {
                      if (sub.selected) {
                        println(sub.name);
                      }
                    }

                    widget.onItemSelected(service);
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

  @override
  void dispose() {
    _services!.type = null;
    _services!.data.clear();
    _services = null;
    super.dispose();
  }
}
