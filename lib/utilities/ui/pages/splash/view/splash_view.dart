// ignore_for_file: omit_local_variable_types

import 'package:catx_app/utilities/services/auth_service.dart';
import 'package:catx_app/utilities/ui/pages/auth/view/auth_view.dart';
import 'package:catx_app/utilities/ui/pages/welcome/view/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  AuthenticationService authService = AuthenticationService();
  //OnBoardViewModel onBoardController = Get.put(OnBoardViewModel());
  late AnimationController controller;
  late Animation animation;
  late SharedPreferences sharedPref;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    Future.microtask(() async {
      // sharedPref = await SharedPreferences.getInstance();
      //  isViewed = sharedPref.getInt('onBoard')!;
      await _navigateToHome(authService, context);
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:const Color(0xff7f39fb),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: animation.value * 300,
                child: Image.asset('assets/images/icons/purple_cat.png'),
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  Future _navigateToHome(AuthenticationService authService, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var isViewedBoard = prefs.getInt('onBoardView');
    /*if (isViewedBoard != 0) {
      print('1.giriş');
      await Future.delayed(Duration(seconds: 2));
      await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OnBoardView()), (route) => true);
    }*/
    if (authService.isUserActive() == true) {
      print('2.giriş');

      await Future.delayed(Duration(seconds: 2));
      await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeView()), (route) => true);
    } else {
      print('3.giriş');

      await Future.delayed(Duration(seconds: 2));
      await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthView()), (route) => true);
    }
    print('3.giriş');
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icons/4x/sosyallio_logo.png'),
      ),
    );
  }
}
