import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/note_editor_mv.dart';

class FontSize extends StatefulWidget {
  int selectedFont;
  NoteEditorModelView noteEditorModelView;
  FontSize({super.key, required this.selectedFont,required this.noteEditorModelView});

  @override
  State<FontSize> createState() => _FontSizeState();
}

class _FontSizeState extends State<FontSize> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          children: [
            ...List.generate(20, (index) {
              int fontSize = 4 + index;
              return GestureDetector(
                onTap: () {
                  widget.noteEditorModelView.setFontSize(
                      newFontSize: fontSize.toDouble());
                  setState(() {
                    widget.selectedFont = fontSize;
                  });
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 100),
                  margin: EdgeInsets.all(
                      SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5)),
                  width: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
                  height: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: widget.selectedFont == fontSize
                          ? Border.all(
                              color: Colors.white,
                              width: SIZE(S: .5, M: .5, L: .5, T: .5, D: .5))
                          : null),
                  child: Text(
                    fontSize.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SIZE(
                            S: 12, M: 12, L: 12, T: 12, D: 12, isW: false)),
                  ),
                ),
              );
            })
          ],
        ));
  }
}
