import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/ui/widgets/nodata.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/student_controller.dart';
import '../../models/homework.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../controllers/auth_controller.dart';
import '../../models/student.dart';
import '../widgets/drawer.dart';

import '../../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';
import '../widgets/sliding_datepicker.dart';
import '../widgets/student_slider.dart';

class HomeworkPage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _authController = Get.find<AuthController>();
  final _studentController = Get.find<StudentController>();

  final _currentYear = DateTime.now().year;
  final ScrollController _scrollcontroller = ScrollController();
  HomeworkPage({Key? key}) : super(key: key) {
    _studentController.selectedYear ??= (_currentYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homeworks"),
      ),
      body: SharedComponentUI.calenderTopLayoutUI(
          context,
          _dimension,
          (_authController.loggedInUser == null)
              ? const CircularProgressIndicator(
                  color: ColorConstants.secondaryThemeColor)
              : Column(
                  children: [
                    StudentSlider(onStudentChange: dateChange),
                    SizedBox(height: _h * 2),
                    GetBuilder<StudentController>(
                        id:"studentHomework",
                        builder: (controller) => Column(
                              children: [
                                SlidingDatePicker(onDateChange: dateChange),
                                homeworkList(context)
                              ],
                            )),
                  ],
                )),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: ColorConstants.secondaryThemeColor,
          ), // sets the inactive color of the `BottomNavigationBar`
          child: SharedComponentUI.bottomNavigationContent()),
      drawer: DrawerMenu(),
    );
  }
  
  dateChange(){
    _studentController.refreshData(["studentHomework"]);
  }
  Widget homeworkList(BuildContext context) {
    var _h = _dimension.getSafeBlockSizeVertical(context);
    return FutureBuilder(
      future: loadHomeworks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children:  [
              const CircularProgressIndicator(color: ColorConstants.secondaryThemeColor),
              SizedBox(height: _h*10),
              const Text('Please wait its loading...'),
            ],
          ));
        } else {
          if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return const Center(child: Text('Error occured'));
          } else if (snapshot.data != null) {
            var _homeworkList = (snapshot.data as List<Homework>);
            // snapshot.data  :- get your object which is pass from your downloadData() function
            return (_authController.loggedInUser == null ||
                    _homeworkList.isEmpty)
                ? NoDataWidget(message: "No homework available",)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.safeBlockMinUnit * 3,
                        vertical: AppDimensions.safeBlockMinUnit * 6),
                    itemCount: _homeworkList.length,
                    controller: _scrollcontroller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _studentHomeworkItemSection(
                          context, _homeworkList[index], index);
                    });
          }
        }
        return Container();
      },
    );
  }

  Future<List<Homework>> loadHomeworks() async {
    List<Homework> _homeworkList = [];
    if (_authController.loggedInUser != null) {
      Student _std = _authController.selectedStudent() ?? Student();
      _homeworkList = await _studentController.getHomeworks(
          _std,
          _authController.loggedInUser?.sessionId ?? 0,
          int.parse(_studentController.selectedYear ?? "0"),
          ((_studentController.selectedMonth ?? 0) + 1),
          day: _studentController.selectedDate ?? 0);
      return _homeworkList;
    } else {
      return _homeworkList;
    }
  }

  Widget _studentHomeworkItemSection(
      BuildContext context, Homework hwk, int index) {
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
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
                      color: (index % 2 == 0
                          ? ColorConstants.primaryThemeColor
                          : ColorConstants.secondaryThemeColor)                      
                      ,
                      width: _w * 3)),
              color: ColorConstants.lightBackground1Color,
            ),
            padding: EdgeInsets.symmetric(horizontal: _w * 2, vertical: _h ),
            alignment: Alignment.topLeft,
            child: Column(
              // color: Colors.limeAccent,
              children:[ 
                 Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Expanded(child: Html(
                            data: hwk.description,
                            onLinkTap:(url, renderContext, map, element) async {
                                //open URL in webview, or launch URL in browser, or any other logic here
                                if (await canLaunchUrl(Uri.parse(url!))) {
                                await launchUrl(
                                 Uri.parse(url),
                                );
                              } else {
                                throw 'Could not launch $url';
                              }
                              }
                              ))
                       
                      ],
                    ),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.all(AppDimensions.safeBlockMinUnit * 3),
                        decoration: BoxDecoration(
                            color: ColorConstants.lightBackground2Color,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.boarderRadius)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: Colors.blueGrey),
                            Text(DateFormat('dd').format(hwk.homeworkDate),
                                style: AppTextStyle.secondaryLightBold(
                                    size: _subFont)),
                            Text(DateFormat('MMM').format(hwk.homeworkDate),
                                style: AppTextStyle.primaryDarkRegular(
                                    size: _subNormal * 0.8)),
                            Text(DateFormat('yyyy').format(hwk.homeworkDate),
                                style: AppTextStyle.primaryDarkRegular(
                                    size: _subNormal * 0.8)),
                          ],
                        ),
                      ),
                    ],
                  ),
                 
                  Expanded(
                    child: Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.only(
                          left: AppDimensions.safeBlockMinUnit * 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                         /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child:  Html(data: hwk.description)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   Text(hwk.status,
                                      style: AppTextStyle.primaryDarkBold(
                                          size: _subFont * 0.8)),
                                   SizedBox(height: _h),
                                   Text("${hwk.subjectName}(${hwk.subjectCode})",
                                      style: AppTextStyle.primaryDarkBold(
                                          size: _subFont * 0.8)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: _h),*/
                         /* Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: _w * 15,
                                  child: Text("Subject:",
                                      style: AppTextStyle.secondaryLightRegular(
                                          size: _subNormal * 0.6))),
                              SizedBox(width: _w * 2),
                              Text("${hwk.subjectName}(${hwk.subjectCode})",
                                  style: AppTextStyle.primaryDarkBold(
                                      size: _subNormal * 0.7)),
                            ],
                          ),
                          SizedBox(height: _h),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _w * 15,
                                child: Text("Created By:",
                                    style: AppTextStyle.secondaryLightRegular(
                                        size: _subNormal * 0.7)),
                              ),
                              SizedBox(width: _w * 2),
                              Text("${hwk.staffName}",
                                  style: AppTextStyle.primaryDarkBold(
                                      size: _subNormal * 0.8)),
                            ],
                          ),
                         
                          if(hwk.submitDate != null)
                          Column(
                              children: [
                                SizedBox(height: _h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: _w * 15,
                                        child: Text("Submit Date:",
                                            style: AppTextStyle
                                                .secondaryLightRegular(
                                                    size: _subNormal * 0.7))),
                                    SizedBox(width: _w * 2),
                                    Text(DateFormat('yyyy-MMM-dd')
                                                .format(hwk.submitDate!),
                                        style: AppTextStyle.primaryDarkBold(
                                            size: _subNormal * 0.8)),
                                  ],
                                ),
                              ],
                            )
                         if(hwk.evaluationDate != null )
                         Column(
                              children: [
                                SizedBox(height: _h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: _w * 15,
                                        child: Text("Evaluated on:",
                                            style: AppTextStyle
                                                .secondaryLightRegular(
                                                    size: _subNormal * 0.7))),
                                    SizedBox(width: _w * 2),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            DateFormat('yyyy-MMM-dd')
                                                .format(hwk.evaluationDate!),
                                            style: AppTextStyle.primaryDarkBold(
                                                size: _subNormal * 0.7)),
                                        Text("${hwk.evaluatedByStaffName}",
                                            style: AppTextStyle.primaryDarkBold(
                                                size: _subNormal * 0.7)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   Container(
                                    padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit),
                                    decoration: BoxDecoration(
                                      color: (hwk.status=="Pending"
                                            ? ColorConstants.primaryThemeColor:
                                            (hwk.status=="Completed" ? ColorConstants.tertiaryThemeColor
                                            : ColorConstants.secondaryThemeColor)),
                                      borderRadius: BorderRadius.circular(AppDimensions.boarderRadius/2)
                                    ),
                                     child: Text(hwk.status,
                                        style: AppTextStyle.primaryLightBold(
                                            size: _subFont * 0.8)),
                                   ),
                                   SizedBox(height: _h),
                                   Text(hwk.subjectName,
                                      style: AppTextStyle.primaryDarkBold(
                                          size: _subFont * 0.8)),
                                     Text("(${hwk.subjectCode})",
                                      style: AppTextStyle.primaryDarkBold(
                                          size: _subFont * 0.6)),
                                ],
                              ),
                ],
              ),
               
              ]
            ),
          )),
    );
  }

  
}
