import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/note_editor_mv.dart';
import 'package:project_ahmed_ahmed/views/components/fonts.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/components/screen_vaforite_font_family.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'components/custom_text_selection_controls.dart';
import 'components/screen_font_family.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  Map<String, dynamic>? noteInformation;
  final NoteEditorModelView noteEditorModelView = Get.put(
    NoteEditorModelView(),
  );
  String today = DateFormat('yyyy MMM d hh:mm a EEE').format(DateTime.now());
  TextEditingController titleController = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();
    noteEditorModelView.customDispose();
  }

  @override
  void initState() {
    super.initState();
    noteEditorModelView.initialize();
  }

  @override
  Widget build(BuildContext context) {
    print('- note editor');
    noteInformation =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 44),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5)),
                child: Column(
                  children: [
                    SizedBox(
                      height: SIZE(S: 5, M: 8, L: 5, T: 5, D: 5),
                    ),
                    // app bar
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                            )),
                        const Spacer(),
                        // undo button
                        Obx(() {
                          bool undoIsActive =
                              noteEditorModelView.undoIsActive.value;
                          return IconButton(
                              onPressed: () {
                                noteEditorModelView.undo();
                              },
                              icon: Icon(
                                Icons.undo_rounded,
                                size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                                color: undoIsActive
                                    ? Colors.white
                                    : Colors.white.withOpacity(.5),
                              ));
                        }),
                        // redo button
                        Obx(() {
                          bool redoIsActive =
                              noteEditorModelView.redoIsActive.value;
                          return IconButton(
                              onPressed: () {
                                noteEditorModelView.redo();
                              },
                              icon: Icon(
                                Icons.redo_rounded,
                                size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                                color: redoIsActive
                                    ? Colors.white
                                    : Colors.white.withOpacity(.5),
                              ));
                        }),
                        const Spacer(),
            
                        Obx(
                          () {
                            bool shareIsActive =
                                noteEditorModelView.shareIsActive.value;
            
                            return IconButton(
                                onPressed: () {
                                  if (shareIsActive) {
                                    Share.share(noteEditorModelView
                                        .bodyQuillController.value.document
                                        .toPlainText());
                                  }
                                },
                                icon: Icon(Icons.ios_share_rounded,
                                    size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                                    color: shareIsActive
                                        ? Colors.white.withOpacity(.8)
                                        : Colors.white.withOpacity(.5)));
                          },
                        ),
            
                        Obx(
                          () {
                            bool saveIsActive =
                                noteEditorModelView.saveIsActive.value;
            
                            return IconButton(
                                onPressed: () {
                                  if (saveIsActive) {
                                    // todo : save the editing
                                  }
                                },
                                icon: Icon(
                                  Icons.check_rounded,
                                  size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                                  color: saveIsActive
                                      ? Colors.white
                                      : Colors.white.withOpacity(.5),
                                ));
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: SIZE(S: 8, M: 8, L: 8, T: 8, D: 8),
                    ),
                    // note title
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            minLines: 1,
                            maxLengthEnforcement:
                                MaxLengthEnforcement.truncateAfterCompositionEnds,
                            controller: titleController,
                            cursorColor: Colors.white.withOpacity(.8),
                            style: TextStyle(
                                fontSize: SIZE(
                                    S: 20,
                                    M: 20,
                                    L: 20,
                                    T: 20,
                                    D: 20,
                                    isW: false),
                                color: Colors.white,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.w600),
                            onChanged: (e) {},
                            decoration: InputDecoration.collapsed(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: 'The title',
                                hintStyle: TextStyle(
                                    fontSize: SIZE(
                                        S: 20,
                                        M: 20,
                                        L: 20,
                                        T: 20,
                                        D: 20,
                                        isW: false),
                                    fontFamily: Fonts.cairo.name,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(.5))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SIZE(S: 5, M: 2, L: 5, T: 5, D: 5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                          return m.Text.rich(
                            TextSpan(children: [
                              TextSpan(text: today),
                              TextSpan(
                                text:
                                    ' | ${noteEditorModelView.wordsLength.value} words',
                              ),
                            ]),
                            style: TextStyle(
                                fontFamily: Fonts.cairo.name,
                                textBaseline: TextBaseline.ideographic,
                                color: Colors.white.withOpacity(.3),
                                fontSize: SIZE(
                                    S: 10,
                                    M: 10,
                                    L: 10,
                                    T: 10,
                                    D: 10,
                                    isW: false)),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: SIZE(S: 5, M: 2, L: 5, T: 5, D: 5),
                    ),
                    // body of note
                    Builder(builder: (context) {
                      return Obx(() {
                        return Expanded(
                          child: Scrollbar(
                            thickness: 1,
                            radius: const Radius.circular(9999),
                            controller: noteEditorModelView.quillScrollController.value,
                            child: QuillEditor(
                              expands: false,
                              showCursor: true,
                              placeholder: 'Get creative in writing . . .',
                              autoFocus: false,
                              controller:
                                  noteEditorModelView.bodyQuillController.value,
                              focusNode: FocusNode(),
                              padding: EdgeInsets.only(bottom: SIZE(S: 3, M: 3, L: 3, T: 3, D: 3)),
                              readOnly: false,
                              scrollPhysics: const ScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              scrollController: noteEditorModelView.quillScrollController.value,
                              scrollable: true,
                              textSelectionControls:
                                  CustomTextSelectionControls(mainContext: context),
                              customStyles: DefaultStyles(
                                  quote: DefaultTextBlockStyle(
                                    const TextStyle(
                                        height: 1.5,
                                        textBaseline: TextBaseline.alphabetic,
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    const Tuple2(0, 0),
                                    const Tuple2(0, 0),
                                    BoxDecoration(
                                        color: Colors.white.withOpacity(.3),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  strikeThrough: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: SIZE(
                                          S: 1,
                                          M: 1,
                                          L: 1,
                                          T: 1,
                                          D: 1,
                                          isW: false)),
                                  code: DefaultTextBlockStyle(
                                    TextStyle(
                                        height: 1.4,
                                        textBaseline: TextBaseline.alphabetic,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                        fontSize: SIZE(
                                            S: 10,
                                            M: 10,
                                            L: 10,
                                            T: 10,
                                            D: 10,
                                            isW: false),
                                        color: Colors.white),
                                    const Tuple2(0, 0),
                                    const Tuple2(0, 0),
                                    BoxDecoration(
                                        color: Colors.white.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  paragraph: DefaultTextBlockStyle(
                                      TextStyle(
                                        textBaseline: TextBaseline.alphabetic,
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                        fontFamily: 'cairo',
                                        color: Colors.white,
                                        height: 1.5,
                                        fontSize: SIZE(
                                            S: 14,
                                            M: 14,
                                            L: 14,
                                            T: 14,
                                            D: 14,
                                            isW: false),
                                      ),
                                      const Tuple2(0, 0),
                                      const Tuple2(0, 0),
                                      null),
                                  placeHolder: DefaultTextBlockStyle(
                                      TextStyle(
                                          fontSize: SIZE(
                                              S: 14,
                                              M: 14,
                                              L: 14,
                                              T: 14,
                                              D: 14,
                                              isW: false),
                                          color: Colors.white.withOpacity(.5),
                                          fontFamily: 'cairo'),
                                      const Tuple2(0, 0),
                                      const Tuple2(0, 0),
                                      null),
                                  color: Colors.white),
                              onSingleLongTapMoveUpdate:
                                  (LongPressMoveUpdateDetails details,
                                      TextPosition Function(Offset) p1) {
                                noteEditorModelView.updateCursor(details, p1);
                                return true;
                              },
                              customStyleBuilder: (Attribute attribute) {
                                if (attribute.key == 'customBackground') {
                                  // NOT worcking for yet
                                  if (attribute.value != null) {
                                    final String hxaBackgroundColor =
                                        attribute.value;
                                    Color backgroundColor =
                                        HexColor(hxaBackgroundColor);
                                    Paint paint = Paint()
                                      ..color = backgroundColor
                                      ..style = PaintingStyle.stroke
                                      ..filterQuality = FilterQuality.high;
                                    return TextStyle(background: paint);
                                  } else {
                                    return const TextStyle(background: null);
                                  }
                                } else if (attribute.key == 'font') {
                                  if (attribute.value != null) {
                                    TextStyle textStyle;
                                    var fontsCroupe = GoogleFonts.asMap();
                                      
                                    // if the font note found in google fonts dictionary
                                    // then he is in my assets ( offline )
                                      
                                    if (fontsCroupe.containsKey(attribute.value)) {
                                      var _textStyle = fontsCroupe[attribute.value];
                                      textStyle = _textStyle!();
                                    } else {
                                      textStyle =
                                          TextStyle(fontFamily: attribute.value);
                                    }
                                      
                                    return textStyle;
                                  }
                                } else {
                                  return const TextStyle(fontFamily: null);
                                }
                                return const TextStyle();
                              },
                            ),
                          ),
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),

            // fonts
            FontFamily(
              noteEditorModelView: noteEditorModelView,
              selectedFontFamily: 'null for now',
            ),

            // favorite fonts
            FavoriteFontFamily(),
          ],
        ),
      ),
    );
  }
}
