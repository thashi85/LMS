class Homework {
  late int id;
  late int classId;
  late int sectionId;
  late String description;
  late DateTime homeworkDate;
  late int subjectId;
  String subjectName="";
  String subjectCode="";
  String subjectGroup="";
  late DateTime createDate;
  late int createdBy;

  DateTime? submitDate;
  int? staffId;
  String? staffName;
 
  DateTime? evaluationDate;
  int? evaluatedBy;
  //int? dAYHHomeworkDate;
  //int? sessionId;
  //int? subjectGroupSubjectId;
 
  String? document;  
  //int? subjectGroupId;
  String? evaluatedByStaffName;
  String status="";
  Homework({
      required this.id,
      required this.classId,
      required this.sectionId,
      required this.description,
      required this.homeworkDate,
      required this.subjectId,
      required this.subjectName,
      required this.subjectCode,
      required this.subjectGroup,
      required this.createDate,
      required this.createdBy,
      
      this.submitDate,
      this.staffId,
      this.staffName,
     
      this.evaluationDate,
      this.evaluatedBy,
      //this.dAYHHomeworkDate,
      //this.sessionId,
      //this.subjectGroupSubjectId,
      
      this.document,
     
      //this.subjectGroupId,
      this.evaluatedByStaffName});

  Homework.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    description = json['description'];
    homeworkDate =DateTime.parse(  json['homework_date']);
    submitDate = json['submit_date']!=null ? DateTime.parse(json['submit_date'] ) :null;
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectGroup = json['subject_group'];
    evaluationDate = json['evaluation_date']!=null ? DateTime.parse(json['evaluation_date'] ) :null; 
    evaluatedBy = json['evaluated_by'];
    //dAYHHomeworkDate = json['DAY(h.homework_date)'];
    //sessionId = json['session_id'];
    //subjectGroupSubjectId = json['subject_group_subject_id'];
    createDate =DateTime.parse(  json['create_date']);
    document = json['document'];
    createdBy = json['created_by'];
    //subjectGroupId = json['subject_group_id'];
    evaluatedByStaffName = json['evaluated_by_staff_name'];
    if(evaluationDate!=null){
      status="Completed";
    }else if(submitDate!=null){
      status="Submitted";
    }else{
      status="Pending";
    }
  }

}

class MonthlyHomework{
  int year;
  int month;
  List<Homework> homeworks;
  MonthlyHomework({required this.year,required this.month,required this.homeworks});
}