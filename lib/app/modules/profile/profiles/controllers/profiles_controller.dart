import 'package:social_media_app/app/data/services/api/friends_services.dart';
import 'package:social_media_app/export.dart';

import '../../../../data/model/friend_list.dart';
class ProfilesController extends GetxController {

  var isLoading = false.obs;
  var profile = <String, dynamic>{}.obs;

  final AuthServices authServices = AuthServices();
  final FriendsServices f = FriendsServices();

  var friends = <Data>[].obs; // Data model list

  var posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    fetchFriends();
    getProfileData();
  }

  Future<void> getProfile() async {

    try{
      isLoading.value = true;

      final response = await authServices.getProfile();

      if(response == null){
        NetworkUtils.showNoInternetSnackbar();
        return;
      }
      profile.value = response['user'] ?? {};




    } catch(e){
      debugPrint("Get Profile Error: $e");
      AppUtils.showError("An unexpected error occurred!");
    } finally {
      isLoading.value = false;
    }

  }

  void fetchFriends() async {
    try {
      isLoading(true);
      var result = await f.getFriendList();
      if (result.isNotEmpty) {
        friends.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }

  void getProfileData() async {
    try {
      isLoading(true);
      var response = await f.myPost();

      if (response != null && response['status'] == true) {
        posts.assignAll(response['posts'] ?? []);
      }
    } finally {
      isLoading(false);
    }
  }

  void deleteMyPost(int postId) async {
    try {
      bool isDeleted = await f.deletePost(postId);

      if (isDeleted) {
        posts.removeWhere((post) => post['id'] == postId);

        Get.snackbar(
          "Success",
          "Post deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to delete the post. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Delete Controller Error: $e");
    }
  }


}
