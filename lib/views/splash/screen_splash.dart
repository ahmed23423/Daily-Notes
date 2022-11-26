import 'package:flutter/material.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
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
              children: [
                SizedBox(
                  height: SIZE(S: 20, M: 30, L: 20, T: 20, D: 20),
                ),
                Image.asset('assets/images/splash image.png'),
                SizedBox(
                  height: SIZE(S: 20, M: 30, L: 20, T: 20, D: 20),
                ),
                Text(
                  'Daily Notes',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'magnetob',
                      fontSize:
                          SIZE(S: 20, M: 24, L: 20, T: 20, D: 20, isW: false),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                ),
                Text(
                  'Plan what you will do to be more organized for today, tomorrow and beyond.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize:
                          SIZE(S: 13, M: 13, L: 13, T: 13, D: 13, isW: false)),
                ),
                SizedBox(
                  height: SIZE(S: 25, M: 25, L: 25, T: 25, D: 25),
                ),
                // todo : login button
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('login/');
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
                    child: Text('Login',
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false),
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3),
                ),
                // todo : Sign up button
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('sign up/');
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        minimumSize: MaterialStateProperty.all(Size(
                            double.infinity,
                            SIZE(S: 15, M: 15, L: 15, T: 15, D: 15))),
                        overlayColor: MaterialStateProperty.all(
                            Color.fromARGB(138, 59, 59, 83))),
                    child: Text('Sign up',
                        style: TextStyle(
                            fontSize: SIZE(
                                S: 14, M: 14, L: 14, T: 14, D: 14, isW: false),
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ),
      );
  }
}
