import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/custom_text_selection_mv.dart';
import 'package:project_ahmed_ahmed/model%20views/font_family_mv.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/components/custom_text_selection_controls.dart';

class NoteEditorModelView extends GetxController {
  late CustomTextSelectionControllerModelViews selectionControllerModelViews;
  Rx<QuillController> bodyQuillController = QuillController.basic().obs;
  Rx<ScrollController> quillScrollController = ScrollController().obs;

  RxBool shareIsActive = false.obs;
  RxBool undoIsActive = false.obs; // back
  RxBool redoIsActive = false.obs;
  RxBool saveIsActive = false.obs;
  RxInt wordsLength = 0.obs;
  RxBool favoriteFontFamilyIsActive = false.obs;

  void initialize({QuillController? quillController}) {
    _initializeDocument();
    _initializeUndoAndRedo();
    _initScrollListener();
  }

  void _initScrollListener() {
    quillScrollController.value.addListener(() {
      if (globleDelegate != null) {
        globleDelegate!.hideToolbar(false);
      }
    });
  }

  void _initializeDocument() {
    bodyQuillController.value = QuillController.basic();
  }

  void _initializeUndoAndRedo() {
    bodyQuillController.value.addListener(() {
      try {
        try {
          selectionControllerModelViews =
              Get.find<CustomTextSelectionControllerModelViews>();
          if (bodyQuillController.value.getPlainText().length >= 0) {
            selectionControllerModelViews.handelSelectionStyle(
                quillController: bodyQuillController.value);
          }
        } catch (e) {
          print(e);
        }

        if (bodyQuillController.value.hasUndo) {
          if (!undoIsActive.value) {
            undoIsActive.value = true;
            // undoIsActive.refresh();
          }
        } else {
          if (undoIsActive.value) {
            undoIsActive.value = false;
            // undoIsActive.refresh();
          }
        }
        if (bodyQuillController.value.hasRedo) {
          if (!redoIsActive.value) {
            redoIsActive.value = true;
            // redoIsActive.refresh();
          }
        } else {
          if (redoIsActive.value) {
            redoIsActive.value = false;
            // redoIsActive.refresh();
          }
        }

        // active save button
        if (undoIsActive.value &&
            bodyQuillController.value.document.toPlainText().length > 1) {
          saveIsActive.value = true;
        } else {
          saveIsActive.value = false;
        }
        saveIsActive.refresh();

        // words length
        wordsLength.value =
            bodyQuillController.value.document.toPlainText().length - 1;
        wordsLength.refresh();

        // active share button
        if (bodyQuillController.value.document.toPlainText().length > 1) {
          shareIsActive.value = true;
        } else {
          shareIsActive.value = false;
        }
        shareIsActive.refresh();
      } catch (e) {
        print('from initializeUndoAndRedo #  $e');
      }
    });
  }

  void undo() {
    bodyQuillController.value.undo();
    // bodyQuillController.refresh();
  }

  void redo() {
    bodyQuillController.value.redo();
    // bodyQuillController.refresh();
  }

