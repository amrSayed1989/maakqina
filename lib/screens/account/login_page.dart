// ignore_for_file: unused_import, unused_local_variable, dead_code, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maak/screens/account/widgets/footer_widget.dart';
import 'package:maak/screens/account/widgets/name_widget.dart';
import 'package:maak/screens/account/widgets/phone_widget.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/strings.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/widgets/dialog_model.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class LoginPage extends StatefulWidget {
  Function() onLoginComplete;

  LoginPage({Key? key, required this.onLoginComplete}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool agreePolicy = false;
  final _phoneController = TextEditingController();

  final _nameOfUser = TextEditingController();
  // final _otpController = TextEditingController();
  String phone = '';
  var initAppViewModel = Get.find<MainAppViewModel>();
  String smsCode = '';
  bool codeDidSend = false;

  final spinkit = SpinKitSquareCircle(
    color: Colors.white,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: viewModel.signUp ? "حساب جديد" : 'تسجيل الدخول',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: AppColors.greyBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  NameWidget(
                    nameOfUser: _nameOfUser,
                    signUp: viewModel.signUp,
                  ),
                  PhoneWidget(
                    phoneController: _phoneController,
                  ),
                  viewModel.signUp
                      ? Row(
                          children: [
                            Checkbox(
                                value: agreePolicy,
                                onChanged: (value) {
                                  agreePolicy = value!;
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "اوافق على سياسة الاستخدام",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    // decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(16))),
                    height: 55,
                    width: double.infinity,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      color: AppColors.mainOrange,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      child: Text(viewModel.signUp ? "تسجيل" : "دخول",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        println('${viewModel.signUp}');
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return loading;
                          },
                        );
                        if (viewModel.signUp) {
                          if (_phoneController.text.isEmpty ||
                              _nameOfUser.text.isEmpty ||
                              !agreePolicy) {
                            Get.back();
                            Get.defaultDialog(
                              title: 'تنبيه',
                              middleText:
                                  'يرجي إدخال الاسم ورقم الهاتف والموافقة علي سياسة الاستخدام',
                              cancel: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'إغلاق',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            );
                            return;
                          }
                        } else {
                          if (_phoneController.text.isEmpty) {
                            Get.back();
                            Get.defaultDialog(
                              title: 'تنبيه',
                              middleText: 'يرجي إدخال رقم الهاتف',
                              cancel: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'إغلاق',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            );
                            return;
                          }
                        }
                        phone =
                            '${initAppViewModel.countryCode}${int.tryParse(replaceFarsiNumber(_phoneController.text)) ?? 0}';
//                         println('------------phone $phone');
                        if (codeDidSend) {
                          phoneSignIn(phoneNumber: phone);
                        } else {
                          println(
                              '----- initAppViewModel.signUp ${viewModel.signUp}');
                          if (viewModel.signUp) {
                            var resgData = await initAppViewModel.registerPost(
                              phone,
                              _nameOfUser.text,
                            );
                            if (resgData == 'registered') {
                              // Get.back(closeOverlays: true);
                              // Get.back(closeOverlays: true);
                              // widget.onLoginComplete();
                              // initAppViewModel.isLogged = true;
                              // Get.snackbar('مرحبا', 'تم تسجيل الدخول بنجاح',
                              //     colorText: Colors.white,
                              //     backgroundColor: Colors.green,
                              //     messageText: Text(
                              //       'تم تسجيل الدخول بنجاح',
                              //       style: TextStyle(color: Colors.white),
                              //   ));
                            } else {
                              Get.back();
                              alertErrorDialog(
                                'يبدو ان الرقم الذي ادخلته مسجل مسبقا. يرجى تسجيل الدخول بدل تسجيل حساب جديد',
                              );
                            }
                          } else {
                            var userRes =
                                await initAppViewModel.logInPost(phone);
                            if (userRes == 'not') {
                              //Get.back();
                              // alertErrorDialog(
                              //     'تم التسجيل بنجاح برجاء الخروج والدخول مرة اخرى');
                            } else {
                              Get.back();
                              Get.back(closeOverlays: true);
                              widget.onLoginComplete();
                              initAppViewModel.isLogged = true;
                              Get.snackbar('مرحبا', 'تم تسجيل الدخول بنجاح',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green,
                                  messageText: Text(
                                    'تم تسجيل الدخول بنجاح',
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  FooterWidget(
                    onToggleState: () {
                      viewModel.signUp = !viewModel.signUp;
                    },
                    signUp: viewModel.signUp,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    println('========??????? phoneNumber $phoneNumber');

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    smsCode = authCredential.smsCode!;
    println(
        "------------?????>>> verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      // this._otpController.text = authCredential.smsCode!;
    });
    println('------------ authCredential.smsCode ${authCredential.smsCode}');
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      // setState(() {
      //   isLoading = false;
      // });
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.homeNavigate, (route) => false);
    } else {
      println('---------->>. authCredential.smsCode wrong');
      await initAppViewModel.userService.value.removeUser();
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) async {
    println('------------------>>>>>>>>exception.code ${exception.code}');
    if (exception.code == 'invalid-phone-number') {
      await initAppViewModel.userService.value.removeUser();
      Get.back();
      alertErrorDialog("رقم الهاتف الذي ادخلته غير صحيح");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    // this.verificationId = verificationId;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DialogModel(
          buttonLeftText: 'رجوع',
          height: 300,
          buttonLeftOnPress: () async {
            Get.back();
            Navigator.pop(context);
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) {
            //     return loading;
            //   },
            // );
            // await signInWithPhoneNumber(
            //     isLogin: isLogin,
            //     updateNumber: updateNumber,
            //     context: context);
          },
          buttonRightText: 'تأكيد',
          buttonRightOnPress: () async {
            // String _smsCode = sharedData.smsCode;
            if (smsCode.length == 6) {
              AuthCredential auth = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              await onPhoneNumberVerify(
                smsCode: smsCode,
                verificationId: verificationId,
                context: context,
              );
            }
          },
          title: 'أدخل رمز التفعيل',
          content: Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              length: 6,
              keyboardType: TextInputType.number,
              animationType: AnimationType.slide,
              animationDuration: Duration(milliseconds: 225),
              pinTheme: PinTheme(
                fieldHeight: 40,
                fieldWidth: 30,
                selectedColor: Colors.blue,
                inactiveFillColor: Colors.orange,
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5),
                inactiveColor: Colors.orange,
              ),
              onChanged: (value) {
                smsCode = replaceFarsiNumber(value);
              },
              appContext: context,
            ),
          ),
        );
      },
    );

    return;

    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('أدخل رمز التفعيل'),
          actionsPadding: EdgeInsets.all(0),
          content: Directionality(
            textDirection: TextDirection.ltr,
            // child: Container(),
            child: PinCodeTextField(
              length: 6,
              autoFocus: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.slide,
              // controller: _otpController,
              animationDuration: Duration(milliseconds: 225),

              // cursorHeight: 40,
              // cursorWidth: 30,
              // fieldHeight: 40,
              // fieldWidth: 30,
              pinTheme: PinTheme(
                  fieldHeight: 40,
                  shape: PinCodeFieldShape.underline,
                  selectedColor: Colors.blue,
                  inactiveColor: Colors.orange,
                  inactiveFillColor: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                  fieldWidth: 30),

              onChanged: (value) {
                println('-------------------- >>>>. pin value $value');
                smsCode = replaceFarsiNumber(value);
              },
              appContext: context,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  String _smsCode = smsCode;
                  println('-------------------------_smsCode $_smsCode');
                  if (_smsCode.length == 6) {
                    await onPhoneNumberVerify(
                        smsCode: smsCode,
                        context: context,
                        verificationId: verificationId);
                    Get.back();
                  }
                },
                child: Text(
                  'تأكيد',
                  style: TextStyle(color: Colors.white),
                )),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('رجوع', style: TextStyle(color: Colors.white))),
          ],
        );
      },
    );
  }

  _onCodeTimeout(String timeout) async {
    println('------------------>>>>>>>>timeout $timeout');

    // if(widget.onLoginComplete != null) {
    //   widget.onLoginComplete();
    // }
    // await initAppViewModel.userService.value.removeUser();
    println();
    println('--========-->>>>>>> time out');
    println('------- user logged ${initAppViewModel.isLogged}');
    println();
    // Get.back();
    if (!initAppViewModel.isLogged) {
      Get.back();
      alertErrorDialog('حاول مرة ثانية');
    }

    return null;
  }

  onPhoneNumberVerify(
      {required String smsCode,
      BuildContext? context,
      required String verificationId}) async {
    Get.back();
    println('------------->>>>>>>>>>>>>>.AuthCredential');
    AuthCredential auth = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    println('------------->>>>>>>>>>>>>>.onPhoneNumberVerify');
    try {
      await _auth.signInWithCredential(auth).then(
        (result) async {
          println('------------->>>>>>>>>>>>>>.signInWithCredential');
          if (result.user != null) {
            // for (int i = 0; i < _usersData.documents.toList().length; i++) {
            //   if (_usersData.documents[i].documentID == result.user.uid) {
            println('------------->>>>>>>>>>>>>>.result.user != null');

            codeDidSend = true;
            if (initAppViewModel.signUp) {
              var resgData = await initAppViewModel.registerPost(
                phone,
                _nameOfUser.text,
              );
              if (resgData == 'registered') {
                Get.back(closeOverlays: true);
                Get.back(closeOverlays: true);
                widget.onLoginComplete();
                initAppViewModel.isLogged = true;
                Get.snackbar('مرحبا', 'تم تسجيل الدخول بنجاح',
                    colorText: Colors.white,
                    backgroundColor: Colors.green,
                    messageText: Text(
                      'تم تسجيل الدخول بنجاح',
                      style: TextStyle(color: Colors.white),
                    ));
              } else {
                Get.back();
                alertErrorDialog(
                  'يبدو ان الرقم الذي ادخلته مسجل مسبقا. يرجى تسجيل الدخول بدل تسجيل حساب جديد',
                );
              }
            } else {
              var userRes = await initAppViewModel.logInPost(phone);
              if (userRes == 'not') {
                Get.back();
                alertErrorDialog('ليس لديك حساب في معاك، يجب انشاء حساب اولا');
              } else {
                Get.back(closeOverlays: true);
                Get.back(closeOverlays: true);
                widget.onLoginComplete();
                initAppViewModel.isLogged = true;
                Get.snackbar('مرحبا', 'تم تسجيل الدخول بنجاح',
                    colorText: Colors.white,
                    backgroundColor: Colors.green,
                    messageText: Text(
                      'تم تسجيل الدخول بنجاح',
                      style: TextStyle(color: Colors.white),
                    ));
              }
            }
          } else {
            println('------------->>>>>>>>>>>>>>.result.user == null');
            Get.back();
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context!,
                barrierDismissible: false,
                builder: (context) {
                  return AlertModel(
                      onPressed: () {
                        Get.back();
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      title: 'هناك خطأ ما',
                      text:
                          'يبدو ان رمز التححق او رقم الهاثف الدي ادخلته غير صحيح');
                },
              );
            });
          }
        },
      );
    } catch (e) {
      println('----- exception ${e.toString()}');
      Get.back();
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (context) {
            return AlertModel(
                onPressed: () {
                  Get.back();
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                },
                title: 'هناك خطأ ما',
                text: 'يبدو ان رمز التححق او رقم الهاثف الدي ادخلته غير صحيح');
          },
        );
      });
    }
  }

  Widget loading = SpinKitWave(
    color: Colors.deepOrange,
    size: 20,
  );
}
