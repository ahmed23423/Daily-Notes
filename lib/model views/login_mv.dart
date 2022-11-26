import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../handle screen dimentions/infowidget.dart';

class LoginModelView extends GetxController {
  Rx<bool> isSignedIn = false.obs;
  Rx<bool> loadingIcon = false.obs;
  late SharedPreferences sharedPreferences;

  Future<void> handleOfflineLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // sleep(Duration(seconds: 5));
    if (sharedPreferences.containsKey('tokin')) {
      isSignedIn.value = true;
      isSignedIn.refresh();
    }
  }

  Future<String> signUp(
      {required String email,
      required String passowrd,
      required String firstName,
      required String lastName,
      required BuildContext context}) async {
    if (email.trim() == '' ||
        passowrd.trim() == '' ||
        firstName.trim() == '' ||
        lastName.trim() == '') {
      return firstName.trim() == ''
          ? 'first name'
          : lastName.trim() == ''
              ? 'last name'
              : email.trim() == ''
                  ? 'email'
                  : 'password';
    } else {
      loadingIcon.value = true;
      loadingIcon.refresh();
      Map<String, dynamic>? response = await LoginModel.theSignUp(
          email: email,
          passowrd: passowrd,
          firstName: firstName,
          lastName: lastName);
      loadingIcon.value = false;
      loadingIcon.refresh();
      if (response != null && response.containsKey('error message')) {
        String message = response['error message'] == 'this email are exsist'
            ? 'This email have an account'
            : response['error message'];
        showToast(context, message);
        return '';
      } else if (response != null && response.containsKey('tokin')) {
        // todo: save the tokin
        print(response['tokin']);
        popAllAndPushNewScreen(context);
        await sharedPreferences.setString('tokin', response['tokin']);
        return '';
      }
      return '';
    }
  }

  Future<String> signIn(
      {required String email,
      required String passowrd,
      required BuildContext context}) async {
    if (email.trim() == '' || passowrd.trim() == '') {
      return email.trim() == '' ? 'email' : 'password';
    } else {
      loadingIcon.value = true;
      loadingIcon.refresh();
      Map<String, dynamic>? response =
          await LoginModel.theSignIn(email: email, passowrd: passowrd);
      loadingIcon.value = false;
      loadingIcon.refresh();
      if (response != null && response.containsKey('error message')) {
        String message =
            response['error message'] == 'the email does not exsist'
                ? 'This email have not an account'
                : response['error message'];
        showToast(context, message);
        return '';
      } else if (response != null && response.containsKey('tokin')) {
        // todo: save the tokin
        print(response['tokin']);
        popAllAndPushNewScreen(context);
        await sharedPreferences.setString('tokin', response['tokin']);
        return '';
      }
      return '';
    }
  }

  void showToast(BuildContext context, message) {
    Widget flashWidget = Text(
      message,
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

  void popAllAndPushNewScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('home/',
        (Route<dynamic> route) => false );
  }
}
