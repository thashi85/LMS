import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user.dart';
import '../../utils/app_dimensions.dart';
import '../widgets/student_summary.dart';


class StudentSlider extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _authController = Get.find<AuthController>();
  final _pageController=PageController(viewportFraction: 1, initialPage:1);

  StudentSlider({ Key? key }) : super(key: key){
     _pageController.addListener(() {
      Get.find<AuthController>().setSelectedStudent((_pageController.page??0.0).round());
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