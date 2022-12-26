import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/constants/text_style.dart';
import 'package:lms/controllers/auth_controller.dart';

import '../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';

class SplashPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  SplashPage({ Key? key }) : super(key: key){
  waitAndNavigate();
  }
 
 void waitAndNavigate() async{
     await Future.delayed(const Duration(seconds: 5));
    _authController.setInitialScreen();
 }

  @override
  Widget build(BuildContext context) {
 
    var _dimension = Get.find<AppDimensions>();
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);    
   // var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _titleFont = _dimension.getFontTitle(context);
    
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("St.Joseph International College"),
      // ),
      body: SharedComponentUI. mainLogoLayoutUI(context, _dimension,  
      Column(
        children: [
          Container(                       
                          height: _h*45,                           
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/favpng_student-education-clip-art.png"),
                              fit: BoxFit.fitHeight,
                          )
                        )
                  ),
            SizedBox(height: _h*5,),   
            Text("WELCOME",style: AppTextStyle.secondaryLightBold(size: _titleFont)),
                    
            
        ],
      ))
     
    );
  }
}