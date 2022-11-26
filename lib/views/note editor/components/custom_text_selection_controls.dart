import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_ahmed_ahmed/handle%20screen%20dimentions/infowidget.dart';
import 'package:project_ahmed_ahmed/model%20views/note_editor_mv.dart';
import 'package:project_ahmed_ahmed/views/components/fonts.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/components/screen_color_picker.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/components/screen_font_family.dart';
import 'package:project_ahmed_ahmed/views/note%20editor/components/screen_font_size.dart';

import '../../../model views/custom_text_selection_mv.dart';
import '../../../model views/font_family_mv.dart';

TextSelectionDelegate? globleDelegate;

class CustomTextSelectionControls extends TextSelectionControls {
  BuildContext mainContext;
  CustomTextSelectionControls({required this.mainContext});
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    globleDelegate = delegate;
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            startTextSelectionPoint.point.dy -
            textLineHeight -
            _kToolbarContentDistance);
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );

    // delegate.pasteText(SelectionChangedCause.toolbar).then((value) => null);
    return MyTextSelectionToolbar(
      delegate: delegate,
      mainContext: mainContext,
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus!,
      handleCopy: canCopy(delegate) && handleCopy != null
          ? () => handleCopy(delegate, clipboardStatus)
          : null,
      handleCut: canCut(delegate) && handleCut != null
          ? () => handleCut(delegate)
          : null,
      handlePaste: canPaste(delegate) && handlePaste != null
          ? () => handlePaste(delegate)
          : null,
      handleSelectAll: () => handleSelectAll(delegate),
    );
  }

  @override
  m.Widget buildHandle(m.BuildContext context, m.TextSelectionHandleType type,
      double textLineHeight,
      [m.VoidCallback? onTap]) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 2,
      height: textLineHeight,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(999)),
    );
  }

  @override
  m.Offset getHandleAnchor(
      m.TextSelectionHandleType type, double textLineHeight) {
    return Offset(0, textLineHeight);
  }

  @override
  m.Size getHandleSize(double textLineHeight) {
    return m.Size(0, 0);
  }
}

class MyTextSelectionToolbar extends StatefulWidget {
  BuildContext mainContext;
  MyTextSelectionToolbar({
    Key? key,
    required this.delegate,
    required this.mainContext,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.clipboardStatus,
    this.handleCopy,
    this.handleCut,
    this.handlePaste,
    this.handleSelectAll,
  }) : super(key: key);

  final TextSelectionDelegate delegate;
  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier? clipboardStatus;
  final VoidCallback? handleCopy;
  final VoidCallback? handleCut;
  final VoidCallback? handlePaste;
  final VoidCallback? handleSelectAll;

  @override
  MyTextSelectionToolbarState createState() => MyTextSelectionToolbarState();
}

class MyTextSelectionToolbarState extends State<MyTextSelectionToolbar> {
  NoteEditorModelView noteEditorModelView = Get.find<NoteEditorModelView>();
  CustomTextSelectionControllerModelViews textSelectionModelview =
      Get.put(CustomTextSelectionControllerModelViews());
  double iconSize = SIZE(S: 5, M: 5, L: 5, T: 5, D: 5);

  Color activeColor = Color.fromARGB(255, 183, 24, 0).withOpacity(.8);
  Color normalColor = Colors.black.withOpacity(.5);
  List<Color> colors = [
    Colors.transparent,
    Colors.white,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    print('- custom selection initState');
    // textSelectionModelview
    //     .initSelectionStyle(noteEditorModelView.bodyQuillController);
    // widget.clipboardStatus!.addListener(_onChangedClipboardStatus);
    // widget.clipboardStatus!.update();
  }

  @override
  void didUpdateWidget(MyTextSelectionToolbar oldWidget) {
    // super.didUpdateWidget(oldWidget);
    // if (widget.clipboardStatus != oldWidget.clipboardStatus) {
    //   widget.clipboardStatus!.addListener(_onChangedClipboardStatus);
    //   oldWidget.clipboardStatus!.removeListener(_onChangedClipboardStatus);
    // }
    // widget.clipboardStatus!.update();
  }

