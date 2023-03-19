import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final isLoading;
  CustomAppBar({Key? key, required this.title, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isLoading
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: LoadingWidget(
                    color: Colors.white,
                  ),
                )
              : Text(title),
        ],
      ),
      centerTitle: true,
      leading: Container(),
      actions: [
        // Text(viewModel.placeService.data?.name ?? ""),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
