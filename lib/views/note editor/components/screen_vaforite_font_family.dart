import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/font_family_mv.dart';
import 'package:project_ahmed_ahmed/model%20views/note_editor_mv.dart';
import 'package:project_ahmed_ahmed/views/components/fonts.dart';

class FavoriteFontFamily extends StatefulWidget {
  NoteEditorModelView noteEditorModelView = Get.find<NoteEditorModelView>();

  @override
  State<FavoriteFontFamily> createState() => _FavoriteFontFamily();
}

class _FavoriteFontFamily extends State<FavoriteFontFamily> {
  late FontFamilyModelView fontFamilyModelView =
      Get.find<FontFamilyModelView>();

  // scrollDirection: Axis.horizontal,
  //   physics: const BouncingScrollPhysics(),
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('- FavoriteFontFamily');
    }
    return Obx(() {
      return AnimatedContainer(
        clipBehavior: Clip.none,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5)),
        decoration: const BoxDecoration(color: Color.fromARGB(255, 38, 38, 54)),
        height: widget.noteEditorModelView.favoriteFontFamilyIsActive.value
            ? SIZE(S: 30, M: 30, L: 30, T: 30, D: 30)
            : 0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        widget.noteEditorModelView
                            .handelFavoriteFontFamilySheet();
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                          maxHeight: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
                          maxWidth: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10)),
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withOpacity(.7),
                        size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                      ))
                ],
              ),
              // favorite online fonts
              Row(
                children: [
                  Text(
                    'Favorite Fonts',
                    style: TextStyle(
                        fontFamily: Fonts.cairo.name,
                        color: Colors.white.withOpacity(.7),
                        fontSize: SIZE(
                            S: 12, M: 12, L: 12, T: 12, D: 12, isW: false)),
                  ),
                ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Obx(() {
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ...fontFamilyModelView.favoriteFontsCroupe.value
                          .map((font_name) {
                        String fontName = font_name;
                        return GestureDetector(
                          onTap: () {
                            widget.noteEditorModelView.setFontFamily(
                                fontFamily: fontName, onlineFont: true);
                            fontFamilyModelView.selectFontFamily(fontName);
                          },
                          child: Obx(() {
                            return AnimatedContainer(
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 100),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SIZE(
                                      S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5),
                                  vertical: SIZE(
                                      S: 1.5, M: 1.5, L: 1.5, T: 1.5, D: 1.5)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: fontFamilyModelView
                                              .selectedFontFamily.value ==
                                          fontName
                                      ? Border(
                                          bottom: BorderSide(
                                              color: Colors.white,
                                              width: SIZE(
                                                  S: .5,
                                                  M: .5,
                                                  L: .5,
                                                  T: .5,
                                                  D: .5)))
                                      : null),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // favorite icon button
                                  Obx(() {
                                    return IconButton(
                                        onPressed: () {
                                          fontFamilyModelView.addFontToFavorite(
                                              font: fontName);
                                          print(fontFamilyModelView
                                              .favoriteFontsCroupe.value);
                                        },
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(
                                            maxHeight: SIZE(
                                                S: 10,
                                                M: 10,
                                                L: 10,
                                                T: 10,
                                                D: 10),
                                            maxWidth: SIZE(
                                                S: 10,
                                                M: 10,
                                                L: 10,
                                                T: 10,
                                                D: 10)),
                                        icon: fontFamilyModelView
                                                .favoriteFontsCroupe.value
                                                .contains(fontName)
                                            ? Icon(
                                                Icons.favorite_rounded,
                                                color: Colors.white
                                                    .withOpacity(.7),
                                                size: SIZE(
                                                    S: 5,
                                                    M: 5,
                                                    L: 5,
                                                    T: 5,
                                                    D: 5),
                                              )
                                            : Icon(
                                                Icons.favorite_border_rounded,
                                                color: Colors.white
                                                    .withOpacity(.7),
                                                size: SIZE(
                                                    S: 5,
                                                    M: 5,
                                                    L: 5,
                                                    T: 5,
                                                    D: 5),
                                              ));
                                  }),
                                  Text(fontName,
                                      style: GoogleFonts.getFont(fontName,
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontFamily: fontName,
                                              fontSize: SIZE(
                                                  S: 12,
                                                  M: 12,
                                                  L: 12,
                                                  T: 12,
                                                  D: 12,
                                                  isW: false)))),
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
