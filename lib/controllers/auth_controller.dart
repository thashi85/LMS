import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/enums.dart';
import '../../controllers/student_controller.dart';
import '../../data/repository/user_repo.dart';
import '../../ui/shared/shared_component.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/route_handler.dart';
import '../models/student.dart';
import '../models/user.dart';

class AuthController extends GetxController {

  final UserRepo _userRepo=Get.find<UserRepo>();
 
  //RxBool isLoggedIn = false.obs;
  String loginOption = "1"; //1:parent 2:Student 3:teachers
  bool isLoading=false;
  
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  //TextEditingController name = TextEditingController();
  //TextEditingController address = TextEditingController();
  //TextEditingController phone = TextEditingController();
  // Rx<UserModel> userModel = UserModel().obs;
  User? loggedInUser;
  int studentIndex = 0;
  Student? selectedStudent() => (loggedInUser is Parent)
      ? (loggedInUser as Parent).students[studentIndex]
      : null;

  setLoginOption(String d) {
    loginOption = d;
    update();
  }

  setInitialScreen() async {
    RouteHandler.redirectToHome();
  }

  User? getUser() {
    if (loggedInUser == null) {
     RouteHandler.redirectToLogin();
    } else {
      return loggedInUser;
    }
    return null;
  }

  void signIn(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey) async {
    try {   
      isLoading=true;
     // update();
      var _res=await _userRepo.login(loginOption,username.text.trim(), password.text.trim());

      if(_res!=null && _res.data!=null){
          loggedInUser = _res.data as Parent;
          _clearControllers();
          if (loggedInUser is Parent) {
            studentIndex = 0;
           
          }
          /// ScaffoldMessenger.of(context).showSnackBar(
          //  SharedComponentUI.getSnackBarComponent(context,Get.find<AppDimensions>(), MessageType.success, "Login Success"));
         // Get.snackbar("Login Success", "");
         RouteHandler.redirectToHome();
      }else{
         ScaffoldMessenger.of(context).showSnackBar(
        SharedComponentUI.getSnackBarComponent(context,Get.find<AppDimensions>(), MessageType.error, "Login Failed:Try again"));
          //Get.snackbar("Login Failed", "Try again");
      }
      
    } catch (e) {
      debugPrint(e.toString());
       ScaffoldMessenger.of(context).showSnackBar(
       SharedComponentUI.getSnackBarComponent(context,Get.find<AppDimensions>(), MessageType.error, "Login Failed:Try again")
       );
      //Get.snackbar("Login Failed", "Try again");
      //dismissLoadingWidget();
    }
    isLoading=false;
    //update();
  }

  Future<String?> signUp() async {
    //  showLoading();
    try {} catch (e) {
      debugPrint(e.toString());
      
     // Get.snackbar("Something went wrong", "Try again");
      //dismissLoadingWidget();

    }
    return null;
  }

  void signOut() async {
     loggedInUser =null;
     _userRepo.logout();
    RouteHandler.redirectToLogin();
  }

  _clearControllers() {
    
    username.clear();
    password.clear();
   
  }

//Parent
  setSelectedStudent(int index) {
    if ((loggedInUser is Parent) && studentIndex != index) {
      studentIndex = index;     
      (Get.find<StudentController>()).changeselectedStudent(selectedStudent()!);
       update();
    }
  }
}
