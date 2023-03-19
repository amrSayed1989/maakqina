import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {

  final String name, hint;
  final double height;
  final Function(String) onSaved;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;

  MyTextFormField({
    Key? key,
    required this.name,
    required this.hint,
    required this.height,
    required this.onSaved,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 24.0),
          //   child: Text(
          //     name,
          //     textAlign: TextAlign.end,
          //     style: TextStyle(
          //         fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              height: height,
              child: TextFormField(
                keyboardType: keyboardType,
                controller: controller,
                maxLines: maxLines,
                onChanged: onSaved,
                decoration: InputDecoration(
                  hintText: hint,
                  labelText: name,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
