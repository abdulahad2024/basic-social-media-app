import 'package:get/get.dart';
import 'package:social_media_app/app/data/model/user_friends.dart';
import 'package:social_media_app/app/data/model/user_profile_model.dart';
import '../../../../../export.dart';
import '../../../../data/services/api/user_profile_services.dart';

class UserProfileController extends GetxController {
  int? id;
  final UserProfileServices userProfileServices = UserProfileServices();
  var isLoading = true.obs;

  var userProfile = UserProfileModel().obs;
  var friends = <Data>[].obs;

  List<Post> get posts => userProfile.value.posts ?? [];

  @override
  void onInit() {
    super.onInit();
    userId();
    if (id != null) {
      loadAllData();
    }
  }

  void userId() {
    id = Get.arguments as int?;
  }

  Future<void> loadAllData() async {
    isLoading.value = true;
    await Future.wait([
      getUserProfile(id!),
      userFriendList(),
    ]);
    isLoading.value = false;
  }

  Future<void> getUserProfile(int id) async {
    try {
      final response = await userProfileServices.otherUserProfile(id.toString());
      if (response != null && response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        userProfile.value = UserProfileModel.fromJson(responseData);
      }
    } catch (e) {
      debugPrint("Profile Load Error: $e");
    }
  }

  Future<void> userFriendList() async {
    try {
      final response = await userProfileServices.userFriendsList(id.toString());
      if (response != null && response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List data = responseData['data'] ?? [];
        friends.assignAll(data.map((e) => Data.fromJson(e)).toList());
      }
    } catch (e) {
      debugPrint("Friend List Error: $e");
    }
  }


  Future<void> unFriends(String userId) async {
    try {
      final response = await userProfileServices.unFriends(userId);
      if (response != null && response.statusCode == 200) {
        Get.back();
        print(response.body);
        AppUtils.showSuccess("UnFriend Successfully");
        await loadAllData();
        print(response.body);
      } else if (response != null && response.statusCode == 422) {
        print(response.body);
        AppUtils.showError("Something went wrong");
      }
    } catch (e) {
      debugPrint("UnFriend Error: $e");
      }
    }

  }






