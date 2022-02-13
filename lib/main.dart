import 'package:catx_app/utilities/ui/pages/auth/view/auth_view.dart';
import 'package:catx_app/utilities/ui/pages/splash/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: SplashView(),
    );
  }
}
