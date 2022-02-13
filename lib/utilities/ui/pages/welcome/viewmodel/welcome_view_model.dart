import 'package:catx_app/utilities/ui/pages/home/view/home_tab_view.dart';
import 'package:catx_app/utilities/ui/pages/home/view/home_view.dart';
import 'package:catx_app/utilities/ui/pages/message/view/message_list_view.dart';
import 'package:catx_app/utilities/ui/pages/profile/view/profile_view.dart';
import 'package:catx_app/utilities/ui/pages/search/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeViewModel extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList<Widget> pageOptions = RxList<Widget>([
     HomeTabView(),
    const SearchView(),
    const MessageListView(),
    const ProfileView(),
  ]);
}
