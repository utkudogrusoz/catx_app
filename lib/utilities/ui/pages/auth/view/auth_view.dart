// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:catx_app/utilities/services/auth_service.dart';
import 'package:catx_app/utilities/ui/pages/auth/view/register_view.dart';
import 'package:catx_app/utilities/ui/pages/auth/view/signin_view.dart';
import 'package:catx_app/utilities/ui/pages/auth/viewmodel/auth_view_model.dart';
import 'package:catx_app/utilities/ui/pages/home/view/home_view.dart';
import 'package:catx_app/utilities/ui/pages/welcome/view/welcome_view.dart';
import 'package:catx_app/utilities/ui/widgets/button/custom_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7f39fb),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Center(
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/illustration/auth_1.png'),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CatX ',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Text(
                      '\'e',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Hoşgeldiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: const Text(
                    'Hem online, hem de yüzyüze ücretsiz eğitimler ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            CustomSigninButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SigninView(),
                  ),
                );
              },
              title: 'Email ile Giriş Yap',
              isIcon: true,
              iconData: Icons.email,
              color: Colors.white,
              textColor: Color(0xff7f39fb),
            ),
            CustomSigninButton(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('authWay', 'google');

                await _authService.signInWithGoogle().then(
                  (value) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 4), () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => WelcomeView()),
                            (route) => false,
                          );
                        });
                        return CircularProgressIndicator();
                      },
                    );
                  },
                );
              },
              title: 'Google ile Giriş Yap',
              isIcon: false,
              imagePath: 'assets/images/icons/google.png',
              color: Colors.white,
              textColor: Color(0xff7f39fb),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hesabınız yok mu? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
                        ),
                      );
                    },
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
