import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/api_response.dart';

import '../../constants/enums.dart';
import '../../utils/route_handler.dart';


class ApiClient extends GetConnect implements GetxService {
 
  final String appBaseUrl;
  final int timeoutD;
  final SharedPreferences sharedPreferences;
  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl,required this.timeoutD,required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: timeoutD);
    token = sharedPreferences.getString("Token")??"";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  Future<ApiResponse> getData(String url,Map<String, String>? headers ) async {
    try {
      
      Response data = await  get(url,headers: headers??_mainHeaders);
      return processResponse(data);
    } catch (e) {
       return errorResponseReturn(e);
       // return Response(statusCode: 500, statusText: e.toString());
    }
  }
  
  Future<ApiResponse> postData(String url, Object obj,Map<String, String>? headers) async {
    try {
      Response data = await post(url, obj,headers: headers??_mainHeaders);
      return processResponse(data);
    } catch (e) {
      return errorResponseReturn(e);
      // return Response(statusCode: 500, statusText: e.toString());
    }
  }
  ApiResponse processResponse(Response response){
      var code = response.statusCode;
      
      var jsonDBody = jsonDecode(response.bodyString??"");

    if (code == 200 || code == 201) {
      return ApiResponse( status: ResponseStatus.success, response: jsonDBody, responseCode: code);
    } else if (code == 401) {
      RouteHandler.redirectToLogin();
      return ApiResponse(status: ResponseStatus.unathorized, response: jsonDBody, responseCode: code);   
    } else {   
      return ApiResponse(
          status: ResponseStatus.error, response: jsonDBody, responseCode: code,errorMsg: "Something went wrong");
    }
  }

  ApiResponse errorResponseReturn(Object error) {
    if (error is SocketException || error is IOException) {
      return ApiResponse( status: ResponseStatus.failed, errorMsg: "Connection error",responseCode:500);
    } else {
      return ApiResponse(status: ResponseStatus.failed, errorMsg: "Something went wrong",responseCode:500);
    }
  }
}
