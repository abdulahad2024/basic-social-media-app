import 'package:social_media_app/export.dart';

class FriendsView extends GetView<FriendsController> {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FriendsController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              controller.allUser();
              controller.pendingRequests();
            },
            child: Text(
              'Friends',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppColors.primary600,
            indicatorWeight: 3,
            labelColor: AppColors.primary600,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Friend Requests"),
              Tab(text: "Peoples You"),
            ],
          ),
        ),
        body: const TabBarView(children: [RequestScreen(), AllFriendsScreen()]),
      ),
    );
  }
}
