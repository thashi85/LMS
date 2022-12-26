
import '../constants/enums.dart';

class ApiResponse {
  ResponseStatus status;
  dynamic response;
  String? errorMsg;
  int? responseCode;
  dynamic data;

  ApiResponse({
    required this.status,
    this.response,
    this.errorMsg,
    this.responseCode    
  });
}