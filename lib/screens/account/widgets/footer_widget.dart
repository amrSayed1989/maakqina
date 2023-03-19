import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {

  final Function ()onToggleState;
  final bool signUp;

  const FooterWidget({Key? key,required this.onToggleState,required this.signUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          signUp
              ? "لديك حساب لدى معاك؟"
              : "ليس لديك حساب ؟",

          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5,),
        InkWell(
          onTap: onToggleState,
          child: Text(
            signUp ? "تسجيل الدخول" : "حساب جديد",

            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 18,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

      ],
    );
  }
}
