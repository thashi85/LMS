import 'package:get/get.dart';
import '../../data/repository/common_repo.dart';
import '../../models/slider_image.dart';

class HomeController extends GetxController {

  final CommonRepo _commonRepo=Get.find<CommonRepo>();  
  List<SliderImage> sliderImages=[];
 
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  HomeController():super(){
  /* _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });

      },
      onResume: (message) async{
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });

      },
    );*/
  }

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