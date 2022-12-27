import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/payment_repo.dart';
import '../../models/payment_summary.dart';
import '../models/student.dart';

class PaymentController extends GetxController {

  final PaymentRepo _paymentRepo=Get.find<PaymentRepo>();  
  PaymentSummary? paymentSummary;
  PaymentController():super();
 
  void refreshData(List<Object>? ids){
    if(ids!=null) {
      update(ids);
    }else{
      update();
    }
 }
 Future<PaymentSummary?> getPaymentTransaction(int parentId,Student student,int sessionId,int year,int month,{int day=0}) async
  {  
      debugPrint("Payments Student :${student.studentId??0}  Year: $year Month:$month Date:$day");   
 
      var _apiData=await _paymentRepo.getPayments(parentId,student.studentId!,sessionId,year,month,day:day);
      if(_apiData !=null && _apiData.data != null)
      { 
        paymentSummary=_apiData.data;
         return _apiData.data;   //update(["paymentHistory"]);
      }      
   
      return null;
  }

}