
import 'student.dart';

class User {

  int? userId;
  String? userName;
  String? name;
  String? email;
  String? phone;
  int? sessionId;

  User( {this.userId,
      this.userName,
      this.name,
      this.email,
      this.phone,
      this.sessionId
      });

    
}
class Parent extends User{

late List<Student> students=[];
Parent();

Parent.fromJson(Map<String, dynamic> json) {
  if(json['userId']!=null){
    userId = int.parse(json['userId'].toString());
  }
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    if(json['sessionId']!=null){
    sessionId =int.parse( json['sessionId'].toString());
    }
    if (json['students'] != null) {
      students = <Student>[];
      json['students'].forEach((v) {
        var _st=Student.fromJson(v);        
        students.add(_st);
      });
    }
  }

}

