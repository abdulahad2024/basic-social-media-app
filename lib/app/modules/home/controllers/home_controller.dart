import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/modules/main/main/views/main_view.dart';
import 'package:social_media_app/app/modules/main/menus/views/menus_view.dart';
import 'package:social_media_app/app/modules/profile/profiles/views/profiles_view.dart';

import '../../main/friends/views/friends_view.dart';
import '../../main/notification/views/notification_view.dart';
import '../../main/watch/views/watch_view.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  List<Widget> pages = [
    MainView(),
    FriendsView(),
    WatchView(),
    ProfilesView()
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }


}
