import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {

  final bool signUp;
  final TextEditingController nameOfUser;

  const NameWidget({Key? key,required this.signUp,required this.nameOfUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return signUp ? Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        height: 55,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(8)),
                borderSide:
                BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(8)),
                borderSide:
                BorderSide(color: Colors.grey)),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: "ادخل اسمك",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          controller: nameOfUser,
        ),
      ),
    ) : SizedBox();
  }
}
