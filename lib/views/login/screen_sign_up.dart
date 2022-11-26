import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/login_mv.dart';


class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SginUpScreenState();
}

class _SginUpScreenState extends State<SignUpScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final LoginModelView loginModelView = Get.find<LoginModelView>();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final firstNameFocus = FocusNode();



  void showMessage({required String feildName}) {
    if (feildName == 'first name') {
      firstNameFocus.requestFocus();
    } else if (feildName == 'last name') {
      lastNameFocus.requestFocus();
    } else if (feildName == 'email') {
      emailFocus.requestFocus();
    } else {
      // password
      passwordFocus.requestFocus();
    }
    String errorMessage = '$feildName are empty';
    Widget flashWidget = Text(
      errorMessage,
      style: TextStyle(color: Colors.white),
    );
    context.showFlashBar(
        content: flashWidget,
        borderRadius: BorderRadius.circular(10),
        margin: EdgeInsets.symmetric(
            vertical: SIZE(S: 6, M: 6, L: 6, T: 6, D: 6),
            horizontal: SIZE(S: 2, M: 2, L: 2, T: 2, D: 2)),
        backgroundColor: Color.fromARGB(255, 38, 38, 54),
        duration: const Duration(seconds: 4),
        barType: FlashBarType.error,
        position: FlashPosition.top,
        behavior: FlashBehavior.floating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 31, 29, 44),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SIZE(S: 20, M: 10, L: 20, T: 20, D: 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SIZE(S: 7, M: 7, L: 7, T: 7, D: 7),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                iconSize: SIZE(S: 7, M: 7, L: 7, T: 7, D: 7),
              ),
              SizedBox(
                height: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
              ),
              Text(
                'Sign Up',
                textWidthBasis: TextWidthBasis.parent,
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        SIZE(S: 20, M: 30, L: 20, T: 20, D: 20, isW: false)),
              ),
              SizedBox(
                height: SIZE(S: 30, M: 30, L: 30, T: 30, D: 30),
              ),
              // todo : first field
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 2, color: Colors.white.withOpacity(.5)))),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/email icon.png',
                      width:
                          SIZE(S: 15, M: 16, L: 15, T: 15, D: 15, isW: false),
                    ),
                    SizedBox(
                      width: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: firstNameFocus,
                        controller: _firstName,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white.withOpacity(.9),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false)),
                        decoration: InputDecoration.collapsed(
                          hintText: 'First Name',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: SIZE(
                                  S: 14,
                                  M: 14,
                                  L: 14,
                                  T: 14,
                                  D: 14,
                                  isW: false)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
              ),
              // todo : Last name field
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 2, color: Colors.white.withOpacity(.5)))),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/email icon.png',
                      width:
                          SIZE(S: 15, M: 16, L: 15, T: 15, D: 15, isW: false),
                    ),
                    SizedBox(
                      width: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: lastNameFocus,
                        controller: _lastName,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white.withOpacity(.9),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false)),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Last Name',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: SIZE(
                                  S: 14,
                                  M: 14,
                                  L: 14,
                                  T: 14,
                                  D: 14,
                                  isW: false)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
              ),
              // todo : email field
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 2, color: Colors.white.withOpacity(.5)))),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/email icon.png',
                      width:
                          SIZE(S: 15, M: 16, L: 15, T: 15, D: 15, isW: false),
                    ),
                    SizedBox(
                      width: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: emailFocus,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white.withOpacity(.9),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false)),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: SIZE(
                                  S: 14,
                                  M: 14,
                                  L: 14,
                                  T: 14,
                                  D: 14,
                                  isW: false)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
              ),
              // todo : password
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 2, color: Colors.white.withOpacity(.5)))),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/pass icon.png',
                      width:
                          SIZE(S: 15, M: 16, L: 15, T: 15, D: 15, isW: false),
                    ),
                    SizedBox(
                      width: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: passwordFocus,
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colors.white.withOpacity(.9),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false)),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SIZE(S: 20, M: 20, L: 20, T: 20, D: 20),
              ),
              // todo : login button
              Obx(
                () {
                  return loginModelView.loadingIcon.value ?  const Center(child: CircularProgressIndicator(color: Colors.white,))
                  :
                  TextButton(
                      onPressed: () {
                        loginModelView
                            .signUp(
                              context: context,
                                email: _email.text,
                                passowrd: _password.text,
                                firstName: _firstName.text,
                                lastName: _lastName.text)
                            .then((value) {
                          if (value != '') {
                            if (value == 'first name') {
                              showMessage(feildName: value);
                            } else if (value == 'last name') {
                              showMessage(feildName: value);
                            } else if (value == 'email') {
                              showMessage(feildName: value);
                            } else {
                              showMessage(feildName: value);
                              // password
                            }
                          }
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 38, 38, 54)),
                          minimumSize: MaterialStateProperty.all(Size(
                              double.infinity,
                              SIZE(S: 15, M: 15, L: 15, T: 15, D: 15))),
                          overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 59, 59, 83))),
                      child: Text('Sign Up',
                          textWidthBasis: TextWidthBasis.parent,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: SIZE(
                                  S: 14, M: 14, L: 14, T: 14, D: 14, isW: false),
                              color: Colors.white,
                              fontWeight: FontWeight.bold)));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
