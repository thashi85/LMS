import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/ui/widgets/user_info.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/month_menu.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../widgets/drawer.dart';

import '../../../utils/app_dimensions.dart';
import '../shared/shared_component.dart';

class PaymentPage extends StatelessWidget {
  final _dimension = Get.find<AppDimensions>();
 
 // final _studentController = Get.find<StudentController>();
  final _pageController=PageController(viewportFraction: 1, initialPage:1);
  final ScrollController _scrollcontroller = ScrollController();

  late List<String> _years=[];
  final _currentYear=DateTime.now().year;
  late String _selectedYear="";


  PaymentPage({ Key? key }) : super(key: key){
   _pageController.addListener(() {
      Get.find<AuthController>().setSelectedStudent((_pageController.page??0.0).floor());
    });
   
    for(var i=-5;i<1;i++){
      _years.add((_currentYear+i).toString());
    }
    _selectedYear=_currentYear.toString();
  
  }
  
 
  @override
  Widget build(BuildContext context) {
    
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _subFont = _dimension.getFontSubTitle(context);
    var _titleFont = _dimension.getFontTitle(context);
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
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                             Text("Amount", style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),
                                             
                                             Text("10000", style:  AppTextStyle.secondaryLightBold(size: _titleFont,color: ColorConstants.primaryThemeColor))                                                                                        
                                          ],
                                        ),
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
                                        child:  Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [                                            
                                             Text("Due Date", style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),
                                             Text("Dec-23", style:  AppTextStyle.secondaryLightBold(size: _titleFont,color: ColorConstants.primaryThemeColor)),   
                                             Text("2022", style:  AppTextStyle.secondaryLightBold(size: _subFont,color: ColorConstants.secondaryLightTextColor)),                                         
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                             ),
                           )
                        ],
                     ),
                   ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: _w*15,        
                            
                      padding: EdgeInsets.only(left: _w*2,bottom: 2),
                      child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value:_selectedYear.toString(),
                            isDense: true,
                            //elevation: 5,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _dimension.getFontNormal(context)* 0.8,
                              color:  ColorConstants.lightAshBackgroundColor,
                            ),
                            iconEnabledColor:Colors.black,
                            items:_years.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:const TextStyle(color:Colors.black)),
                              );
                            }).toList(),                           
                            onChanged: (String? value) {
                             
                             // _selectedYear=value??_currentYear.toString();
                            /*  setState(() {
                                _chosenValue = value;
                              }); */
                            },
                          ),
                    ),
                    Expanded(child: MonthMenu(width:  _w*75))
                    ]),

                     Padding(
                       padding: EdgeInsets.only(left: AppDimensions.safeBlockMinUnit*5,top: AppDimensions.safeBlockMinUnit*5),
                       child: Text("Transactions",
                           style:  AppTextStyle.secondaryLightBold(size: _subFont)),
                     ),
                  _studentPaymentSection(context)
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


    Widget _studentPaymentSection(BuildContext context){
      return ListView.builder(
          padding:EdgeInsets.symmetric(horizontal: AppDimensions.safeBlockMinUnit*3,vertical:AppDimensions.safeBlockMinUnit*6 ), 
          itemCount:2,
          controller: _scrollcontroller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index){           
            return _paymentRowSection(context,index);
          }
      );
  }
  Widget _paymentRowSection(BuildContext context,int index){
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
