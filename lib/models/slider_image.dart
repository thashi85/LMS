
class SliderImage{
  late String url;
  SliderImage({required this.url});

  SliderImage.fromJson(Map<String, dynamic> json) {   
    url =json['url'];
   
  }
}