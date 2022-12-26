import 'package:get/get.dart';
import 'package:lms/constants/enums.dart';
import 'package:lms/models/api_response.dart';
import 'package:lms/models/attendance.dart';
import 'package:lms/models/homework.dart';
import 'package:lms/models/notices.dart';
import '../api/api_client.dart';

class StudentRepo extends GetxService
{
  final ApiClient apiClient;
  StudentRepo({required this.apiClient});

//type :Parent,2:student,3: staff
  Future<ApiResponse?> getAttendance(int studentId,int sessionId,int year,int month,{int day=0}) async {
    
      var _res =await apiClient.getData("api/student/attendance.php?studentId=$studentId&sessionId=$sessionId&year=$year&month=$month&day=$day",null); 
      if(_res.status==ResponseStatus.success) { 
        if (_res.response["data"] != null) {
          _res.data = <Attendance>[];
         _res.response["data"].forEach((v) {
            var _st=Attendance.fromJson(v);        
            _res.data.add(_st);
          });

        }
      }
      return _res;
  
  }

    Future<ApiResponse?> getHomeworks(int classId,int sectionId,int sessionId,int year,int month,{int day=0}) async {
    
      var _res =await apiClient.getData("api/student/homework.php?classId=$classId&sectionId=$sectionId&sessionId=$sessionId&year=$year&month=$month&day=$day",null); 
      if(_res.status==ResponseStatus.success) { 
        if (_res.response["data"] != null) {
          _res.data = <Homework>[];
         _res.response["data"].forEach((v) {
            var _st=Homework.fromJson(v);        
            _res.data.add(_st);
          });

        }
      }
      return _res;
  
  }
  Future<ApiResponse?> getNotices(int classId,int sectionId,int sessionId,int year,int month,{int day=0}) async {
    
      var _res =await apiClient.getData("api/student/notices.php?classId=$classId&sectionId=$sectionId&sessionId=$sessionId&year=$year&month=$month&day=$day",null); 
      if(_res.status==ResponseStatus.success) { 
        if (_res.response["data"] != null) {
          _res.data = <Notice>[];
         _res.response["data"].forEach((v) {
            var _st=Notice.fromJson(v);        
            _res.data.add(_st);
          });

        }
      }
      return _res;
  
  }
}
