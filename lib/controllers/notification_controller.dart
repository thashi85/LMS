import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/constants/colors.dart';
import 'package:lms/controllers/auth_controller.dart';
import 'package:lms/data/repository/user_repo.dart';
import 'package:lms/models/user.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constants/text_style.dart';

class NotificationController extends GetxController {
 
  final _userRepo = Get.find<UserRepo>();
  String messageTitle = "Empty";
  String messageBody = "alert";
  String deviceToken='';
  late FirebaseMessaging _firebaseMessaging;

  NotificationController():super();

  void registerNotification(User user) async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _firebaseMessaging = FirebaseMessaging.instance;
    getToken(user);
    

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      // 4. handle the received notifications
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        var  _notificationInfo=message.notification;
        if(_notificationInfo!=null){
          messageTitle= _notificationInfo.title??"";
          messageBody= _notificationInfo.body??"";
            debugPrint('messageTitle: $messageTitle  notificationAlert : $messageBody');

            showNotification(
              _notificationInfo.title??"",
              _notificationInfo.body??"",
              message.data['time']!=null ? DateTime.parse(message.data['time'].toString()): DateTime.now(),
              message.data['message_duration']!=null? (int.parse(message.data['message_duration'].toString())): 2);
        }
        /* showSimpleNotification(
          Text(_notificationInfo!.title!),
          leading: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration:  const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
          subtitle: Text(_notificationInfo.body??""),
          background: ColorConstants.secondaryThemeColor,
          duration: const Duration(seconds: 2),
        );*/
         update();
      });

    } else {
      debugPrint('User declined or has not accepted permission');
    }
    //5.  background messages
    FirebaseMessaging.onBackgroundMessage(NotificationController.firebaseMessagingBackgroundHandler);
  }
  static void showNotification(String title,String body,DateTime dt,int duration){
    showSimpleNotification( Text(body +' '+DateFormat('hh:mm: a on yyyy MMM dd').format(dt),
                              style: AppTextStyle.primaryLightMedium( size: 16)),
                      leading: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration:  const BoxDecoration(
                                  color: ColorConstants.primaryThemeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.calendar_month_outlined,  color: Colors.white),
                                  ),
                                ),
                              ),
                      subtitle: Text(title,
                              style: AppTextStyle.primaryLightMedium( size: 14)),
                      background: ColorConstants.secondaryThemeColor,
                      duration: Duration(seconds: duration),
                    );
  }
  void getToken(User user) async {
    await _firebaseMessaging.getToken().then((token) {
      if(token!=null){
        debugPrint(token);
        deviceToken=token;
       
          var _alreadyAdded=user.devices.where((element) => element.deviceRef==deviceToken).toList();
          if(_alreadyAdded.isEmpty){
              _userRepo.addDevice(user.userId.toString(), deviceToken);
              user.devices.add(Device(id:user.devices.length,deviceRef: deviceToken ));
          }
        
        update();
      }
    });
  }
  static Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
     var  _notificationInfo=message.notification;

        /*var _ctrl=Get.find<NotificationController>();
         _ctrl.messageTitle= _notificationInfo?.title??"";
         _ctrl.messageBody= _notificationInfo?.body??"";
          if(_notificationInfo!=null){
        
            debugPrint('messageTitle: $_ctrl.messageTitle  notificationAlert : $_ctrl.messageBody');

            showNotification(
              _notificationInfo.title??"",
              _notificationInfo.body??"",
                 message.data['time']!=null ? DateTime.parse(message.data['time'].toString()): DateTime.now(),
              message.data['message_duration']!=null? (int.parse(message.data['message_duration'].toString())): 2);
        }*/
         
         /*showSimpleNotification(
          Text(_notificationInfo!.title!),
          leading: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration:  const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'B1',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
          subtitle: Text(_notificationInfo.body??""),
          background: Colors.cyan.shade700,
          duration: const Duration(seconds: 2),
        );*/
         //_ctrl.update();
  }
  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
        var  _notificationInfo=initialMessage.notification;
         messageTitle= _notificationInfo?.title??"";
         messageBody= _notificationInfo?.body??"";
         
    }
  }

  

}