import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
//fill in the screen size of the device in the design

//default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  static height(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }

  static getScreenHeight(double value) {
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidth(double value) {
    return ScreenUtil.screenWidthDp;
  }
}
