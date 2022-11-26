import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontFamilyModelView extends GetxController {
  int startRange = 0;
  List<String> groupeOfAllFonts = [];
  RxList fontsGroupe = [].obs;
  RxString selectedFontFamily = ''.obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<String> favoriteFontsCroupe = (<String>[]).obs;
  late SharedPreferences sharedPreferences;
  RxBool fontFamilybuttomSheetIsAcitve = false.obs;

  @override
  void onClose() {
    super.onClose();
    scrollController.value.removeListener(() {});
  }

  void _init(String selectedFontFamily) async {
    initAllFonts();
    selectFontFamily(selectedFontFamily);
    await initSharedPreferences();
    initFavoriteGroupe();
    _initFonts();
    initScrollListener();
  }

  Future<void> initSharedPreferences() async {
    // init SharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void initFavoriteGroupe() {
    // get favoriteFontsCroupe
    if (sharedPreferences.containsKey('favoriteFontsCroupe')) {
      if (sharedPreferences.getStringList('favoriteFontsCroupe') != null) {
        favoriteFontsCroupe.value =
            sharedPreferences.getStringList('favoriteFontsCroupe')!;
        favoriteFontsCroupe.refresh();
      }
    }
    if (kDebugMode) {
      print('favorite groupe -> $favoriteFontsCroupe');
    }
  }

  void _initFonts() {
    fontsGroupe.addAll(
        groupeOfAllFonts.getRange(startRange, startRange + 20).toList());
    fontsGroupe.refresh();
  }

  void initAllFonts() {
    groupeOfAllFonts = GoogleFonts.asMap().keys.toList();
  }

  void initScrollListener() {
    scrollController.value.addListener(() {
      if ((scrollController.value.offset.toInt() - 80) >
          scrollController.value.position.maxScrollExtent.toInt()) {
        ScrollHoldController hold = scrollController.value.position.hold(() {});
        Timer(const Duration(milliseconds: 1), () {
          hold.cancel();
        });
        try {
          startRange += 20;
          fontsGroupe.value.addAll(
              groupeOfAllFonts.getRange(startRange, startRange + 20).toList());
          fontsGroupe.refresh();
        } catch (e) {
          scrollController.value.removeListener(() {});
        }
      }
    });
  }

  void selectFontFamily(String _selectedFontFamily) {
    selectedFontFamily.value = _selectedFontFamily;
  }

  Future<void> addFontToFavorite({required String font}) async {
    if (favoriteFontsCroupe.value.contains(font)) {
      favoriteFontsCroupe.value.remove(font);
    } else {
      favoriteFontsCroupe.value.add(font);
    }

    favoriteFontsCroupe.refresh();

    if (sharedPreferences.containsKey('favoriteFontsCroupe')) {
      if (sharedPreferences.getStringList('favoriteFontsCroupe') != null) {
        List<String> favoriteGroupe =
            sharedPreferences.getStringList('favoriteFontsCroupe')!;
        favoriteGroupe.addAll(favoriteFontsCroupe.value);
        await sharedPreferences.setStringList(
            'favoriteFontsCroupe', favoriteGroupe);
      }
    }
  }

  void handelFontFamilySheet(String? selectedFontFamily) {
    startRange = 0;
    _changeSheetState();
    _hadelInit(selectedFontFamily);
    _handelRemoveListener();
    _handelFontsAfterDispose();
    // _handelClearFavoriteFontsCroupe();
  }

  void _changeSheetState() {
    fontFamilybuttomSheetIsAcitve.value = !fontFamilybuttomSheetIsAcitve.value;
    fontFamilybuttomSheetIsAcitve.refresh();
  }

  void _handelRemoveListener() {
    // this function should call after  [ _changeSheetState() ]
    if (!fontFamilybuttomSheetIsAcitve.value) {
      // if closed the sheet
      scrollController.value = ScrollController();
      scrollController.refresh();
    }
  }

  void _handelFontsAfterDispose() {
    // this function should call after  [ _changeSheetState() ]
    if (!fontFamilybuttomSheetIsAcitve.value) {
      // if closed the sheet
      fontsGroupe.value.clear();
      fontsGroupe.refresh();
    }
  }

  void _hadelInit(String? selectedFontFamily) {
    // this function should call after  [ _changeSheetState() ]
    if (fontFamilybuttomSheetIsAcitve.value) {
      // if opened the sheet
      if (selectedFontFamily != null) {
        _init(selectedFontFamily);
      }
    }
  }

  // void handelClearFavoriteFontsCroupe() {
  //   // this function should call after  [ _changeSheetState() ]
  //   if (!fontFamilybuttomSheetIsAcitve.value) {
  //     // if closed the sheet
  //     favoriteFontsCroupe.value.clear();
  //     favoriteFontsCroupe.refresh();
  //   }
  // }
}