  void setAlignLeft() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(
        selectionBeginning, lengthSelectionWords, const AlignAttribute('left'));
    // bodyQuillController.refresh();
  }

  void setAlignRight() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(selectionBeginning,
        lengthSelectionWords, const AlignAttribute('right'));
    // bodyQuillController.refresh();
  }

  void setAlignCenter() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(selectionBeginning,
        lengthSelectionWords, const AlignAttribute('center'));
    // bodyQuillController.refresh();
  }

  void setAlignJustify() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(selectionBeginning,
        lengthSelectionWords, const AlignAttribute('justify'));
    // bodyQuillController.refresh();
  }

  void setSelectionBold() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic>? selectionStyle = bodyQuillController.value.document
        .collectStyle(
            bodyQuillController.value.selection.start, lengthSelectionWords)
        .toJson();
    print(selectionStyle);

    if (selectionStyle != null && selectionStyle.containsKey('bold')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('bold', AttributeScope.INLINE,
              selectionStyle['bold'] ? null : true));
    } else if (selectionStyle == null || !selectionStyle.containsKey('bold')) {
      bodyQuillController.value.formatText(selectionBeginning,
          lengthSelectionWords, Attribute('bold', AttributeScope.INLINE, true));
    }
    // bodyQuillController.refresh();
  }

  void setSelectionItalic() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic>? selectionStyle = bodyQuillController.value.document
        .collectStyle(
            bodyQuillController.value.selection.start, lengthSelectionWords)
        .toJson();
    if (selectionStyle != null && selectionStyle.containsKey('italic')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('italic', AttributeScope.INLINE,
              selectionStyle['italic'] ? null : true));
    } else if (selectionStyle == null ||
        !selectionStyle.containsKey('italic')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('italic', AttributeScope.INLINE, true));
    }
    // bodyQuillController.refresh();
  }

  void setSelectionUnderline() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic>? selectionStyle = bodyQuillController.value.document
        .collectStyle(
            bodyQuillController.value.selection.start, lengthSelectionWords)
        .toJson();
    if (selectionStyle != null && selectionStyle.containsKey('underline')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('underline', AttributeScope.INLINE,
              selectionStyle['underline'] ? null : true));
    } else if (selectionStyle == null ||
        !selectionStyle.containsKey('underline')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('underline', AttributeScope.INLINE, true));
    }
    // bodyQuillController.refresh();
  }

  void setFontSize({required double newFontSize}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic>? selectionStyle = bodyQuillController.value.document
        .collectStyle(
            bodyQuillController.value.selection.start, lengthSelectionWords)
        .toJson();
    if (selectionStyle != null && selectionStyle.containsKey('size')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute(
              'size',
              AttributeScope.INLINE,
              SIZE(
                  S: newFontSize,
                  M: newFontSize,
                  L: newFontSize,
                  T: newFontSize,
                  D: newFontSize,
                  isW: false)));
    } else if (selectionStyle == null || !selectionStyle.containsKey('size')) {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute(
              'size',
              AttributeScope.INLINE,
              SIZE(
                  S: newFontSize,
                  M: newFontSize,
                  L: newFontSize,
                  T: newFontSize,
                  D: newFontSize,
                  isW: false)));
    }
    // bodyQuillController.refresh();
  }

  void clearSelectionStyle() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(
        selectionBeginning,
        lengthSelectionWords,
        const Attribute('myCustomFont', AttributeScope.INLINE, null));
    Map<String, dynamic> selectionStyle = _getAllSelectionStyle();
    Map<String, dynamic> clearStyle = {};
    selectionStyle.forEach((key, value) {
      if (key != 'align') {
        clearStyle.addAll({key: null});
      }
    });
    bodyQuillController.value.formatTextStyle(
        selectionBeginning, lengthSelectionWords, Style.fromJson(clearStyle));
    bodyQuillController.refresh();
  }

  void setTextDirection({required bool ltr}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    bodyQuillController.value.formatText(selectionBeginning,
        lengthSelectionWords, DirectionAttribute(ltr ? 'ltr' : 'rtl'));
    bodyQuillController.value.formatText(selectionBeginning,
        lengthSelectionWords, AlignAttribute(ltr ? 'left' : 'right'));
    // bodyQuillController.refresh();
  }

  void setFontColor({required Color newColor}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    String hexColor = newColor
        .toString()
        .replaceAll('MaterialColor(primary value: Color(0x', '#')
        .replaceAll('))', '')
        .replaceAll('Color(0x', '#')
        .replaceAll(')', '');
    print(hexColor);
    print(lengthSelectionWords);
    bodyQuillController.value.formatSelection(ColorAttribute(hexColor));
    // bodyQuillController.value.formatText(
    //     selectionBeginning, lengthSelectionWords, ColorAttribute(hexColor));
    // bodyQuillController.refresh();
  }

  void setFontBackgroundColor({required Color? newColor}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    print(lengthSelectionWords);
    String? hexColor = newColor != null
        ? newColor
            .withOpacity(.5)
            .toString()
            .replaceAll('MaterialColor(primary value: Color(0x', '#')
            .replaceAll('))', '')
            .replaceAll('Color(0x', '#')
            .replaceAll(')', '')
        : null;
    bodyQuillController.value.formatText(
        selectionBeginning,
        lengthSelectionWords,
        Attribute('background', AttributeScope.INLINE, hexColor));
    // bodyQuillController.refresh();
  }

  void setList({required ListType listType}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic> selectionStyle = _getAllSelectionStyle();
    if (selectionStyle.containsValue(listType.name)) {
      bodyQuillController.value.formatText(
          selectionBeginning, lengthSelectionWords, const ListAttribute(null));
    } else {
      bodyQuillController.value.formatText(selectionBeginning,
          lengthSelectionWords, ListAttribute(listType.name));
    }
    // bodyQuillController.refresh();
  }

  void setFontFamily({required String fontFamily, bool? onlineFont}) {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;

    bodyQuillController.value.formatText(
        selectionBeginning,
        lengthSelectionWords,
        Attribute('font', AttributeScope.INLINE, fontFamily));

    //? this code it does not matter for now
    // if (onlineFont != null && onlineFont) {
    //   print('online font');
    //   bodyQuillController.value.formatText(
    //       selectionBeginning, lengthSelectionWords, const FontAttribute(null));
    //   bodyQuillController.value.formatText(
    //       selectionBeginning,
    //       lengthSelectionWords,
    //       Attribute('myCustomFont', AttributeScope.INLINE, fontFamily));
    // } else {
    //   print('offline font');
    //   bodyQuillController.value.formatText(
    //       selectionBeginning,
    //       lengthSelectionWords,
    //       const Attribute('myCustomFont', AttributeScope.INLINE, null));
    //   bodyQuillController.value.formatText(
    //       selectionBeginning, lengthSelectionWords, FontAttribute(fontFamily));
    // }
    // bodyQuillController.refresh();
  }

  void setSelectionCode() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic> selectionStyle = _getAllSelectionStyle();
    if (selectionStyle.containsKey('code-block')) {
      bool valueCode = selectionStyle['code-block'] as bool;
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute(
              'code-block', AttributeScope.BLOCK, !valueCode ? true : null));
    } else {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          const Attribute('code-block', AttributeScope.BLOCK, true));
    }
    // bodyQuillController.refresh();
  }

  void setSelectionStrick() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic> selectionStyle = _getAllSelectionStyle();
    if (selectionStyle.containsKey('strike')) {
      dynamic strike = selectionStyle['strike'];
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('strike', AttributeScope.INLINE,
              strike == null || !strike ? true : null));
    } else {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          const Attribute('strike', AttributeScope.INLINE, true));
    }
    // bodyQuillController.refresh();
  }

  void setSelectionQuote() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    Map<String, dynamic> selectionStyle = _getAllSelectionStyle();
    if (selectionStyle.containsKey('blockquote')) {
      dynamic quote = selectionStyle['blockquote'];
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          Attribute('blockquote', AttributeScope.BLOCK,
              quote == null || !quote ? true : null));
    } else {
      bodyQuillController.value.formatText(
          selectionBeginning,
          lengthSelectionWords,
          const Attribute('blockquote', AttributeScope.BLOCK, true));
    }
    // bodyQuillController.refresh();
  }

  void updateCursor(
      LongPressMoveUpdateDetails details, TextPosition Function(Offset) p1) {
    TextPosition textPosition =
        p1((details.globalPosition + const Offset(0, -60)));
    print(textPosition);
    bodyQuillController.value.moveCursorToPosition(textPosition.offset);
    // bodyQuillController.refresh();
  }

  Map<String, dynamic> _getAllSelectionStyle() {
    int lengthSelectionWords = bodyQuillController.value.selection.end -
        bodyQuillController.value.selection.start;
    int selectionBeginning = bodyQuillController.value.selection.start;
    List<Style>? allSelectionStyle = bodyQuillController.value.document
        .collectAllStyles(selectionBeginning, lengthSelectionWords);
    Map<String, dynamic> selectionStyle = {};
    allSelectionStyle.forEach((element) {
      if (element.toJson() != null) {
        selectionStyle.addAll(element.toJson()!);
      }
    });
    Map<String, dynamic> clearStyle = {};
    selectionStyle.forEach((key, value) {
      if (key != 'align') {
        clearStyle.addAll({key: null});
      }
    });
    return selectionStyle;
  }

  void customDispose() {
    print('disposed');
    bodyQuillController.value.removeListener(() {
      print('removedListener');
    });
    quillScrollController.value.removeListener(() {});
    bodyQuillController.value.document.close();
  }

  void handelFavoriteFontFamilySheet() {
    // FontFamilyModelView fontFamilyModelView = Get.find<FontFamilyModelView>();
    favoriteFontFamilyIsActive.value = !favoriteFontFamilyIsActive.value;
    favoriteFontFamilyIsActive.refresh();
  }
}

enum ListType { bullet, ordered, checked, unchecked }
