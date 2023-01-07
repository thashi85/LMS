import 'package:get/get.dart';
import '../../constants/enums.dart';
import '../../models/api_response.dart';
import '../../models/user.dart';
import '../api/api_client.dart';

class UserRepo extends GetxService
{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

//type :Parent,2:student,3: staff
  Future<ApiResponse?> login(String type,String username,String password) async {
    var _user={
      "username":username,
      "password":password
    };
    if(type=="1"){
      var _res =await apiClient.postData("api/user/login.php",_user,null); 
      if(_res.status==ResponseStatus.success) { 
        _res.data=Parent.fromJson(_res.response["data"]);
        apiClient.sharedPreferences.setString("Token", _res.response["token"]);
      }
      return _res;
    }
    return null;
  }
  logout(){
     apiClient.sharedPreferences.setString("Token", "");
  }
   Future<ApiResponse?> addDevice(String userId,String deviceRef) async {
    var _user={
      "user_id":userId,
      "device_ref":deviceRef
    };
   
      var _res =await apiClient.postData("api/user/device.php",_user,null); 
      if(_res.status==ResponseStatus.success) { 
       // _res.data=Parent.fromJson(_res.response["data"]);
       
      }
      return _res;
   
  }

}
