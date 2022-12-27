import '../../models/notices.dart';

import '../../models/homework.dart';
import '../../models/attendance.dart';
import 'user.dart';

class Student extends User
{  
  int? studentId; 
  String? firstname;
  String? middlename;
  String? lastname;
 
  String? webImage;
  late String studentRef;
  late int classId;  
  late String className;  
  late int sectionId;
  late String section;

  List<MonthlyAttendance> attendance=[];
  List<MonthlyHomework> homeworks=[];
  List<Notice> notices=[];
  Student({
      name,
      email,
      phone,
      sessionId,
      this.studentId,     
      this.firstname,
      this.middlename,
      this.lastname,    
      this.webImage,
      this.studentRef="",
      this.classId=0,
      this.className="", 
      this.sectionId=0,
      this.section=""}
      )
      :super(userId:null,name: name,email: email,phone: phone,sessionId: sessionId );

Student.fromJson(Map<String, dynamic> json) {
    
    studentId = json['id']!=null ? int.parse(json['id'].toString()) : 0;
    studentRef = json['admission_no'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    name = json['completename'];
    webImage = (json['web_image']??"");
    phone = json['mobile_no'];
    email = json['email'];
    classId = json['classId']!=null ? int.parse(json['classId'].toString()) : 0; 
    className = json['className'];
    sectionId = json['sectionId']!=null ? int.parse(json['sectionId'].toString()) : 0;
    section = json['section'];
  }
}