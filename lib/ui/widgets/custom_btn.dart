
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';

import '../../utils/app_dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? txtColor;
  final Color? bgColor;
  final Color? shadowColor;
  final bool isloading;
  final Function onTap;
  final _dimension = Get.find<AppDimensions>();

 

  CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.txtColor,
      this.bgColor,
      this.shadowColor,
      this.isloading=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _normalFont = _dimension.getFontNormal(context);

    return GestureDetector(
      onTap: () => {onTap()},
      child: PhysicalModel(
        color: Colors.grey.withOpacity(.4),
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
                   
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.safeBlockMinUnit*5),
              color: bgColor ?? Colors.black,
            ),
           
           child: isloading?  const Center(
              child: SizedBox(
                  child:  CircularProgressIndicator(color: ColorConstants.secondaryThemeColor),                 
                  height: 40,
                  width: 40,
                ))
            :
            Container(
              //margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: 
              Text( text, style:AppTextStyle.primaryLightRegular(size: _normalFont*1 ,color: txtColor ?? Colors.white )
                )
              
            )
        )
      ),
    );
  }
}