  @override
  void dispose() {
    super.dispose();
    globleDelegate = null;
    textSelectionModelview.dispose();
    // if (!widget.clipboardStatus!.disposed) {
    //   widget.clipboardStatus!.removeListener(_onChangedClipboardStatus);
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('- custom selection controlle');
    }
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final List<ToolbarButton> basicTools = <ToolbarButton>[
      if (widget.handleCut != null)
        ToolbarButton(
          label: '',
          icon: Icon(
            Icons.cut_rounded,
            size: iconSize,
          ),
          onPressed: widget.handleCut ?? () {},
        ),
      if (widget.handleCopy != null)
        ToolbarButton(
          label: '',
          icon: Icon(
            Icons.copy_rounded,
            size: iconSize,
          ),
          onPressed: widget.handleCopy ?? () {},
        ),
      if (widget.handlePaste != null &&
          widget.clipboardStatus!.value == ClipboardStatus.pasteable)
        ToolbarButton(
          label: '',
          icon: Icon(
            Icons.paste_rounded,
            size: iconSize,
          ),
          onPressed: widget.handlePaste ?? () {},
        ),
      if (widget.handleSelectAll != null)
        ToolbarButton(
          label: '',
          icon: Icon(
            Icons.select_all_rounded,
            size: iconSize,
          ),
          onPressed: widget.handleSelectAll ?? () {},
        ),
    ];

    // final List<ToolbarButton> listTools = [
    //   // format list bullet
    //   ToolbarButton(
    //       onPressed: () {
    //         noteEditorModelView.setList(listType: ListType.bullet);
    //         setState(() {});
    //       },
    //       label: 'list-bullet',
    //       activeIcon: Icon(
    //         Icons.format_list_bulleted_rounded,
    //         size: iconSize,
    //         color: Color.fromARGB(255, 183, 24, 0).withOpacity(.8),
    //       ),
    //       icon: Icon(
    //         Icons.format_list_bulleted_rounded,
    //         size: iconSize,
    //         color: Colors.black.withOpacity(.5),
    //       ),
    //       noteEditorModelView: noteEditorModelView),
    //   // format list order
    //   ToolbarButton(
    //       onPressed: () {
    //         noteEditorModelView.setList(listType: ListType.ordered);
    //         setState(() {});
    //       },
    //       label: 'list-ordered',
    //       activeIcon: Icon(
    //         Icons.format_list_numbered_rounded,
    //         size: iconSize,
    //         color: Color.fromARGB(255, 183, 24, 0).withOpacity(.8),
    //       ),
    //       icon: Icon(
    //         Icons.format_list_numbered_rounded,
    //         size: iconSize,
    //         color: Colors.black.withOpacity(.5),
    //       ),
    //       noteEditorModelView: noteEditorModelView),
    // ];

