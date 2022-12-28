import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_style.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/app_dimensions.dart';

class StudentSummary extends StatelessWidget {
  final int index;
  StudentSummary({ Key? key ,required this.index}) : super(key: key);
  final _dimension = Get.find<AppDimensions>();
  @override
  Widget build(BuildContext context) {
     _dimension.init(context);
      var _h = _dimension.getSafeBlockSizeVertical(context);
      var _w = _dimension.getSafeBlockSizeHorizontal(context);
      var _subFont = _dimension.getFontSubTitle(context);
      var _subNormal = _dimension.getFontNormal(context);
      
      return GetBuilder<AuthController>(
              builder: ((_authController){   
                      var _student=_authController.selectedStudent();
                      //print(_student!.webImage);
                      return _student==null ? Container() :
                       Container(
                        //height: _h*15,
                        color: ColorConstants.secondaryThemeColor,
                        padding: EdgeInsets.only(left: AppDimensions.safeBlockMinUnit),
                        child:  Row(
                              children: [
                                Container(
                                  width:AppDimensions.safeBlockMinUnit*25,
                                  height: AppDimensions.safeBlockMinUnit*25,
                                  padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((220)),
                                    color: ColorConstants.whiteBackgroundColor
                                  ),
                                  child: (_student.webImage!="") ?
                                  CircleAvatar(
                                    backgroundColor:Colors.transparent,

                                    //backgroundImage: Image.network(_student.webImage??"",height: 150,scale: 0.7,fit: BoxFit.fitHeight,).image,// NetworkImage(_student.webImage??"",scale: 0.5),
                                    radius: 200,
                                    child: Container(                                      
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                        image: DecorationImage(
                                          image: Image.network(_student.webImage??"").image,
                                          fit: BoxFit.cover)
                                      ),
                                    ),
                                  )
                                  :
                                  const CircleAvatar(backgroundColor: ColorConstants.whiteBackgroundColor,                
                                    backgroundImage: AssetImage('assets/images/student-icon.png'),
                                    radius: 220,),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*3),    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            Text((_student.name??""),
                                            style:  AppTextStyle.primaryLightBold(size: _subFont),
                                            softWrap: true,maxLines: 2,overflow: TextOverflow.visible,
                                            )               
                                          ],
                                        ),
                                        SizedBox(height: _h*2),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: _w*30,
                                              child:  Text((_student).studentRef,style:  AppTextStyle.primaryLightRegular(size: _subNormal))                                
                                            ),
                                            SizedBox(
                                              width: _w*30,                                                           
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [                 
                                                  Text( ((_student).className ) +" "+(_student).section,style:  AppTextStyle.primaryLightRegular(size: _subNormal)),                  
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                                           
                              ],
                            ),
                        
                        
                      );
              }
              ));
  }

 
}