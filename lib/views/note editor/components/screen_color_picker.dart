import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/note_editor_mv.dart';

class CustomColorPicker extends StatefulWidget {
  Color selectedColor;
  NoteEditorModelView noteEditorModelView;
  bool
      isFont; // if true change font color if false change font background color
  CustomColorPicker(
      {super.key, required this.selectedColor, required this.isFont,required this.noteEditorModelView});

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  List<Color> colorsCroup = [
    Colours.transparent,
    Colors.white,
    Colours.aliceBlue,
    Colours.antiqueWhite,
    Colours.aqua,
    Colours.aquamarine,
    Colours.azure,
    Colours.beige,
    Colours.bisque,
    Colours.blanchedAlmond,
    Colours.blueViolet,
    Colours.burlyWood,
    Colours.burntSienna,
    Colours.cadetBlue,
    Colours.chartReuse,
    Colours.chocolate,
    Colours.coral,
    Colours.cornFlowerBlue,
    Colours.cornSilk,
    Colours.crimson,
    Colours.darkBlue,
    Colours.darkCyan,
    Colours.darkGoldenRod,
    Colours.darkGreen,
    Colours.darkGrey,
    Colours.darkKhaki,
    Colours.darkMagenta,
    Colours.darkOliveGreen,
    Colours.darkOrange,
    Colours.darkOrchid,
    Colours.darkRed,
    Colours.darkSalmon,
    Colours.darkSeagreen,
    Colours.darkSlateBlue,
    Colours.darkSlateGrey,
    Colours.darkTurquoise,
    Colours.darkViolet,
    Colours.deepPink,
    Colours.deepSkyBlue,
    Colours.dimGrey,
    Colours.dodgerBlue,
    Colours.fireBrick,
    Colours.floralWhite,
    Colours.forestGreen,
    Colours.fuchsia,
    Colours.gainsboro,
    Colours.ghostWhite,
    Colours.gold,
    Colours.goldenRod,
    Colours.greenYellow,
    Colours.honeyDew,
    Colours.hotPink,
    Colours.indianRed,
    Colours.ivory,
    Colours.khaki,
    Colours.lavender,
    Colours.lavenderBlush,
    Colours.lawnGreen,
    Colours.lemonChiffon,
    Colours.lightCoral,
    Colours.lightCyan,
    Colours.lightGoldenRodYellow,
    Colours.lightGrey,
    Colours.lightPink,
    Colours.lightSalmon,
    Colours.lightSeaGreen,
    Colours.lightSkyBlue,
    Colours.lightSlateGrey,
    Colours.lightSteelBlue,
    Colours.lightYellow,
    Colours.limeGreen,
    Colours.linen,
    Colours.magenta,
    Colours.maroon, // transpart
    Colours.mediumAquamarine,
    Colours.mediumBlue,
    Colours.mediumOrchid,
    Colours.mediumPurple,
    Colours.mediumSeaGreen,
    Colours.mediumSlateBlue,
    Colours.mediumSpringGreen,
    Colours.mediumTurquoise,
    Colours.mediumVioletRed,
    Colours.midnightBlue,
    Colours.mintCream,
    Colours.mistyRose,
    Colours.moccasin,
    Colours.navajoWhite,
    Colours.navy,
    Colours.oldlace,
    Colours.olive,
    Colours.olivedRab,
    Colours.orangeRed,
    Colours.orchid,
    Colours.paleGoldenRod,
    Colours.paleGreen,
    Colours.paleTurquoise,
    Colours.paleVioletRed,
    Colours.papayaWhip,
    Colours.peachPuff,
    Colours.peru,
    Colours.plum,
    Colours.powderBlue,
    Colours.rebeccaPurple,
    Colours.rosyBrown,
    Colours.royalBlue,
    Colours.saddleBrown,
    Colours.salmon,
    Colours.sandyBrown,
    Colours.seaGreen,
    Colours.seaShell,
    Colours.sienna,
    Colours.silver,
    Colours.skyBlue,
    Colours.slateBlue,
    Colours.slateGrey,
    Colours.snow,
    Colours.springGreen,
    Colours.steelBlue,
    Colours.tan,
    Colours.thistle,
    Colours.tomato,
    Colours.turquoise,
    Colours.violet,
    Colours.wheat,
    Colours.whiteSmoke,
    Colours.yellowGreen,
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Wrap(
          children: [
            ...colorsCroup.map((color) {
              return (color.value == Colors.transparent.value && widget.isFont)
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        widget.isFont
                            ? widget.noteEditorModelView.setFontColor(newColor: color)
                            : widget.noteEditorModelView.setFontBackgroundColor(
                                newColor:
                                    color.value == Colors.transparent.value
                                        ? null
                                        : color);
                        setState(() {
                          widget.selectedColor = color;
                        });
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.all(
                            SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5)),
                        width: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
                        height: SIZE(S: 10, M: 10, L: 10, T: 10, D: 10),
                        decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: widget.selectedColor.value == color.value
                                ? Border.all(
                                    color:
                                        const Color.fromARGB(255, 38, 38, 54),
                                    width: SIZE(S: 2, M: 2, L: 2, T: 2, D: 2))
                                : null),
                        child: (color.value == Colors.transparent.value &&
                                !widget.isFont)
                            ? Icon(
                                Icons.format_color_reset_rounded,
                                color: Colors.white,
                                size: SIZE(S: 5, M: 5, L: 5, T: 5, D: 5),
                              )
                            : null,
                      ),
                    );
            })
          ],
        ));
  }
}
