import '../../constants/enums.dart';

class Attendance{

late DateTime date;
late AttendanceType type;
Attendance({required this.date,required this.type});

Attendance.fromJson(Map<String, dynamic> json) {   
    date =DateTime.parse( json['time_stamp']);
    type = json['type']=="2" ? AttendanceType.ckeckout:AttendanceType.checkin;   
  }
}

class MonthlyAttendance{
  int year;
  int month;
  List<Attendance> attendance;
  MonthlyAttendance({required this.year,required this.month,required this.attendance});
}