    return TextSelectionToolbar(
      anchorAbove: widget.anchorAbove,
      anchorBelow: widget.anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) {
        return AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // basic tools
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ...basicTools.map((ToolbarButton toolbarButton) {
                    return Material(
                      color: Colors.transparent,
                      type: MaterialType.button,
                      // clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: toolbarButton.onPressed,
                        child: Container(
                          padding: EdgeInsets.all(
                            SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5),
                          ),
                          child: toolbarButton.icon,
                        ),
                      ),
                    );
                  }),
                ],
              ),

              // align tools
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...<ToolbarButton>[
                    // Set Direction ltr
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setTextDirection(ltr: true);
                      },
                      label: 'direction-ltr',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_textdirection_l_to_r_rounded,
                          size: iconSize,
                          color: textSelectionModelview.directionLtr.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                    // align-lift
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setAlignLeft();
                      },
                      label: 'align-left',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_align_left_rounded,
                          size: iconSize,
                          color: textSelectionModelview.alginLeft.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                    // align-center
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setAlignCenter();
                      },
                      label: 'align-center',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_align_center_rounded,
                          size: iconSize,
                          color: textSelectionModelview.alginCenter.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                    // align-right
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setAlignRight();
                      },
                      label: 'align-right',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_align_right_rounded,
                          size: iconSize,
                          color: textSelectionModelview.alginRight.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                    // align-justify
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setAlignJustify();
                      },
                      label: 'align-justify',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_align_justify_rounded,
                          size: iconSize,
                          color: textSelectionModelview.alginJustify.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                    // Set Direction rtl
                    ToolbarButton(
                      onPressed: () {
                        noteEditorModelView.setTextDirection(ltr: false);
                      },
                      label: 'direction-rtl',
                      icon: Obx(() {
                        return Icon(
                          Icons.format_textdirection_r_to_l_rounded,
                          size: iconSize,
                          color: textSelectionModelview.directionRtl.value
                              ? activeColor
                              : normalColor,
                        );
                      }),
                    ),
                  ].map((ToolbarButton toolbarButton) {
                    return Material(
                      color: Colors.transparent,
                      // clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: toolbarButton.onPressed,
                        child: Container(
                            padding: EdgeInsets.all(
                              SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5),
                            ),
                            child: toolbarButton.icon),
                      ),
                    );
                  }),
                ],
              ),

              //? list tools
              // Wrap(
              //   alignment: WrapAlignment.center,
              //   children: [
              //     ...listTools.map((ToolbarButton itemData) {
              //       return itemData.advancedWidget ??
              //           Material(
              //             color: Colors.transparent,
              //             type: MaterialType.button,
              //             // clipBehavior: Clip.antiAlias,
              //             child: InkWell(
              //               onTap: itemData.onPressed,
              //               child: Container(
              //                 padding: EdgeInsets.all(
              //                   SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5),
              //                 ),
              //                 child: Stack(
              //                   alignment: Alignment.bottomCenter,
              //                   children: [
              //                     Container(
              //                       width: 20,
              //                       height: 2,
              //                       decoration: BoxDecoration(
              //                           borderRadius:
              //                               BorderRadius.circular(999),
              //                           color: itemData.isActive
              //                               ? const Color.fromARGB(
              //                                       255, 183, 24, 0)
              //                                   .withOpacity(.8)
              //                               : Colors.transparent),
              //                     ),
              //                     (itemData.isActive
              //                         ? itemData.activeIcon!
              //                         : itemData.icon!)
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //     }),
              //   ],
              // ),

              // cusotm tools
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  // alignment: WrapAlignment.start,
                  children: [
                    ...[
                      // clean all style
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.clearSelectionStyle();
                        },
                        label: 'clearStyle',
                        icon: Icon(
                          Icons.format_clear_rounded,
                          size: iconSize,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      // Bold
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionBold();
                        },
                        label: 'bold',
                        icon: Obx(() {
                          return Icon(
                            Icons.format_bold_rounded,
                            size: iconSize,
                            color: textSelectionModelview.bold.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),
                      // italic
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionItalic();
                        },
                        label: 'italic',
                        icon: Obx(() {
                          return Icon(
                            Icons.format_italic_rounded,
                            size: iconSize,
                            color: textSelectionModelview.italic.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),
                      // underline
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionUnderline();
                        },
                        label: 'underline',
                        icon: Obx(() {
                          return Icon(
                            Icons.format_underline_rounded,
                            size: iconSize,
                            color: textSelectionModelview.underline.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),

                      // strick
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionStrick();
                        },
                        label: 'strike',
                        icon: Obx(() {
                          return Icon(
                            Icons.format_strikethrough_rounded,
                            size: iconSize,
                            color: textSelectionModelview.strick.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),
                      // font size
                      ToolbarButton(
                        label: 'size',
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          widget.delegate.hideToolbar(false);
                          showBottomSheet(
                              clipBehavior: Clip.antiAlias,
                              backgroundColor:
                                  const Color.fromARGB(255, 38, 38, 54),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: widget.mainContext,
                              builder: (_) {
                                return FontSize(
                                    selectedFont:
                                        textSelectionModelview.fontSize.value,
                                    noteEditorModelView: noteEditorModelView);
                              });
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.format_size_rounded,
                              size: iconSize,
                              color: Colors.black.withOpacity(.5),
                            ),
                            Obx(() {
                              return m.Text(
                                  '${textSelectionModelview.fontSize.value}',
                                  style: TextStyle(
                                      fontSize: SIZE(
                                          S: 12,
                                          M: 8,
                                          L: 12,
                                          T: 12,
                                          D: 12,
                                          isW: false)));
                            }),
                          ],
                        ),
                      ),
                      // font color
                      ToolbarButton(
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          widget.delegate.hideToolbar(false);
                          showBottomSheet(
                              clipBehavior: Clip.antiAlias,
                              backgroundColor:
                                  const Color.fromARGB(255, 38, 38, 54),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: widget.mainContext,
                              builder: (_) {
                                return Container(
                                    width: double.infinity,
                                    child: BlockPicker(
                                      availableColors: colors,
                                      pickerColor: Color(textSelectionModelview
                                          .fontColor.value),
                                      onColorChanged: (Color newColor) {
                                        noteEditorModelView.setFontColor(
                                            newColor: newColor);
                                      },
                                      layoutBuilder: (context, colors, child) {
                                        return CustomColorPicker(
                                            isFont: true,
                                            noteEditorModelView:
                                                noteEditorModelView,
                                            selectedColor: Color(
                                                textSelectionModelview
                                                    .fontColor.value));
                                      },
                                    ));
                              });
                        },
                        label: 'color',
                        icon: Obx(() {
                          return m.Icon(
                            Icons.format_color_text_rounded,
                            size: iconSize,
                            color: textSelectionModelview.fontColor.value !=
                                    Colors.white.value
                                ? Color(textSelectionModelview.fontColor.value)
                                : normalColor,
                          );
                        }),
                      ),

                      // font background color

                      ToolbarButton(
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          widget.delegate.hideToolbar(false);
                          showBottomSheet(
                              clipBehavior: Clip.antiAlias,
                              backgroundColor:
                                  const Color.fromARGB(255, 38, 38, 54),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: widget.mainContext,
                              builder: (_) {
                                return BlockPicker(
                                  availableColors: colors,
                                  pickerColor: Color(textSelectionModelview
                                      .fontBackgroundColor.value),
                                  onColorChanged: (Color newColor) {
                                    noteEditorModelView.setFontColor(
                                        newColor: newColor);
                                  },
                                  layoutBuilder: (context, colors, child) {
                                    return CustomColorPicker(
                                        isFont: false,
                                        noteEditorModelView:
                                            noteEditorModelView,
                                        selectedColor: Color(
                                            textSelectionModelview
                                                .fontBackgroundColor.value));
                                  },
                                );
                              });
                        },
                        label: 'backgroundColor',
                        icon: Obx(() {
                          return m.Icon(
                            Icons.format_color_fill_rounded,
                            size: iconSize,
                            color: textSelectionModelview
                                        .fontBackgroundColor.value !=
                                    0
                                ? Color(textSelectionModelview
                                    .fontBackgroundColor.value)
                                : normalColor,
                          );
                        }),
                      ),

                      // font family
                      ToolbarButton(
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          widget.delegate.hideToolbar(true);
                          FontFamilyModelView fontFamilyModelView =
                              Get.find<FontFamilyModelView>();
                          fontFamilyModelView.handelFontFamilySheet(
                              textSelectionModelview.fontFamily.value);
                        },
                        label: 'font',
                        icon: Obx(() {
                          return m.Text(
                            'font family',
                            style: GoogleFonts.asMap().containsKey(
                                    textSelectionModelview.fontFamily.value)
                                ? GoogleFonts.getFont(
                                    textSelectionModelview.fontFamily.value,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SIZE(
                                            S: 10,
                                            M: 10,
                                            L: 10,
                                            T: 10,
                                            D: 10,
                                            isW: false),
                                        color: Colors.black.withOpacity(.5)))
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        textSelectionModelview.fontFamily.value,
                                    fontSize: SIZE(
                                        S: 10,
                                        M: 10,
                                        L: 10,
                                        T: 10,
                                        D: 10,
                                        isW: false),
                                    color: Colors.black.withOpacity(.5)),
                          );
                        }),
                      ),

                      // code-block
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionCode();
                        },
                        label: 'code-block',
                        icon: Obx(() {
                          return Icon(
                            Icons.code_rounded,
                            size: iconSize,
                            color: textSelectionModelview.codeBlock.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),

                      // blockquote
                      ToolbarButton(
                        onPressed: () {
                          noteEditorModelView.setSelectionQuote();
                        },
                        label: 'blockquote',
                        icon: Obx(() {
                          return Icon(
                            Icons.format_quote_rounded,
                            size: iconSize,
                            color: textSelectionModelview.blockQuote.value
                                ? activeColor
                                : normalColor,
                          );
                        }),
                      ),
                    ].map((ToolbarButton toolbarButton) {
                      return Material(
                        color: Colors.transparent,
                        type: MaterialType.button,
                        // clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: toolbarButton.onPressed,
                          child: Container(
                              padding: EdgeInsets.all(
                                SIZE(S: 2.5, M: 2.5, L: 2.5, T: 2.5, D: 2.5),
                              ),
                              child: toolbarButton.icon),
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        );
      },
      children: const [
        m.Text('data')
      ], // not important but widget should take this children
    );
  }
}

class ToolbarButton {
  ToolbarButton({
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  Widget icon;
  String label;
  VoidCallback onPressed;
}
