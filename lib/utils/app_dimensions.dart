// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DeviceSize { large, medium, small }

class AppDimensions extends GetxController {
  static double safeBlockMinUnit = 0;
  static double boarderRadius = 10;
  static bool isHightScreen = true;

  void init(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);

    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;

    var _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    var _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    var safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    var safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    safeBlockMinUnit = safeBlockHorizontal > safeBlockVertical
        ? safeBlockVertical
        : safeBlockHorizontal;
    isHightScreen = (safeBlockHorizontal <= safeBlockVertical);
  }


  Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  double getSafeBlockSizeHorizontal(BuildContext context) {
    var _mq = MediaQuery.of(context);
    return (_mq.size.width - (_mq.padding.left + _mq.padding.left)) / 100;

  }

  double getSafeBlockSizeVertical(BuildContext context) {
    var _mq = MediaQuery.of(context);
    return (_mq.size.height - (_mq.padding.top + _mq.padding.bottom)) / 100;

  }

  DeviceSize getDeviceSize(BuildContext context) {
    var _mq = MediaQuery.of(context);
    var _width = _mq.size.width;
    if (_width < 500) {
      return DeviceSize.small;
    } else if (_width < 800) {
      return DeviceSize.medium;
    } else {
      return DeviceSize.large;
    }
  }

  bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  double getFontTitle(BuildContext context) {
   
    switch (getDeviceSize(context)) {
      case DeviceSize.small:
        return 24;
      case DeviceSize.medium:
        return 28;
      default:
        return 32;
    }
  }

  double getFontSubTitle(BuildContext context) {
  
    switch (getDeviceSize(context)) {
      case DeviceSize.small:
        return 16;
      case DeviceSize.medium:
        return 18;
      default:
        return 24;
    }
  }

  double getFontNormal(BuildContext context) {
  
    switch (getDeviceSize(context)) {
      case DeviceSize.small:
        return 14;
      case DeviceSize.medium:
        return 20;
      default:
        return 24;
    }
  }

  double getIconWidth(BuildContext context) {
    switch (getDeviceSize(context)) {
      case DeviceSize.small:
        return 13;
      case DeviceSize.medium:
        return 20;
      default:
        return 24;
    }
  }

  double getIconSize(BuildContext context) {
     switch (getDeviceSize(context)) {
      case DeviceSize.small:
        return safeBlockMinUnit * 6;
      case DeviceSize.medium:      
      default:
        return safeBlockMinUnit * 8;
    }   
  }
}
