import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString name = ''.obs;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController recontrollerEmail = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController recontrollerPassword = TextEditingController();
}
