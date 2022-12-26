class DateUtility{
  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  static getStartDayOfWeek(DateTime date){
    return getDate(date.subtract(Duration(days: date.weekday - 1)));
  }
  static getEndDayOfWeek(DateTime date){
    return getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
  }
  
  static firstDayOfMonth(int year,int month){
    var date = DateTime(year,month,1);
    return date;
  }

  static lastDayOfMonth(int year,int month){
    var date = DateTime(year,month==12? 1: (month+1),0);
    return (date.day);
  }

}