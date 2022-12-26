
//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/notices.dart';
import '../../data/repository/student_repo.dart';
import '../../models/attendance.dart';
import '../../models/homework.dart';
import '../../models/student.dart';

class StudentController extends GetxController 
{
  final StudentRepo _stdRepo=Get.find<StudentRepo>();

  String? selectedYear;
  int? selectedMonth;
  int? selectedDate;
  late Student selectedStudent;

  changeSelectedYear(String val){
      selectedYear=val;  
      update();   
  }
   changeSelectedMonth(int val){
      selectedMonth=val;  
      selectedDate=0;
      update();   
  }
   changeSelectedDate(int val){
      selectedDate=val;  
      update();   
  }
  changeselectedStudent(Student val){
      selectedStudent=val;  
      update();   
  }
  Future<List<Attendance>> getAttendance(Student student,int sessionId,int year,int month,{int day=0})
  async {
     debugPrint("Attendance Student :${student.studentId??0}  Year: $year Month:$month Date:$day");
    List<Attendance> _res=[];
    if(student.attendance!=[])
    {
      var _filtered =student.attendance.where((element) => element.year==year && element.month==month).toList();
      if(_filtered.isNotEmpty){
          if(day>0){
            _res=_filtered[0].attendance.where((a) => a.date.day==day).toList();           
          }else{
            _res=_filtered[0].attendance;
          }
           return _res;
      }
    }
    var _apiData=await _stdRepo.getAttendance(student.studentId??0, sessionId, year, month);
    if(_apiData !=null && _apiData.data != null)
    {     
      student.attendance.add(MonthlyAttendance(year: year, month: month, attendance: _apiData.data));
       _res=_apiData.data;
      if(day>0){
        _res=_res.where((a) => a.date.day==day).toList();   
      }
    }
    /*
     Random random = Random();
      int _randomNumber = random.nextInt(29); // from 0 upto 28 included
      _res.add(Attendance(date: DateTime.parse('2022-12-05 07:30'), type: AttendanceType.checkin));
      _res.add(Attendance(date: DateTime.parse('2022-12-05 02:35'), type: AttendanceType.ckeckout));

       _res.add(Attendance(date: DateTime.parse('2022-12-06 07:18'), type: AttendanceType.checkin));
      _res.add(Attendance(date: DateTime.parse('2022-12-06 02:30'), type: AttendanceType.ckeckout));
    */
    return _res;

  }

  Future<List<Homework>> getHomeworks(Student student,int sessionId,int year,int month,{int day=0})
  async {
    List<Homework> _res=[];
     debugPrint("Homework Student :${student.studentId??0} classId:${student.classId} sectionId: ${student.sectionId} Year: $year Month:$month Date:$day");
    /*if(student.homeworks!=[])
    {
      var _filtered =student.homeworks.where((element) => element.year==year && element.month==month).toList();
      if(_filtered.isNotEmpty){
          if(day>0){
            _res=_filtered[0].homeworks.where((a) => a.homeworkDate.day==day).toList();           
          }else{
            _res=_filtered[0].homeworks;
          }
           return _res;
      }
    }*/
    var _apiData=await _stdRepo.getHomeworks(student.classId,student.sectionId, sessionId, year, month);
    if(_apiData !=null && _apiData.data != null)
    {     
      student.homeworks.add(MonthlyHomework(year: year, month: month, homeworks: _apiData.data));
       _res=_apiData.data;
      if(day>0){
        _res=_res.where((a) => a.homeworkDate.day==day).toList();   
      }
    }    
    return _res;

  }
  
  Future<List<Notice>> getNotices(Student student,int sessionId,int year,int month,{int day=0})
  async {
    List<Notice> _res=[];
     debugPrint("Notices Student :${student.studentId??0} classId:${student.classId} sectionId: ${student.sectionId} Year: $year Month:$month Date:$day");
    
    var _apiData=await _stdRepo.getNotices(student.classId,student.sectionId, sessionId, year, month);
    if(_apiData !=null && _apiData.data != null)
    {     
      student.notices.addAll(_apiData.data);
       _res=_apiData.data;
      if(day>0){
        _res=_res.where((a) => a.noticeDate.day==day).toList();   
      }
    }    
    return _res;

  }
}