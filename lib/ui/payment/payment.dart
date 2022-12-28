import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../widgets/nodata.dart';
import '../../controllers/payment_controller.dart';
import '../../models/payment_summary.dart';
import '../../models/student.dart';
import '../../ui/widgets/sliding_datepicker.dart';
import '../../controllers/student_controller.dart';
import '../../ui/widgets/user_info.dart';
import '../../controllers/auth_controller.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../widgets/drawer.dart';

import '../../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';

class PaymentPage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
  
  final _authController = Get.find<AuthController>();
  final _paymentController = Get.find<PaymentController>();
  final _pageController=PageController(viewportFraction: 1, initialPage:1);
  final _studentController = Get.find<StudentController>();
  final ScrollController _scrollcontroller = ScrollController();

  late List<String> _years=[];
  final _currentYear=DateTime.now().year;



  PaymentPage({ Key? key }) : super(key: key){
     _studentController.selectedYear ??= (_currentYear.toString());   

   _pageController.addListener(() {
      Get.find<AuthController>().setSelectedStudent((_pageController.page??0.0).floor());
    });
   
    for(var i=-5;i<1;i++){
      _years.add((_currentYear+i).toString());
    }
  
  }
  
 
  @override
  Widget build(BuildContext context) {
    
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _subFont = _dimension.getFontSubTitle(context);
    //var _titleFont = _dimension.getFontTitle(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
      ),
      body: SharedComponentUI. calenderTopLayoutUI(context, _dimension,     
               Column(
                mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [                  
                   Container(
                     height:_h*35 ,
                     color: ColorConstants.secondaryThemeColor,
                     child: Stack(                     
                        children: [
                           UserInfo(),
                           Positioned(
                             left:_w*5,
                             right: _w*5,
                             top:_h*12,
                             child: Container(
                              height: _h*20,
                              decoration: BoxDecoration(
                                color: ColorConstants.whiteBackgroundColor,
                                borderRadius: BorderRadius.circular(AppDimensions.boarderRadius)
                              ),
                              child:  Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(   
                                        margin: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),                                    
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10), 
                                          // color: ColorConstants.whiteBackgroundColor,                                        
                                        ),
                                        child: _dueAmountContent(context),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      width: 20,
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                      color: ColorConstants.lightAshBackgroundColor,
                                    ),
                                    Expanded(
                                      child: Container(
                                         margin: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),    
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                         //color: ColorConstants.whiteBackgroundColor,
                                        ),
                                        child:  _dueDateContent(context),
                                      ),
                                    ),
                                  ]),
                             ),
                           )
                        ],
                     ),
                   ),
                    GetBuilder<StudentController>(
                              builder: (controller) => SlidingDatePicker(showDateSelection: false,onDateChange: dateChange)),                 

                     Padding(
                       padding: EdgeInsets.only(left: AppDimensions.safeBlockMinUnit*5,top: AppDimensions.safeBlockMinUnit*5),
                       child: Text("Transactions",
                           style:  AppTextStyle.secondaryLightBold(size: _subFont)),
                     ),
                      GetBuilder<PaymentController>(
                        id: "paymentHistory",
                        builder:(controller)=> _studentPaymentSection(context)
                      )
                 
                 ],
               ),
            
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: ColorConstants.secondaryThemeColor,
          ), // sets the inactive color of the `BottomNavigationBar`
          child:SharedComponentUI.bottomNavigationContent()
        ),
       drawer:DrawerMenu() ,
    );
  }

  Widget _dueDateContent(BuildContext context) {
    var _subFont = _dimension.getFontSubTitle(context);
    var _titleFont = _dimension.getFontTitle(context);
    return GetBuilder<PaymentController>(
      id: "paymentDueDate",
      builder: ((controller) => 
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [                                            
                        Text("Due Date", style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),
                                          
                        Column(
                            children: [
                              Text((_paymentController.paymentSummary==null)   ?"" :  DateFormat("MMM dd").format( _paymentController.paymentSummary!.dueDate), style:  AppTextStyle.secondaryLightBold(size: _titleFont,color: ColorConstants.primaryThemeColor)),   
                              Text((_paymentController.paymentSummary==null)   ?"" :DateFormat("yyyy").format( _paymentController.paymentSummary!.dueDate), style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),    
                            ],
                          )
                       
                                                         
                    ],
                  )
    ));
  }

  Widget _dueAmountContent(BuildContext context) {
     var _subFont = _dimension.getFontSubTitle(context);
    var _titleFont = _dimension.getFontTitle(context);
    return GetBuilder<PaymentController>(
        id: "paymentDueAmount",
        builder: ((controller) => 
        Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Text("Amount", style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),
                      
                      Text((_paymentController.paymentSummary?.dueAmount??0.0).toStringAsFixed(2), style:  AppTextStyle.secondaryLightBold(size: _titleFont,color: ColorConstants.primaryThemeColor))                                                                                        
                  ],
                )
    ));
  }

  dateChange(){
    _paymentController.refreshData(["paymentHistory","paymentDueAmount","paymentDueDate"]);
  }
  Future<PaymentSummary?> loadPayments() async {
    PaymentSummary? _paymentSummary;
    if (_authController.loggedInUser != null) {
      Student _std = _authController.selectedStudent() ?? Student();
      _paymentSummary = await _paymentController.getPaymentTransaction(_authController.loggedInUser!.userId!,
          _std,
          _authController.loggedInUser?.sessionId ?? 0,
          int.parse(_studentController.selectedYear ?? "0"),
          ((_studentController.selectedMonth ?? 0) + 1),
          day: _studentController.selectedDate ?? 0);
      return _paymentSummary;
    } else {
      return _paymentSummary;
    }
  }
  Widget _studentPaymentSection(BuildContext context){
    var _h = _dimension.getSafeBlockSizeVertical(context);
      return    FutureBuilder(
                    future: loadPayments(),
                    builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) 
                        {
                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const CircularProgressIndicator(color: ColorConstants.secondaryThemeColor),
                                SizedBox(height: _h*10),
                                const Text('Please wait its loading...'),
                              ],
                            ));
                        } else 
                        {
                            if (snapshot.hasError) {
                              debugPrint('Error: ${snapshot.error}');
                              return const Center(child: Text('Error occured'));

                            } else if (snapshot.data != null) 
                            {
                                  var _paymentSummary = (snapshot.data as PaymentSummary);
                                  if(_paymentSummary!=null && _paymentSummary.payments.isEmpty==null)
                                  {
                                    _paymentSummary.payments=[];
                                  }
                                    // snapshot.data  :- get your object which is pass from your downloadData() function
                                    return (_authController.loggedInUser == null ||
                                            _paymentSummary.payments.isEmpty)
                                        ? NoDataWidget(message: "No payments available for this month")
                                        : ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AppDimensions.safeBlockMinUnit * 3,
                                                vertical: AppDimensions.safeBlockMinUnit * 6),
                                            itemCount: _paymentSummary.payments.length,
                                            controller: _scrollcontroller,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return _paymentRowSection(
                                                  context, _paymentSummary.payments[index], index);
                                            });

                                  
                                  
                                
                              }
                              return Container();
                        }
                  });
        
      
      
  }
  Widget _paymentRowSection(BuildContext context,Payment pym,int index){
     var _w = _dimension.getSafeBlockSizeHorizontal(context);
     var _subFont = _dimension.getFontSubTitle(context);
     var _subNormal = _dimension.getFontNormal(context);
      return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.boarderRadius/2),
                ),
                shadowColor: ColorConstants.lightBackground2Color,
                elevation: 15,
                child:
                  ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.boarderRadius/2))),
                  child: Container(
                   
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                              color: ((index % 2)==0 ? ColorConstants.primaryThemeColor :ColorConstants.secondaryThemeColor),
                              width: _w*3)),
                        color: ColorConstants.lightBackground1Color,
                      ),
                      padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        
                         Row(
                          children: [
                            const Icon(Icons.calendar_month,color: Colors.blueGrey),
                            SizedBox(width: _w*2,),
                             Text(DateFormat('yyyy-MMM-dd hh:mm a').format(DateTime.now()),
                              style:  AppTextStyle.primaryDarkRegular(size: _subNormal)),
                          ],
                         
                         ),
                          Text("Rs. 10,000",
                         style:  AppTextStyle.secondaryLightBold(size: _subFont)),
                       ],                        
                      )),
                ), 
              );
  }
}
