import 'package:get/instance_manager.dart';
import 'package:lms/controllers/home_controller.dart';
import 'package:lms/controllers/student_controller.dart';
import 'package:lms/data/repository/common_repo.dart';
import 'package:lms/data/repository/student_repo.dart';
import 'package:lms/data/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constant.dart';
import '../controllers/auth_controller.dart';
import '../data/api/api_client.dart';
import 'app_dimensions.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() async {
    //Get.put(() => AppDimensions(), permanent: true);
    // Get.lazyPut(() => HomeController());
    // await init();
  }
}

Future<void> init() async {
  Get.put((AppDimensions()));
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.baseUrl,timeoutD: AppConstant.apiTimeout,sharedPreferences: prefs));
  //repos 
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => StudentRepo(apiClient: Get.find()));
  Get.lazyPut(() => CommonRepo(apiClient: Get.find()));

  //Controllers
  Get.lazyPut(()=>AuthController());
  Get.lazyPut(()=>StudentController());
  Get.lazyPut(()=>HomeController());
  //Services
  // Get.lazyPut(() => ThemeService());

  //storage
  //await GetStorage.init();
}
