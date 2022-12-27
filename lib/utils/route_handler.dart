import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RouteHandler{
  static  final _authController=Get.find<AuthController>();
  static redirectToLogin(){   
     // Get.offAllNamed("/login") ;
      Get.toNamed("/login");
     
  }
  static redirectToHome(){
      authenticateRedirect("/home");
  }
  static redirectToPayment(){
      authenticateRedirect("/payments");
  }
  static redirectToNotices(){
      authenticateRedirect("/student/notices");
  }
  static redirectToHomework(){
      authenticateRedirect("/student/homework");
  }
  static redirectToAttendance(){
      authenticateRedirect("/student/attendance");
  }
  static authenticateRedirect(String path){
    if(_authController.loggedInUser==null){
      _authController.signOut();
       //Get.toNamed("/login");
    }
    else {
      Get.toNamed(path);
    }
  }
}