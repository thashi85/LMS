import 'package:get/get.dart';

import '../../constants/enums.dart';
import '../../models/api_response.dart';
import '../../models/slider_image.dart';
import '../api/api_client.dart';

class CommonRepo extends GetxService
{
  final ApiClient apiClient;
  CommonRepo({required this.apiClient});

//type :Parent,2:student,3: staff
  Future<ApiResponse?> getSliderImages() async {
    
      var _res =await apiClient.getData("api/home/image_slider.php",null); 
      if(_res.status==ResponseStatus.success) { 
        if (_res.response["data"] != null) {
          _res.data = <SliderImage>[];
         _res.response["data"].forEach((v) {
            var _st=SliderImage.fromJson(v);        
            _res.data.add(_st);
          });

        }
      }
      return _res;
  
  }
}