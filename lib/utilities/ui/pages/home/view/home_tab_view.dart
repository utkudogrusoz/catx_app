import 'package:catx_app/utilities/ui/pages/home/view/student_home_view.dart';
import 'package:catx_app/utilities/ui/pages/home/view/teacher_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabView extends StatefulWidget {
  HomeTabView({Key? key}) : super(key: key);

  @override
  State<HomeTabView> createState() => _TabViewState();
}

class _TabViewState extends State<HomeTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Anasayfa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff7f39fb),
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                'Yüz yüze',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Çevrim içi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          StudentHomeView(),
          TeacherHomeView(),
        ],
      ),
    );
  }
}
