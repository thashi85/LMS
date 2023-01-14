import 'package:get/instance_manager.dart';
import 'package:lms/controllers/notification_controller.dart';
import 'package:lms/data/repository/payment_repo.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/student_controller.dart';
import '../../data/repository/common_repo.dart';
import '../../data/repository/student_repo.dart';
import '../../data/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constant.dart';
import '../controllers/auth_controller.dart';
import '../controllers/payment_controller.dart';
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
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.baseUrl,timeoutD: AppConstant.apiTimeout,sharedPreferences: prefs),fenix: true);
  //repos 
  Get.lazyPut(() => UserRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => StudentRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => CommonRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()),fenix: true);

  //Controllers
  Get.lazyPut(()=>AuthController(),fenix: true);
  Get.lazyPut(()=>StudentController(),fenix: true);
  Get.lazyPut(()=>HomeController(),fenix: true);
  Get.lazyPut(() => PaymentController(),fenix: true);
  Get.lazyPut(() => NotificationController(),fenix: true);

  //Services
  // Get.lazyPut(() => ThemeService());

  //storage
  //await GetStorage.init();
}
