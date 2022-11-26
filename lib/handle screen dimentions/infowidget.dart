import 'dart:io';

import 'package:flutter/material.dart';

late DeviceInfo info;

String? deviceDetails(
    {required BoxConstraints constraints, required Orientation orientation}) {
  // print(orientation);
  late double width;
  if (Platform.isAndroid || Platform.isIOS) {
    width = orientation == Orientation.landscape
        ? constraints.maxHeight
        : constraints.maxWidth;
  } else {
    width = constraints.maxWidth;
  }
  if (width >= 950) {
    return 'desktop';
  } else if (width > 600) {
    return 'tablet';
  } else if (width < 360) {
    return 'small';
  } else if (width < 480) {
    return 'medium';
  } else if (width < 600) {
    return 'large';
  }
  return null;
}

class DeviceInfo {
  final String deviceType;
  final double height;
  final double width;
  final double localWidth;
  final double localHeight;
  final Orientation orientation;

  DeviceInfo(
      {required this.deviceType,
      required this.height,
      required this.width,
      required this.localHeight,
      required this.localWidth,
      required this.orientation});
}

class HandleScreenDimensions extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo info) builder;

  const HandleScreenDimensions({Key? key, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, Orientation orientation) {
      return LayoutBuilder(builder: (context, BoxConstraints constraints) {
        var infoDevice = DeviceInfo(
          orientation: orientation,
          deviceType: deviceDetails(
              constraints: constraints, orientation: orientation)!,
          height: Platform.isAndroid || Platform.isIOS
              ? orientation == Orientation.landscape
                  ? constraints.maxWidth
                  : constraints.maxHeight
              : constraints.maxHeight,
          width: Platform.isAndroid || Platform.isIOS
              ? orientation == Orientation.landscape
                  ? constraints.maxHeight
                  : constraints.maxWidth
              : constraints.maxWidth,
          localHeight: constraints.maxHeight,
          localWidth: constraints.maxWidth,
        );
        return builder(context, infoDevice);
      });
    });
  }
}


/// M medium,
/// L large,
/// T tablet,
/// D desktop,
/// isW isWidget,
/// constWith_D const with desktop,
///  constWithAllNotOn_D , const for the same size in all platform [ not working for now ],
double SIZE({
  /// just with widget
  required double S,
  required double M,
  required double L,
  required double T,
  required double D,
  bool isW = true,
  bool Const = false,
  bool withWidth = true,
  bool constWith_D = false,
  // bool constWithAllNotOn_D = false,
}) {
  double width = withWidth ? info.width : info.height;
  switch (info.deviceType) {
    case 'small':
      {
        if (Const)
          return S;
        else if (isW)
          return S * width / 100;
        else
          return S * (width / 3) / 100;
      }
    case 'large':
      {
        if (Const)
          return L;
        else if (isW)
          return L * width / 100;
        else
          return L * (width / 3) / 100;
      }
    case 'medium':
      {
        if (Const)
          return M;
        else if (isW)
          return M * width / 100;
        else
          return M * (width / 3) / 100;
      }
    case 'tablet':
      {
        if (Const)
          return T;
        else if (isW)
          return T * width / 100;
        else
          return T * (width / 3) / 100;
      }
    case 'desktop':
      {
        if (Const || constWith_D)
          return D;
        else if (isW)
          return D * width / 100;
        else
          return D * (width / 3) / 100;
      }
    default:
      return 0.0;
  }
}
