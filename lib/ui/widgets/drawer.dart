import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../utils/app_dimensions.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/route_handler.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);
  final _dimension = Get.find<AppDimensions>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _subFont = _dimension.getFontSubTitle(context);
    var _subNormal = _dimension.getFontNormal(context);
    var _user=_authController.getUser();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorConstants.primaryThemeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: _h * 15,
                    width: _w * 20,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteBackgroundColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimensions.safeBlockMinUnit * 2)),
                    ),
                    child: Container(
                      //child: Text("Greens Express"),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/logo-white-1.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: _h,horizontal: _w*3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text( _user?.name ??"",style:  AppTextStyle.primaryLightBold(size: _subFont)),
                        SizedBox(height: _h),
                        Text(_user?.email ??"",style:  AppTextStyle.primaryLightRegular(size: _subNormal)),
                         SizedBox(height: _h),
                        Text( _user?.phone ??"",style:  AppTextStyle.primaryLightRegular(size: _subNormal))
                      ]
                      
                    ),
                  ))
                ],
              )

              // Text('Greens Express'),
              ),
          Container(
            color: ColorConstants.secondaryThemeColor,
            height: _h * 85,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                
                ListTile(
                  title: Row(
                    children: [
                      const Icon(Icons.access_alarm_sharp,color: Colors.white),
                      SizedBox(width: _w*2),
                      Text('Attendance',style:  AppTextStyle.primaryLightBold(size: _subFont))      
                    ],
                  ) ,
                  onTap: () {
                    RouteHandler.redirectToAttendance();                  
                  },
                ),
                ListTile(
                  title:  Row(
                    children: [
                      const Icon(Icons.notifications_active_outlined,color: Colors.white),
                      SizedBox(width: _w*2),
                      Text('Notices',style:  AppTextStyle.primaryLightBold(size: _subFont)),     
                    ],),                    
                  onTap: () {
                  RouteHandler.redirectToNotices();
                  },
                ),
                ListTile(
                  title:  Row(
                    children: [
                      const Icon(Icons.home_work_outlined,color: Colors.white),
                      SizedBox(width: _w*2),
                      Text('Homewoks',style:  AppTextStyle.primaryLightBold(size: _subFont)), 
                    ],
                  ),
                  onTap: () {
                   RouteHandler.redirectToHomework();
                  },
                ),
                ListTile(
                  title:  Row(
                    children: [
                      const Icon(Icons.payments_outlined,color: Colors.white),
                      SizedBox(width: _w*2),
                      Text('Payments',style:  AppTextStyle.primaryLightBold(size: _subFont)),      
                    ],
                  ),
                  onTap: () {
                  RouteHandler.redirectToPayment();
                  },
                ),
                ListTile(
                  title:   Row(
                    children: [
                      const Icon(Icons.logout_outlined,color: Colors.white),
                      SizedBox(width: _w*2),
                     Text('Sign out',style:  AppTextStyle.primaryLightBold(size: _subFont)),
                    ],
                  ),
                  onTap: () {
                    _authController.signOut();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
