
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
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    sessionId = json['sessionId'];
    if (json['students'] != null) {
      students = <Student>[];
      json['students'].forEach((v) {
        var _st=Student.fromJson(v);        
        students.add(_st);
      });
    }
  }

}

