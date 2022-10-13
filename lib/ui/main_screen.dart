import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ahmed_ahmed/model%20view/cubit%20main%20screen/main_screen_cubit.dart';

class mainScreen extends StatefulWidget {
  mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constrants) {
        return SafeArea(
          child: Column(
            children: [
              /// Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.1),
                    borderRadius: BorderRadius.circular(1000)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '.. WallPaper',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.3)),
                    ),
                    Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Colors.black.withOpacity(.3),
                    )
                  ],
                ),
              ),

              /// Nav Bar
              BlocConsumer<MainScreenCubit, MainScreenState>(
                listener: (context, state) {
                  if (state is ChangedNavBar) {
                    print('ChangedNavBar');
                  }
                },
                buildWhen: (previous, current) {
                  if (current is ChangedNavBar)
                    return true;
                  else
                    return false;
                },
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0),
                                  onTap: () {
                                    BlocProvider.of<MainScreenCubit>(context)
                                        .changeNavBar(targetNumber: 0);
                                  },
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                        color: BlocProvider.of<MainScreenCubit>(
                                                        context)
                                                    .animationCounter ==
                                                0
                                            ? Colors.black
                                            : Colors.black.withOpacity(.5),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0),
                                  onTap: () {
                                    BlocProvider.of<MainScreenCubit>(context)
                                        .changeNavBar(targetNumber: 1);
                                  },
                                  child: Text(
                                    'Gategory',
                                    style: TextStyle(
                                        color: BlocProvider.of<MainScreenCubit>(
                                                        context)
                                                    .animationCounter ==
                                                1
                                            ? Colors.black
                                            : Colors.black.withOpacity(.5),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0),
                                  onTap: () {
                                    BlocProvider.of<MainScreenCubit>(context)
                                        .changeNavBar(targetNumber: 2);
                                    ;
                                  },
                                  child: Text(
                                    'Favorite',
                                    style: TextStyle(
                                        color: BlocProvider.of<MainScreenCubit>(
                                                        context)
                                                    .animationCounter ==
                                                2
                                            ? Colors.black
                                            : Colors.black.withOpacity(.5),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        AnimatedContainer(
                          curve: Curves.easeInOut,
                          alignment: BlocProvider.of<MainScreenCubit>(context)
                                      .animationCounter ==
                                  1
                              ? Alignment.center
                              : BlocProvider.of<MainScreenCubit>(context)
                                          .animationCounter ==
                                      2
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          duration: const Duration(milliseconds: 300),
                          width: (constrants.maxWidth - 40),
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.amber,
                            width: (constrants.maxWidth - 40) / 3,
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
