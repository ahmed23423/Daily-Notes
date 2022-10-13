import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ahmed_ahmed/ui/main_screen.dart';

import 'model view/cubit main screen/main_screen_cubit.dart';


void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MainScreenCubit>(
      create: (BuildContext context) => MainScreenCubit(),
    ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainScreen(),
    );
  }
}

