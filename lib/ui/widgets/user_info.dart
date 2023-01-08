import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_dimensions.dart';

class UserInfo extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _authController = Get.find<AuthController>();

  UserInfo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _userInfoSection(context);
  }

  
  Widget _userInfoSection(BuildContext context){
     _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    //var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _titleFont = _dimension.getFontTitle(context);
    var _subNormal = _dimension.getFontNormal(context);
      return  _authController.loggedInUser==null ? Container():
                      Container(
                        //height: _h*15,
                        color: ColorConstants.primaryThemeColor,
                        child: Row(
                          children: [                           
                            Container(
                              //width: _w*40,   
                              padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),           
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hi, "+(_authController.loggedInUser!.name??""),style:  AppTextStyle.primaryLightBold(size: _titleFont)),
                                  SizedBox(height: _h),
                                  Text((_authController.loggedInUser!.email??""),style:  AppTextStyle.primaryLightRegular(size: _subNormal)),                  
                                ],
                              ),
                            ),
                        /*     Container(
                              width: _w*40,  
                              padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),            
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                 
                                  Text( ((_student).grade ) +" "+(_student).section,style:  AppTextStyle.primaryLightRegular(size: _subNormal)),                  
                                ],
                              ),
                            ), */
                          ],
                        ),
                      );
     
  }
}
