// ignore_for_file: unnecessary_import, unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/strings.dart';
import 'package:maak/utils/widgets/dialog_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final storage = new FlutterSecureStorage();

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String> getToken() async {
    return await storage.read(key: "token") ?? '';
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (String verificationID, int? forceResnedingtoken) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (builder) => HomePage()),
      //         (route) => false);

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future signInWithPhoneNumber(
      {required bool isLogin,
      required String phoneNumber,
      required bool updateNumber,
      required Function(String) onCodeSent,
      required BuildContext context}) async {
    // SharedData sharedData = Provider.of<SharedData>(context, listen: false);
    // String _countryCode = sharedData.countryCode;
    // String _phoneCode = sharedData.phoneNumber;
    String smsCode = '';
    String _phoneNumber = phoneNumber;
    final PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) async {
      onCodeSent(verificationId);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {};

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) async {
      print(
          '++++++++++++++++++++  verification ++++++++++++++++++++ Completed ++++++++++++++++++++');
      await onPhoneNumberVerify(
        auth: auth,
        context: context,
      );
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('>>>>>>>>>>>>>' + authException.toString());
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertModel(
              onPressed: () {
                Get.back(closeOverlays: true);
                Get.back(closeOverlays: true);
              },
              title: 'هناك خطأ ما',
              text: 'تحقق من الرقم الدي ادخله ان كان صالحا او خارج الخدمة');
        },
      );
    };

    try {
      print('this is his phone  >>>>>>>>>>>> ' + _phoneNumber);
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumber,
          timeout: Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      return true;
    } catch (e) {
      print(
          '---------------------------------------------------there is an error-------------------------------------------');
      print(e);
      return false;
    }
  }

  onPhoneNumberVerify(
      {required AuthCredential auth, BuildContext? context}) async {
    bool _isRegister = false;

    await _auth.signInWithCredential(auth).then(
      (result) async {
        Get.back();
        if (result.user != null) {
          println('phone veified ----------->>>>>>>>>>>>>>>>>> ');
        } else {
          showDialog(
            context: context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertModel(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  title: 'هناك خطأ ما',
                  text:
                      'يبدو ان رمز التححق او رقم الهاثف الدي ادخلته غير صحيح');
            },
          );
        }
      },
    );
  }

  Widget loading = SpinKitWave(
    color: Colors.deepOrange,
    size: 20,
  );
}
