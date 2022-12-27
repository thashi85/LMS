import 'package:get/get.dart';
import '../../ui/payment/payment.dart';
import '../../ui/student/homework.dart';
import '../../ui/student/notices.dart';
import '../ui/home/home.dart';
import '../ui/student/attendance.dart';

import '../ui/login/login.dart';
import '../ui/splash/splash.dart';


var appRoutes = [
  GetPage(name: '/', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/home', page: () => HomePage()),
  GetPage(name: '/payments', page: () => PaymentPage()),
  GetPage(name: '/student/attendance', page: () => AttendancePage()),
  GetPage(name: '/student/homework', page: () => HomeworkPage()),
  GetPage(name: '/student/notices', page: () => NoticePage()),
];