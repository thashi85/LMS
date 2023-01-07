class Notice {
  late String title;
  late String? message;
  DateTime? noticeDate;

  Notice({required this.title,required this.noticeDate, this.message});

  Notice.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    if(json['notice_date']!=null){
    noticeDate = DateTime.parse(json['notice_date']);
    }
  }

  
}


