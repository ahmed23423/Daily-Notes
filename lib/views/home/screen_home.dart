import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_ahmed_ahmed/main.dart';
import 'package:project_ahmed_ahmed/model%20views/home_mv.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenViewModel homeScreenViewModel;
  TextEditingController searchController = TextEditingController();
  FocusNode focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    homeScreenViewModel = Get.put(HomeScreenViewModel());
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('- home screen');
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 44),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5)),
          child: Column(
            children: [
              SizedBox(
                height: SIZE(S: 5, M: 8, L: 5, T: 5, D: 5),
              ),
              // the app bar
              Row(
                children: [
                  Text(
                    'Daily Notes',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontFamily: 'magnetob',
                        overflow: TextOverflow.fade,
                        fontSize:
                            SIZE(S: 18, M: 18, L: 18, T: 18, D: 18, isW: false),
                        color: Colors.white.withOpacity(1)),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        homeScreenViewModel.hideOrShowSearch();
                      },
                      icon: Image.asset(
                        'assets/icons/search icon.png',
                        width: SIZE(S: 6, M: 6, L: 6, T: 6, D: 6),
                      ).withOpacity(.7)),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsetsDirectional.all(0.0),
                    position: PopupMenuPosition.under,
                    color: const Color.fromARGB(255, 38, 38, 54),
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                          child: const Text(
                            "Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {},
                        ),
                        PopupMenuItem(
                          child: const Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {},
                        ),
                      ];
                    },
                    icon: Image.asset(
                      'assets/icons/menu icon.png',
                      width: SIZE(S: 6, M: 6, L: 6, T: 6, D: 6),
                    ).withOpacity(.7),
                  ),
                ],
              ),
              Obx(() {
                homeScreenViewModel.searchIsActive.value
                    ? focusSearch.requestFocus()
                    : focusSearch.hasFocus
                        ? focusSearch.unfocus()
                        : null;
                return AnimatedContainer(
                  decoration: const BoxDecoration(),
                  onEnd: () => searchController.text = '',
                  alignment: Alignment.centerLeft,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: homeScreenViewModel.searchIsActive.value ? 40 : 0,
                  padding: EdgeInsets.symmetric(
                      horizontal: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5)),
                  duration: const Duration(milliseconds: 100),
                  child: TextFormField(
                    controller: searchController,
                    focusNode: focusSearch,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SIZE(
                            S: 15, M: 15, L: 15, T: 15, D: 15, isW: false)),
                    cursorColor: Colors.white.withOpacity(.9),
                    decoration: InputDecoration.collapsed(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: SIZE(
                                S: 15,
                                M: 15,
                                L: 15,
                                T: 15,
                                D: 15,
                                isW: false))),
                  ),
                );
              }),
              SizedBox(
                height: SIZE(S: 5, M: 8, L: 5, T: 5, D: 5),
              ),
              // the notes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // column one
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                              maxHeight: 250, minHeight: 30),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding: EdgeInsets.symmetric(
                              horizontal: SIZE(S: 2, M: 2, L: 2, T: 2, D: 2),
                              vertical: SIZE(S: 4, M: 4, L: 4, T: 4, D: 4)),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 38, 38, 54),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Home work this home work for studing the system Home work this home work for studing the system Home work this home work for studing the system Home work this home work for studing the system Home work this home work for studing the system',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                        ),
                        Container(
                          width: double.infinity,
                          color: const Color.fromARGB(255, 38, 38, 54),
                          child: const Text(
                            'Home work this home work for studing the system',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  // space between the two column
                  SizedBox(
                    width: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                  ),
                  // column two
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: const Color.fromARGB(255, 38, 38, 54),
                          child: const Text(
                              'Home work this home work for studing the system Home work this home work for studing the system',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                        ),
                        Container(
                          width: double.infinity,
                          color: const Color.fromARGB(255, 38, 38, 54),
                          child: const Text(
                            'Home work this home work for studing the system',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('note editor/', arguments: {'null':null});
        },
        backgroundColor: const Color.fromARGB(255, 112, 111, 200),
        child: Image.asset(
          'assets/icons/new note icon.png',
          width: SIZE(S: 6, M: 6, L: 6, T: 6, D: 6),
        ),
      ),
    );
  }
}

extension MyCustomWidget on Widget {
  Widget withOpacity(double? opacity) {
    return Opacity(
      opacity: opacity ?? 1,
      child: this,
    );
  }
}
