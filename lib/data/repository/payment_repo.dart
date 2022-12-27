import 'package:get/get.dart';
import 'package:lms/models/payment_summary.dart';

import '../../constants/enums.dart';
import '../../models/api_response.dart';
import '../api/api_client.dart';

class PaymentRepo extends GetxService
{
  final ApiClient apiClient;
  PaymentRepo({required this.apiClient});

//type :Parent,2:student,3: staff
  Future<ApiResponse?> getPayments(int parentId,int studentId,int sessionId,int year,int month,{int day=0}) async {
    
      var _res =await apiClient.getData("api/payment/get.php?parentId=$parentId&studentId=$studentId&sessionId=$sessionId&year=$year&month=$month&day=$day",null); 
      if(_res.status==ResponseStatus.success) { 
        if (_res.response["data"] != null) {
          var _summary=PaymentSummary.fromJson(_res.response["data"]); 
          if(month!=12){
            _summary.payments=[];
          }
          _res.data =   _summary;
        }
        
      }
      return _res;
  
  }
}