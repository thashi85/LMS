import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/student_controller.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/date_utility.dart';
import 'month_menu.dart';
import 'weekly_date_picker.dart/date_picker_widget.dart';

class SlidingDatePicker extends StatelessWidget {
  final bool showDateSelection;
  final Function? onDateChange;
  final _dimension = Get.find<AppDimensions>();
  final _studentController = Get.find<StudentController>();
 
  List<String> _years=[];
  final _currentYear=DateTime.now().year;
  
  SlidingDatePicker({ Key? key,this.showDateSelection=true,this.onDateChange }) : super(key: key){
    
    for(var i=-5;i<1;i++){
      _years.add((_currentYear+i).toString());
    }
  }
  

  @override
  Widget build(BuildContext context) {
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    

    return Column(
      children: [
         Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              _yearSelectionContent(_w, context),
              Expanded(child: MonthMenu(width:  _w*73,selectedIndex:_studentController.selectedMonth?? DateTime.now().month-1,onDateChange: onDateChange))
              ]),
            
            Visibility(
              visible: showDateSelection==true,
              child: 
              (_studentController.selectedYear==null || _studentController.selectedMonth==null) ? 
              const CircularProgressIndicator(color: ColorConstants.secondaryThemeColor):
              DatePicker(
                DateUtility.firstDayOfMonth(int.parse(_studentController.selectedYear!), _studentController.selectedMonth!+1),
                width:(_w*100)/7,
                height:(_h*10),
                daysCount: DateUtility.lastDayOfMonth(int.parse(_studentController.selectedYear!), _studentController.selectedMonth!+1),
                selectedTextColor: ColorConstants.primaryLightTextColor,
                selectionColor: ColorConstants.primaryThemeColor,   
              //  initialSelectedDate: DateTime.now(),                
                onDateChange: (date) {
                  // New date selected
                  if(date.day!=_studentController.selectedDate){
                  _studentController.changeSelectedDate(date.day);
                  }
                  else{
                      _studentController.changeSelectedDate(0);
                  }
                  if(onDateChange!=null){
                    onDateChange!();
                  }
                  //print(date.month.toString());
                  //print(date.day.toString());
                },
                showMonth: false,
              ),
            ),
                          
      ],
    );
  }
  
  Container _yearSelectionContent(double _w, BuildContext context) {
    return Container(
                    width: _w*16,  
                   // margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(left: _w,bottom:AppDimensions.safeBlockMinUnit*3),
                    child: DropdownButton<String>(
                          focusColor:Colors.white,
                          value:(_studentController.selectedYear??_currentYear).toString(),
                          isDense: true,
                          //elevation: 5,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _dimension.getFontNormal(context),
                            color:  ColorConstants.lightAshBackgroundColor,
                          ),
                          iconEnabledColor:Colors.black,
                          items:_years.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style:const TextStyle(color:Colors.black)),
                            );
                          }).toList(),                           
                          onChanged: (String? value) {
                            if(value!=null && value!=_studentController.selectedMonth.toString())   {
                              _studentController.changeSelectedYear(value);
                              if(onDateChange!=null){
                                onDateChange!();
                              }
                            }                       
                                                                                    
                          },
                        ),
                  );
  }
}