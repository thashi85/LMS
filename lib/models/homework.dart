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
    id =json['id']!=null ? int.parse(json['id'].toString()) :0;
    classId = json['class_id']!=null ? int.parse(json['class_id'].toString()) :0; 
    sectionId = json['section_id']!=null ? int.parse(json['section_id'].toString()) :0; 
    description = json['description'];
    homeworkDate =DateTime.parse(  json['homework_date']);
    submitDate = json['submit_date']!=null ? DateTime.parse(json['submit_date'] ) :null;
    staffId = json['staff_id']!=null ? int.parse(json['staff_id'].toString()) :0; 
    staffName = json['staff_name'];
    subjectId = json['subject_id']!=null ? int.parse(json['subject_id'].toString()) :0;
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectGroup = json['subject_group'];
    evaluationDate = json['evaluation_date']!=null ? DateTime.parse(json['evaluation_date'] ) :null; 
    if(evaluationDate!=null && evaluationDate!.year<=1){
      evaluationDate=null;
    }
    evaluatedBy = json['evaluated_by']!=null ? int.parse(json['evaluated_by'].toString()) :null;
    //dAYHHomeworkDate = json['DAY(h.homework_date)'];
    //sessionId = json['session_id'];
    //subjectGroupSubjectId = json['subject_group_subject_id'];
    createDate =DateTime.parse(  json['create_date']);
    document = json['document'];
    createdBy = json['created_by']!=null ? int.parse(json['created_by'].toString()) :0; 
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