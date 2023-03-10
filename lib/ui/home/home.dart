import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../ui/widgets/user_info.dart';
import '../../utils/route_handler.dart';
import '../widgets/drawer.dart';

import '../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';

class HomePage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _homeController = Get.find<HomeController>();
  
  final _pageController=PageController();
  int selectedPage=0;


  HomePage({ Key? key }) : super(key: key){
    _homeController.getSliderImages();
   
    Timer.periodic(const Duration(seconds: 3), (timer) { 
          if(selectedPage==_homeController.sliderImages.length){
            selectedPage=0;
            if(_pageController.hasClients){
              _pageController.jumpTo(0);
            }
          }else{
            selectedPage++;
            _pageController.animateToPage(selectedPage,duration: const Duration(seconds: 1), curve: Curves.decelerate);
          }
         
    });
  }

  @override
  Widget build(BuildContext context) {

     
    
    _dimension.init(context);
  
   
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          isRepeatingAnimation: true,repeatForever: true,
            animatedTexts: [
              TyperAnimatedText('St.Joseph International College'
                  ,speed: const Duration(milliseconds: 100)),             
            ]
    ),
      ),
      body: SharedComponentUI. calenderTopLayoutUI(context, _dimension, Column(
        children: [ 
           UserInfo(),           
          !_dimension.isWideDevice(context)?   _homePortraitContent(context):_homeLandscapeContent(context)
        ],
      )),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: ColorConstants.secondaryThemeColor,
          ), // sets the inactive color of the `BottomNavigationBar`
          child:SharedComponentUI.bottomNavigationContent()
        ),
       drawer:DrawerMenu() ,
    );
  }

  Widget _homePortraitContent(BuildContext context) {
    var _h = _dimension.getSafeBlockSizeVertical(context);
    return Column(
         
          children: [
            _imageSlider(context),
             SizedBox(height: _h*3,),
            _menuContentPortrait(context),
          ],
        );
  }
  Widget _homeLandscapeContent(BuildContext context) {
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: _w*49,
              child:   Column(
                children: [                 
                  _imageSlider(context),
                ],
              ),
            ),          
             SizedBox(width: _w*2,),
              SizedBox(
              width: _w*49,
              child:   _menuContentPortrait(context),
            ),    
           
          ],
        );
  }
   Widget _menuContent(BuildContext context) {
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(      
                mainAxisAlignment: MainAxisAlignment.spaceBetween,          
                children: [
                    _menuItemContent(context,"Attendance",const Icon(Icons.access_alarm_sharp,color: Colors.white),const Color.fromARGB(255, 43, 150, 114),const Color.fromARGB(255, 51, 83, 132),()=> RouteHandler.redirectToAttendance()),
                    _menuItemContent(context,"Homework",const Icon(Icons.home_work_outlined,color: Colors.white),const Color.fromARGB(255, 124, 163, 159),const Color.fromARGB(255, 57, 61, 83),()=>RouteHandler.redirectToHomework())
                ],
              ),
               Row(      
                mainAxisAlignment: MainAxisAlignment.spaceBetween,          
                children: [
                    _menuItemContent(context,"Notices",const Icon(Icons.notifications_active_outlined,color: Colors.white,),Colors.orangeAccent,Colors.brown,()=>RouteHandler.redirectToNotices()),
                    _menuItemContent(context,"Payment",const Icon(Icons.payments_outlined,color: Colors.white),const Color.fromARGB(255, 233, 180, 139),const Color.fromARGB(255, 97, 10, 11),()=>RouteHandler.redirectToPayment())
                ],
              )
            ],
          )
    );
   
   }
  Widget _menuContentPortrait(BuildContext context) {
     var _w = _dimension.getSafeBlockSizeHorizontal(context);
     //var _h = _dimension.getSafeBlockSizeVertical(context);
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                spacing: _w,
                //runSpacing: _h,
                children: [
                   _menuItemContent(context,"Attendance",const Icon(Icons.access_alarm_sharp,color: Colors.white),const Color.fromARGB(255, 43, 150, 114),const Color.fromARGB(255, 51, 83, 132),()=> RouteHandler.redirectToAttendance()),
                   _menuItemContent(context,"Homework",const Icon(Icons.home_work_outlined,color: Colors.white),const Color.fromARGB(255, 124, 163, 159),const Color.fromARGB(255, 57, 61, 83),()=>RouteHandler.redirectToHomework()),
                  
                   _menuItemContent(context,"Notices",const Icon(Icons.notifications_active_outlined,color: Colors.white,),Colors.orangeAccent,Colors.brown,()=>RouteHandler.redirectToNotices()),
                   _menuItemContent(context,"Payment",const Icon(Icons.payments_outlined,color: Colors.white),const Color.fromARGB(255, 233, 180, 139),const Color.fromARGB(255, 97, 10, 11),()=>RouteHandler.redirectToPayment())
                   
                ],
              ),
            ],
          )
    );
   
   }

  Widget _menuItemContent(BuildContext context,String text,Icon icon,Color color1,Color color2,Function onclick) {
     var _w = _dimension.getSafeBlockSizeHorizontal(context);
     var _h = _dimension.getSafeBlockSizeVertical(context);
     var _isWideDevice = _dimension.isWideDevice(context);
     var _subTitle = _dimension.getFontSubTitle(context);
   //  var _normalFont = _dimension.getFontNormal(context);
     var _buttonwidth=!_isWideDevice ? _w*92/2: (_w*48/2) ;
    return  GestureDetector(
          onTap: () =>onclick() ,
          child:   Container(     
                    width:_buttonwidth<150 ? 150:(((_w*100)<=412) ?150:_buttonwidth),
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical:_h*2,horizontal: _w*2 ),
                    decoration:  BoxDecoration(           
                                gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                      color1,color2                            
                                      ],
                                    ),  
                                border: Border.all(color: ColorConstants.lightBackground2Color,width: 3),     
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.secondaryThemeColor.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: _w*2),
                              icon,
                              SizedBox(width: _w*2),
                              Text(text,style:  AppTextStyle.primaryLightBold(size: _isWideDevice ? _subTitle:_subTitle*0.75))
                            ],
                          ),
          )
    );
   
   }

  Widget _imageSlider(BuildContext context) {
    var _h = _dimension.getSafeBlockSizeVertical(context);
      return GetBuilder<HomeController>(builder: ((controller) => 
        SizedBox(                  
                    height: _h*35,
                     child: 
                      PageView.builder(
                        itemCount:_homeController.sliderImages.length,
                        scrollDirection: Axis.horizontal,  
                        controller: _pageController,                     
                        itemBuilder: (context, index) =>                     
                            _sliderImageContent(context,index),
                      ), 
                   )
  
      ));
  }
 Widget _sliderImageContent(BuildContext context,int index){
  return Container(
  margin:EdgeInsets.all(AppDimensions.safeBlockMinUnit*2),
 
  width: double.infinity,
  decoration: BoxDecoration(    
    image: DecorationImage(
      image:  NetworkImage(_homeController.sliderImages[index].url),
      fit: BoxFit.cover
    ),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 228, 224, 224).withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
  ),
);
 }
  

}
