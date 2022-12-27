import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/ui/widgets/nodata.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../constants/text_style.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/student_controller.dart';
import '../../../models/attendance.dart';
import '../../../models/student.dart';
import '../../../utils/app_dimensions.dart';

class AttendanceList extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _studentController = Get.find<StudentController>();
  final _dimension = Get.find<AppDimensions>();

  final ScrollController _scrollcontroller = ScrollController();
  AttendanceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    return FutureBuilder(
      future: loadAttendanceData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircularProgressIndicator(color: ColorConstants.secondaryThemeColor),
              SizedBox(height: _h*10),
              Text('Please wait its loading...'),
            ],
          ));
        } else {
          if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return Center(child: Text('Error occured'));
          } else if (snapshot.data != null) {
            var _attendanceList = (snapshot.data as List<Attendance>);
            // snapshot.data  :- get your object which is pass from your downloadData() function
            return (_authController.loggedInUser == null ||
                    _attendanceList.isEmpty)
                ? NoDataWidget(message: "No attendance data available")
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.safeBlockMinUnit * 3,
                        vertical: AppDimensions.safeBlockMinUnit * 6),
                    itemCount: _attendanceList.length,
                    controller: _scrollcontroller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _studentAttendanceItemSection(
                          context, _attendanceList[index]);
                    });
          }
        }
        return Container();
      },
    );
  }

  Future<List<Attendance>> loadAttendanceData() async {
    List<Attendance> _attendanceList = [];
    if (_authController.loggedInUser != null) {
      Student _std = _authController.selectedStudent() ?? Student();
      _attendanceList = await _studentController.getAttendance(
          _std,
          _authController.loggedInUser?.sessionId ?? 0,
          int.parse(_studentController.selectedYear ?? "0"),
          ((_studentController.selectedMonth ?? 0) + 1),
          day: _studentController.selectedDate ?? 0);
      return _attendanceList;
    } else {
      return _attendanceList;
    }
  }

  Widget _studentAttendanceItemSection(BuildContext context, Attendance atd) {
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _subFont = _dimension.getFontSubTitle(context);
    var _subNormal = _dimension.getFontNormal(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.boarderRadius / 2),
      ),
      shadowColor: ColorConstants.lightBackground2Color,
      elevation: 15,
      child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.boarderRadius / 2))),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: (atd.type == AttendanceType.checkin
                          ? ColorConstants.primaryThemeColor
                          : ColorConstants.secondaryThemeColor),
                      width: _w * 3)),
              color: ColorConstants.lightBackground1Color,
            ),
            padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit * 5),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined,
                        color: Colors.blueGrey),
                    SizedBox(
                      width: _w * 2,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              (atd.type == AttendanceType.checkin
                                  ? "TIME IN"
                                  : "TIME OUT"),
                              style: AppTextStyle.secondaryLightBold(
                                  size: _subFont)),
                          Text(DateFormat('yyyy MMM dd').format(atd.date),
                              style: AppTextStyle.primaryDarkRegular(
                                  size: _subNormal * 0.8)),
                        ]),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined,
                        color: Colors.blueGrey),
                    SizedBox(
                      width: _w * 2,
                    ),
                    Text(DateFormat('hh:mm a').format(atd.date),
                        style:
                            AppTextStyle.primaryDarkRegular(size: _subNormal)),
                  ],
                ),
              ],
            ),
          )),
    );
  }

}
