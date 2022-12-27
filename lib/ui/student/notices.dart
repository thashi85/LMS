import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/ui/widgets/nodata.dart';
import '../../models/notices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/student_controller.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../controllers/auth_controller.dart';
import '../../models/student.dart';
import '../widgets/drawer.dart';

import '../../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';
import '../widgets/sliding_datepicker.dart';
import '../widgets/student_slider.dart';

class NoticePage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  final _authController = Get.find<AuthController>();
  final _studentController = Get.find<StudentController>();

  final _currentYear = DateTime.now().year;
  final ScrollController _scrollcontroller = ScrollController();
  NoticePage({Key? key}) : super(key: key) {
    _studentController.selectedYear ??= (_currentYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notices"),
      ),
      body: SharedComponentUI.calenderTopLayoutUI(
          context,
          _dimension,
          (_authController.loggedInUser == null)
              ? const CircularProgressIndicator(
                  color: ColorConstants.secondaryThemeColor)
              : Column(
                  children: [
                    StudentSlider(),
                    SizedBox(height: _h * 2),
                    GetBuilder<StudentController>(
                        id:"studenNotices",
                        builder: (controller) => Column(
                              children: [
                                SlidingDatePicker(showDateSelection: false,onDateChange: dateChange),
                                noticeList(context)
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

  Widget noticeList(BuildContext context) {
    return FutureBuilder(
      future: loadNotices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              CircularProgressIndicator(color: ColorConstants.loaderColor),
              Text('Please wait its loading...'),
            ],
          ));
        } else {
          if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return const Center(child: Text('Error occured'));
          } else if (snapshot.data != null) {
            var _noticeList = (snapshot.data as List<Notice>);
            // snapshot.data  :- get your object which is pass from your downloadData() function
            return (_authController.loggedInUser == null ||
                    _noticeList.isEmpty)
                ? NoDataWidget(message: "No notices available")
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.safeBlockMinUnit * 3,
                        vertical: AppDimensions.safeBlockMinUnit * 6),
                    itemCount: _noticeList.length,
                    controller: _scrollcontroller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _studentNoticeItemSection(
                          context, _noticeList[index], index);
                    });
          }
        }
        return Container();
      },
    );
  }
  dateChange(){
    _studentController.refreshData(["studenNotices"]);
  }

  Future<List<Notice>> loadNotices() async {
    List<Notice> _noticeList = [];
    if (_authController.loggedInUser != null) {
      Student _std = _authController.selectedStudent() ?? Student();
      _noticeList = await _studentController.getNotices(
          _std,
          _authController.loggedInUser?.sessionId ?? 0,
          int.parse(_studentController.selectedYear ?? "0"),
          ((_studentController.selectedMonth ?? 0) + 1),
          day: _studentController.selectedDate ?? 0);
      return _noticeList;
    } else {
      return _noticeList;
    }
  }

  Widget _studentNoticeItemSection(BuildContext context, Notice notice,int index) {
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
   // var _subFont = _dimension.getFontSubTitle(context);
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
                      color: (index % 2 ==0
                          ? ColorConstants.primaryThemeColor
                          : ColorConstants.secondaryThemeColor),
                      width: _w * 3)),
              color: ColorConstants.lightBackground1Color,
            ),
            padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit * 5),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        /*const Icon(Icons.notifications_active_outlined,
                            color: Colors.blueGrey),
                        SizedBox(
                          width: _w * 2,
                        ),*/
                        Text(notice.title,style: AppTextStyle.secondaryLightBold( size: _subNormal))                   
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.calendar_month,
                            color: Colors.blueGrey),
                        SizedBox(
                          width: _w * 2,
                        ),
                        Column(
                          children: [
                            Text(DateFormat('yyyy MMM dd').format(notice.noticeDate),
                                style: AppTextStyle.primaryDarkRegular(size: _subNormal*0.75)),
                            Text(DateFormat('hh:mm a').format(notice.noticeDate),
                                style: AppTextStyle.primaryDarkRegular(size: _subNormal*0.75)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(height: _h*2),
                Visibility(
                  visible: (notice.message??"")!="",
                  child: Container(
                    color: ColorConstants.lightBackground3Color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Expanded(child: Html(
                                data: notice.message??"",
                                 style: {                                   
                                      "p": Style(
                                        padding:const EdgeInsets.only(left: 0)   ,
                                        margin:const EdgeInsets.only(left: 0)                                    
                                      )                                    
                                    },
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
                  ),
                )
              ],
            ),
          )),
    );
  }

  
}
