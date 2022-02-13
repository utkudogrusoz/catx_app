// ignore_for_file: prefer_const_constructors

import 'package:catx_app/utilities/ui/pages/welcome/viewmodel/welcome_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final WelcomeViewModel _welcomeViewModel = Get.put(WelcomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7f39fb),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavBarBuild(context),
      body: Obx(
        () {
          return _welcomeViewModel.pageOptions.elementAt(_welcomeViewModel.selectedIndex.value);
        },
      ),
    );
  }

  Theme bottomNavBarBuild(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomAppBarColor: Colors.transparent,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: bottomNavBarItems(context),
        ),
      ),
    );
  }

  SizedBox bottomNavBarItems(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Obx(
        () => BottomAppBar(
          elevation: 8,
          clipBehavior: Clip.none,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: _welcomeViewModel.selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff7f39fb),

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Ana Sayfa'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Arama'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: 'Mesaj'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Profil'),
            ],
            onTap: (value) {
              _welcomeViewModel.selectedIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
