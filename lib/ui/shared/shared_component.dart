import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/text_style.dart';
import '../../utils/app_dimensions.dart';

class SharedComponentUI {
  static Widget mainLogoLayoutUI(
      BuildContext context, AppDimensions appDimensionService, Widget? child) {
/*     var _horizontalBlockSize =
        appDimensionService.getSafeBlockSizeHorizontal(context); */
    var _verticalBlockSize =
        appDimensionService.getSafeBlockSizeVertical(context);
    var _isWideDevice =
        appDimensionService.isWideDevice(context);
    var _fontTitle = appDimensionService.getFontTitle(context);

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: _verticalBlockSize * 4, bottom: _verticalBlockSize),
                  height: _verticalBlockSize * 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/lms_bg.png"),
                    fit: BoxFit.fill,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: _verticalBlockSize * 15,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/logo-white-1.png"),
                            fit: BoxFit.fitHeight,
                          ))),

                      _isWideDevice ? 
                      ( Text("St.Joseph International College",
                            style:
                                AppTextStyle.secondaryDarkBold(size: _fontTitle))) :
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text("St.Joseph International",
                            style:
                                AppTextStyle.secondaryDarkBold(size: _fontTitle)),
                        Text("College",
                            style:
                                AppTextStyle.secondaryDarkBold(size: _fontTitle))
                        ],
                      )
                      
                    ],
                  )),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [child ?? Container()],
                ),
              ))
            ],
          ),
        ),
        // optimoFooter(_istab)
      ],
    ));
  }

  static Widget calenderTopLayoutUI(
      BuildContext context, AppDimensions appDimensionService, Widget? child) {
    // var _w =appDimensionService.getSafeBlockSizeHorizontal(context);
    // var _h =appDimensionService.getSafeBlockSizeVertical(context);
    // var _fontTitle = appDimensionService.getFontTitle(context);

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [child ?? Container()],
          ),
        ))
        // optimoFooter(_istab)
      ],
    ));
  }

  static BottomNavigationBar bottomNavigationContent() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFFFFFFFF),
            ),
            label: ""),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            color: Color(0xFFFFFFFF),
          ),
          label: "",
        )
      ],
      onTap: (index) => {
        if (index == 0) {Get.toNamed('/home')}
      },
      currentIndex: 1,
    );
  }

  static SnackBar getSnackBarComponent(BuildContext context,
      AppDimensions appDimensionService, MessageType type, String message) {
    var _w = appDimensionService.getSafeBlockSizeHorizontal(context);
    return SnackBar(
      backgroundColor: getMessageBGColor(type),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Text(message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(color: Colors.white)))
        ],
      ),
      duration: const Duration(milliseconds: 3000),
      width: _w * 95, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0, // Inner padding for SnackBar content.
        vertical: 12.0,
      ),
      
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  static Color getMessageBGColor(MessageType type) {
    switch (type) {
      case MessageType.error:
        return ColorConstants.failedMessageBackgroundColor;
      case MessageType.warning:
        return ColorConstants.warnMessageBackgroundColor;
      case MessageType.info:
        return ColorConstants.infoMessageBackgroundColor;
      case MessageType.success:
      default:
        return ColorConstants.successMessageBackgroundColor;
    }
  }
}
