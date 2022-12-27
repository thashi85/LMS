import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user.dart';
import '../../utils/app_dimensions.dart';
import '../widgets/student_summary.dart';


class StudentSlider extends StatelessWidget {
  final Function? onStudentChange;
  final _dimension = Get.find<AppDimensions>();
  final _authController = Get.find<AuthController>();
  final _pageController=PageController(viewportFraction: 1, initialPage:0);

  StudentSlider({ Key? key,this.onStudentChange }) : super(key: key){
     _pageController.addListener(() {
      var _selectedIndex=(_pageController.page??0.0).round();
      if(_selectedIndex!=_authController.studentIndex){
        _authController.setSelectedStudent(_selectedIndex);
        if(onStudentChange!=null){
          onStudentChange!();
        }
      }
     
    });
  }

  @override
  Widget build(BuildContext context) {
     _dimension.init(context);
    return _studentInfoSection(context);
  }

   Widget _studentInfoSection(BuildContext context){
  var _h = _dimension.getSafeBlockSizeVertical(context);
      return SizedBox(                  
                    height: _h*15,
                     child: 
                      PageView.builder(
                        itemCount:(_authController.loggedInUser as Parent).students.length,
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemBuilder: (context, index) =>                     
                            StudentSummary(index:index),
                      ), 
                   );
     
  }
}