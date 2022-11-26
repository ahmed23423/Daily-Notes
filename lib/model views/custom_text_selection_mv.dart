import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_ahmed_ahmed/views/components/fonts.dart';

import '../handle screen dimentions/infowidget.dart';

class CustomTextSelectionControllerModelViews extends GetxController {
  RxBool codeBlock = false.obs;
  RxBool blockQuote = false.obs;
  RxBool directionLtr = true.obs;
  RxBool directionRtl = false.obs;
  RxBool alginLeft = true.obs;
  RxBool alginRight = false.obs;
  RxBool alginCenter = false.obs;
  RxBool alginJustify = false.obs;
  RxBool bold = false.obs;
  RxBool italic = false.obs;
  RxBool underline = false.obs;
  RxBool strick = false.obs;
  Rx<int> fontSize = 14.obs;
  Rx<int> fontColor = Colors.white.value.obs;
  Rx<int> fontBackgroundColor = 0.obs;
  Rx<int> customFontBackgroundColor = 0.obs;
  Rx<String> fontFamily = Fonts.cairo.name.obs;


  Future<void> handelSelectionStyle(
      {required QuillController quillController}) async {
    Map<String, dynamic>? selectionStyle =
        _getAllSelectionStyle(quillController);
    if (selectionStyle.containsKey('bold')) {
      bold.value = true;
    } else
      bold.value = false;
    if (selectionStyle.containsKey('italic')) {
      italic.value = true;
    } else
      italic.value = false;
    if (selectionStyle.containsKey('blockquote')) {
      blockQuote.value = true;
    } else
      blockQuote.value = false;
    if (selectionStyle.containsKey('strike')) {
      strick.value = true;
    } else
      strick.value = false;
    if (selectionStyle.containsKey('code-block')) {
      codeBlock.value = true;
    } else
      codeBlock.value = false;
    if (selectionStyle.containsKey('underline')) {
      underline.value = true;
    } else
      underline.value = false;

    if (selectionStyle.containsKey('align')) {
      String alginType = selectionStyle['align'];
      _handelAlignment(alginType);
    } else {
      _handelAlignment('left');
    }

    if (selectionStyle.containsKey('direction')) {
      String direction = selectionStyle['direction'];
      _handelDirection(direction);
    }
    if (selectionStyle.containsKey('size')) {
      fontSize.value =
          (selectionStyle['size'] / ((info.width / 3) / 100)).toInt();
    } else
      fontSize.value = 14;
    if (selectionStyle.containsKey('color')) {
      fontColor.value = HexColor(selectionStyle['color']).value;
    } else
      fontColor.value = Colors.white.value;
    if (selectionStyle.containsKey('background')) {
      fontBackgroundColor.value = HexColor(selectionStyle['background']).value;
    } else
      fontBackgroundColor.value = 0;
    if (selectionStyle.containsKey('customBackground')) {
      customFontBackgroundColor.value =
          HexColor(selectionStyle['customBackground']).value;
    } else
      customFontBackgroundColor.value = 0;
    if (selectionStyle.containsKey('font')) {
      if (selectionStyle.containsKey('myCustomFont')) {
        fontFamily.value = selectionStyle['myCustomFont'];
      } else {
        fontFamily.value = selectionStyle['font'];
      }
    } else
      fontFamily.value = Fonts.cairo.name;
  }

  Map<String, dynamic> _getAllSelectionStyle(
      QuillController bodyQuillController) {
    int lengthSelectionWords =
        bodyQuillController.selection.end - bodyQuillController.selection.start;
    int selectionBeginning = bodyQuillController.selection.start;
    List<Style>? allSelectionStyle = bodyQuillController.document
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

  void _handelAlignment(alginType) {
    alginLeft.value = false;
    alginRight.value = false;
    alginJustify.value = false;
    alginCenter.value = false;
    if (alginType == 'left') {
      alginLeft.value = true;
    } else if (alginType == 'right') {
      alginRight.value = true;
    } else if (alginType == 'justify') {
      alginJustify.value = true;
    } else {
      alginCenter.value = true;
    }
  }

  void _handelDirection(direction) {
    directionLtr.value = false;
    directionRtl.value = false;
    switch (direction) {
      case 'ltr':
        directionLtr.value = true;
        break;
      case 'rtl':
        directionRtl.value = true;
        break;
    }
  }
}
