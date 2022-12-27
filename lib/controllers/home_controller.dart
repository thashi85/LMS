import 'package:get/get.dart';
import '../../data/repository/common_repo.dart';
import '../../models/slider_image.dart';

class HomeController extends GetxController {

  final CommonRepo _commonRepo=Get.find<CommonRepo>();  
  List<SliderImage> sliderImages=[];
  HomeController():super();

 Future<List<SliderImage>> getSliderImages() async
  {     
    if(sliderImages.isEmpty){
      var _apiData=await _commonRepo.getSliderImages();
      if(_apiData !=null && _apiData.data != null)
      {           
        sliderImages=_apiData.data;    
        update();
      }   
    }  
   
    return sliderImages;
  }

}