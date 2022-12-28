
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/student_controller.dart';

import '../../utils/app_dimensions.dart';

class MonthMenu extends StatelessWidget {
  final double width;
  final Function? onDateChange;
  int? selectedIndex;

  final _dimension = Get.find<AppDimensions>();
  final _studentController = Get.find<StudentController>();
  ScrollController _scrollController=ScrollController();
  final List<String> categories = [
    "JAN", "FEB", "MAR","APR", "MAY", "JUN",  "JUL",  "AUG","SEP", "OCT", "NOV","DEC"
  ];
  // By default our first item will be selected
  
  MonthMenu({Key? key,required this.width, this.selectedIndex,this.onDateChange}) : super(key: key){     
       // selectedIndex=selectedIndex ?? DateTime.now().month-1;
       if(selectedIndex!=null){
        _scrollController=ScrollController(initialScrollOffset:(width/6)*selectedIndex!);
         _studentController.selectedMonth=selectedIndex;
       }
       if(_studentController.selectedMonth!=selectedIndex){
         _studentController.selectedMonth=selectedIndex;
       }
  }  
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.safeBlockMinUnit*2),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller:_scrollController ,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildMonths(context, index),
        ),
      ),
    );
  }

  Widget buildMonths(BuildContext context, int index) {
    // var _w = _dimension.getSafeBlockSizeHorizontal(context);
    return GestureDetector(
      onTap: () {
        selectedIndex = index;
        if(selectedIndex!=null && _studentController.selectedMonth!=selectedIndex){
         _studentController.changeSelectedMonth(selectedIndex!);
          if(onDateChange!=null){
                    onDateChange!();
                  }
        }
      },
      child: SizedBox(
        width: width/6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.safeBlockMinUnit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _dimension.getFontSubTitle(context),
                  color: selectedIndex == index
                      ? ColorConstants.primaryThemeColor
                      : ColorConstants.lightAshBackgroundColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: AppDimensions.safeBlockMinUnit*2 / 4), //top padding 5
                height: 2,
                width:width /6,
                // width: 30,
                color: selectedIndex == index
                    ? ColorConstants.primaryThemeColor
                    : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}