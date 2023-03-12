//import 'package:device_preview/device_preview.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';

import 'constants/colors.dart';
import 'utils/dependencies.dart';
import 'utils/routes.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init().then((value) => {runApp(const LMSApp())});

  runApp(const LMSApp());
  /*runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => LMSApp(), // Wrap your app
  ),
);*/
}

class LMSApp extends StatelessWidget {
  const LMSApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'LMS',
        debugShowCheckedModeBanner: false,
        //initialBinding: HomeBinding(),
        initialRoute: '/',
        getPages: appRoutes,
        // routerDelegate: _appRouter.delegate(),
        // routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Utils.generateMaterialColorFromColor(
              ColorConstants.primaryThemeColor),
        ),
      ),
    );
  }
}
