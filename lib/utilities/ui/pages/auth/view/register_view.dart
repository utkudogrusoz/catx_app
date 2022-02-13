// ignore_for_file: prefer_const_constructors

import 'package:catx_app/utilities/services/auth_service.dart';
import 'package:catx_app/utilities/ui/pages/auth/viewmodel/auth_view_model.dart';
import 'package:catx_app/utilities/ui/pages/welcome/view/welcome_view.dart';
import 'package:catx_app/utilities/ui/widgets/button/custom_signin_button.dart';
import 'package:catx_app/utilities/ui/widgets/textfield/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            paintedSideBuild(),
            formBuild(context),
          ],
        ),
      ),
    );
  }

  Expanded formBuild(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        color: const Color(0xff7f39fb),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Form(
            key: _authViewModel.registerFormKey,
            child: Column(
              children: [
                SizedBox(height: 32),
                nameTextFieldBuild(),
                mailTextFieldBuild(),
                passwordTextFieldBuild(),
                CustomSigninButton(
                  onTap: () async {
                    await registerBuild(
                      context: context,
                      formKey: _authViewModel.authFormKey,
                      controllerEmail: _authViewModel.controllerEmail,
                      controllerPassword: _authViewModel.controllerPassword,
                      email: _authViewModel.email.value,
                      password: _authViewModel.password.value,
                      name: _authViewModel.name.value,
                      controllerName: _authViewModel.controllerName,
                    );
                  },
                  title: 'Kayıt Ol',
                  isIcon: true,
                  iconData: Icons.email,
                  color: const Color(0xff7f39fb),
                  textColor: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextField passwordTextFieldBuild() {
    return CustomTextField(
      value: _authViewModel.password.value,
      textEditingController: _authViewModel.controllerPassword,
      obscureTextField: false,
      visible: false,
      hintText: 'şifre',
      labelText: 'şifre',
      prefixIcon: Icon(Icons.mail_outline),
      suffixIcon: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter some text';
        }
        return null;
      },
    );
  }

  CustomTextField mailTextFieldBuild() {
    return CustomTextField(
      value: _authViewModel.email.value,
      textEditingController: _authViewModel.controllerEmail,
      obscureTextField: false,
      visible: false,
      hintText: 'Email',
      labelText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
      suffixIcon: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter some text';
        }
        return null;
      },
    );
  }

  CustomTextField nameTextFieldBuild() {
    return CustomTextField(
      value: _authViewModel.name.value,
      textEditingController: _authViewModel.controllerName,
      obscureTextField: false,
      visible: false,
      hintText: 'isim',
      labelText: 'İsim',
      prefixIcon: Icon(Icons.mail_outline),
      suffixIcon: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter some text';
        }
        return null;
      },
    );
  }

  Expanded paintedSideBuild() {
    return Expanded(
      flex: 1,
      child: Container(
        color: const Color(0xff7f39fb),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kayıt Ol',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/icons/purple_cat.png', fit: BoxFit.fill),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerBuild({
    @required BuildContext? context,
    @required GlobalKey<FormState>? formKey,
    @required TextEditingController? controllerEmail,
    @required TextEditingController? controllerName,
    @required TextEditingController? controllerPassword,
    @required String? email,
    @required String? name,
    @required String? password,
  }) {
    return _authService
        .registerEmailAndPassword(
          context: context,
          formKey: formKey,
          controllerEmail: controllerEmail,
          controllerPassword: controllerPassword,
          email: email,
          password: password,
          name: name,
          controllerName: controllerName,
        )
        .then(
          (value) => _authService.resetDatas(
            controllerEmail: controllerEmail,
            controllerPassword: controllerPassword,
            email: email,
            password: password,
            name: name,
            controllerName: controllerName,
          ),
        );
  }
}


/*
_authService
        .registerEmailAndPassword(
          context: context,
          formKey: _authViewModel.registerFormKey,
          controllerEmail: _authViewModel.controllerEmail,
          controllerPassword: _authViewModel.controllerPassword,
          email: _authViewModel.email.value,
          password: _authViewModel.password.value,
          name: _authViewModel.name.value,
          controllerName: _authViewModel.controllerName,
        )
        .then(
          (value) => _authService.resetDatas(
            controllerEmail: _authViewModel.controllerEmail,
            controllerPassword: _authViewModel.controllerPassword,
            controllerName: _authViewModel.controllerName,
            email: _authViewModel.email.value,
            password: _authViewModel.password.value,
            name: _authViewModel.name.value,
          ),
        ); */