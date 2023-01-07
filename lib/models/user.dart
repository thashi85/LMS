
import 'student.dart';

class User {
  //int? id;
  int? userId;
  String? userName;
  String? name;
  String? email;
  String? phone;
  int? sessionId;
  late List<Device> devices=[];

  User( {//this.id,
      this.userId,
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
 // if(json['id']!=null){
  //  id = int.parse(json['id'].toString());
  //}
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
    if (json['devices'] != null) {
      devices = <Device>[];
      json['devices'].forEach((v) {
        var _st=Device.fromJson(v);        
        devices.add(_st);
      });
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
class Device{
  int? id;
  String? deviceRef;

Device( {this.id,
      this.deviceRef
   
      }):super();

    
Device.fromJson(Map<String, dynamic> json) {
  if(json['id']!=null){
    id = int.parse(json['id'].toString());
  }
  deviceRef = json['device_ref'];
  
  }
}
