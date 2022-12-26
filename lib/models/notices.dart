class Notice {
  late String title;
  late String? message;
  late DateTime noticeDate;

  Notice({required this.title,required this.noticeDate, this.message});

  Notice.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    noticeDate = DateTime.parse(json['noticeDate']);
  }

  
}


