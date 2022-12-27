import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/widgets/sliding_datepicker.dart';
import '../../ui/widgets/student_slider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/student_controller.dart';
import '../../ui/widgets/attendance_list.dart';
import '../../constants/colors.dart';

import '../widgets/drawer.dart';
import '../../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';

class AttendancePage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _studentController = Get.find<StudentController>();
  final _authController = Get.find<AuthController>();

  final _currentYear=DateTime.now().year;

  AttendancePage({ Key? key }) : super(key: key) {    
    _studentController.selectedYear ??= (_currentYear.toString());   
   
  }
  
 
  @override
  Widget build(BuildContext context) {
    
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    //var _w = _dimension.getSafeBlockSizeHorizontal(context);
    
   return Scaffold(
              appBar: AppBar(
                title: const Text("Attendance"),
              ),
              body: SharedComponentUI. calenderTopLayoutUI(context, _dimension,    
                      (_authController.loggedInUser==null)  ? 
                      const CircularProgressIndicator(color: ColorConstants.secondaryThemeColor):
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StudentSlider(onStudentChange: dateChange),
                          SizedBox(height: _h*2),                         
                           GetBuilder<StudentController>(
                              id:"studentAttendance",
                              builder: (controller) => Column(
                              children: [
                                SlidingDatePicker(onDateChange: dateChange),
                                AttendanceList()
                              ],
                            )),
                        ],
                      ),
                    
              ),
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
  dateChange(){
    _studentController.refreshData(["studentAttendance"]);
  }

 
}

  

