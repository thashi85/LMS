import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_dimensions.dart';
import '../widgets/custom_btn.dart';
import '../shared/shared_component.dart';

class LoginPage extends StatelessWidget {
   final _dimension = Get.find<AppDimensions>();
 // final _authController = Get.find<AuthController>();
  final List<dynamic> _options=[{"id":"1","name":"Parent"},{"id":"2","name":"Student"},{"id":"3","name":"Teacher"}];
  final _formKey=GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginPage({ Key? key }) : super(key: key);
 
  

  @override
  Widget build(BuildContext context) {
    // String _selectedOption =_authController.loginOption;
    _dimension.init(context);
    var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    var _normalFont = _dimension.getFontNormal(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: SharedComponentUI. mainLogoLayoutUI(context, _dimension,  
      Container(
        
        padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),
        margin: EdgeInsets.all(AppDimensions.safeBlockMinUnit*5),
        decoration: BoxDecoration(
          color: ColorConstants.primaryThemeColor,
         borderRadius: BorderRadius.all(Radius.circular(AppDimensions.safeBlockMinUnit*5))
        ),
        child: GetBuilder<AuthController>(
              builder: ((_authController) =>
                        Column(
                      //direction: Axis.vertical,
                      children: [
                        Row(
                          children: [
                             for (var i in _options)
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: i["id"],
                                          fillColor: MaterialStateColor.resolveWith(
                                              (states) => const Color.fromARGB(255, 88, 41, 36)),
                                          groupValue:_authController.loginOption,
                                          onChanged: (dynamic value) {
                                            //_selectedOption=value;
                                          _authController.setLoginOption(value);
                                        // build(context);
                                        
                                          }),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            _authController.setLoginOption( i["id"]);
                                          },
                                          child: Text(i["name"],
                                              style: AppTextStyle.primaryLightRegular(size: _normalFont),
                                                                              ),
                                        ))
                                    ],
                                  ),
                                )
                                 
                            ],
                          ),
                          Form(
                          key:_formKey ,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                _formRowContent(context, "Username", Icons.person, false,
                                    _authController.username),
                                _formRowContent(context, "Password", Icons.lock_outline, true,
                                    _authController.password),
                                Padding(
                                  padding: EdgeInsets.only(top:AppDimensions.safeBlockMinUnit*2 ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    
                                    children: [
                                      Container(
                                        width: _w * 70,
                                        height: _h* 10,                                       
                                        padding: EdgeInsets.all(AppDimensions.safeBlockMinUnit*3),
                                        child: CustomButton(
                                            text: "Login",
                                            isloading: _authController.isLoading,
                                            bgColor: ColorConstants.primaryDarkButtonColor,
                                            txtColor: ColorConstants.primaryLightTextColor,
                                            onTap: () {
                                              if (_formKey.currentState!.validate()) {                                                 
                                                  _formKey.currentState!.save();
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                 _authController.signIn(context,_scaffoldKey);
                                                 
                                                } else {
                                                  return;
                                                }
                                              
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          ),
                       
                      
                      ],
                    )
                      
                    )            
                    )    
      )
      )
    );
  }

  Widget _formRowContent(BuildContext context, String label, IconData icon,
      bool isPassword, TextEditingController? controller,{bool isRequired=true}) {
    //var _h = _dimension.getSafeBlockSizeVertical(context);
    var _w = _dimension.getSafeBlockSizeHorizontal(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _w * 75,
          margin: EdgeInsets.only(top: 30, left: _w * 2, right: _w * 2),
          // padding: EdgeInsets.all(Dimensions.safeBlockHorizontal*2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.lightBackground1Color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: TextFormField(
              controller: controller,
              obscureText: isPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:  (val) => isRequired && val!.isEmpty   ? (label+" is required ") : null,
              decoration: InputDecoration(
                  icon: Icon(icon),
                  fillColor: ColorConstants.lightBackground1Color,
                  border: InputBorder.none,
                  hintText: label),
            ),
          ),
        ),
      ],
    );
  }
}
