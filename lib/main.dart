import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/login_mv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_ahmed_ahmed/views/home/screen_home.dart';
import 'package:project_ahmed_ahmed/views/login/screen_login.dart';
import 'package:project_ahmed_ahmed/views/login/screen_sign_up.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/screen_note_editor.dart';
import 'package:project_ahmed_ahmed/views/splash/screen_splash.dart';

late AppLocalizations appLocalizations;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  appLocalizations = await AppLocalizations.delegate.load(const Locale('en'));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LoginModelView loginModelView = Get.put(LoginModelView());
  @override
  void initState() {
    super.initState();
    loginModelView.handleOfflineLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('- main');
    }

    return GetMaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Color.fromARGB(52, 255, 255, 255),
            selectionHandleColor: Colors.white),
      ),
      darkTheme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Color.fromARGB(52, 255, 255, 255),
            selectionHandleColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) {
          return HandleScreenDimensions(
              builder: (BuildContext context, DeviceInfo deviceInfo) {
            info = deviceInfo;
            return Obx(() {
              return loginModelView.isSignedIn.value == true
                  ? HomeScreen()
                  : SplashScreen();
            });
          });
        },
        'login/': (context) => LoginScreen(),
        'sign up/': (context) => SignUpScreen(),
        'home/': (context) => HomeScreen(),
        'note editor/': (context) => NoteEditor()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
