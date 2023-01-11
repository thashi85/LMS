import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../utils/app_dimensions.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final _dimension = Get.find<AppDimensions>();
  
  NoDataWidget({ Key? key,required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _dataNotFound(context);
  }

  Widget _dataNotFound(BuildContext context) {
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _subFont = _dimension.getFontSubTitle(context);
    //var _subNormal = _dimension.getFontNormal(context);
    return Container(
      width: _w*100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.boarderRadius / 2),
        ),
        shadowColor: ColorConstants.lightBackground2Color,
        elevation: 15,
        child: ClipPath(

            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.boarderRadius / 2))),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: ColorConstants.primaryThemeColor, width: _w * 3)),
                color: ColorConstants.lightBackground1Color,
              ),
              margin: EdgeInsets.only(top: AppDimensions.safeBlockMinUnit * 15),
              padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit * 5),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                 const Icon(Icons.no_backpack_outlined,
                          color: Colors.blueGrey),
                      SizedBox(
                        width: _w * 2,
                      ),
                      Expanded(child: Text(message,style: AppTextStyle.secondaryLightBold( size: _subFont))),
                ],
              ),
            )),
      ),
    );
  }
}