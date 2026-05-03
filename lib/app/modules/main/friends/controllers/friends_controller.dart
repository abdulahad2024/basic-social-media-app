import 'package:get/get.dart';
import 'package:social_media_app/app/data/model/pending_request_model.dart';
import 'package:social_media_app/app/data/model/user_model.dart';
import 'package:social_media_app/app/data/services/api/friends_services.dart';

import '../../../../../export.dart';

class FriendsController extends GetxController {

  final FriendsServices friendsServices = FriendsServices();
  var isLoading = false.obs;
  var users = <User>[].obs;

  var pendingRequests = <PendingRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    allUser();
    allPendingRequest();
  }

  Future<void> allUser()async {

    try{
      isLoading.value = true;
      final response = await friendsServices.allUser();

      if(response == null){
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final responseData = jsonDecode(response.body);

      if(response.statusCode == 200){

        List data = responseData['data'];
        users.value = data.map((e) => User.fromJson(e)).toList();

      } else if(response.statusCode == 422){
        AppUtils.showError(responseData['errors'] ?? "failed");
        debugPrint("failed");
      } else {
        AppUtils.showError("Server error: ${response.statusCode}");
        debugPrint("Server error: ${response.statusCode}");
      }

    } catch(e){
      debugPrint("All User Error");
      AppUtils.showError("Something went wrong!");
    } finally{
      isLoading.value = false;
    }

  }


  Future<void> allPendingRequest()async {

    try{
      isLoading.value = true;
      final response = await friendsServices.pendingRequests();

      if(response == null){
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final responseData = jsonDecode(response.body);

      if(response.statusCode == 200){

        List data = responseData['data'] ?? [];
        pendingRequests.value = data.map((e) => PendingRequest.fromJson(e)).toList();
        print(data);
        print(pendingRequests);



      } else if(response.statusCode == 422){
        AppUtils.showError(responseData['errors'] ?? "failed");
        debugPrint("failed");
      } else {
        AppUtils.showError("Server error: ${response.statusCode}");
        debugPrint("Server error: ${response.statusCode}");
      }

    } catch(e){
      debugPrint("All User Error");
      AppUtils.showError("Something went wrong!");
    } finally{
      isLoading.value = false;
    }

  }


  var loadingIds = <int>[].obs;

  Future<void> sendFriendRequest(int receiverId) async {
    try {
      loadingIds.add(receiverId);

      final response =
      await friendsServices.sendFriendRequest(receiverId.toString());

      loadingIds.remove(receiverId);

      if (response == null) return;

      if (response.statusCode == 200) {
        final index = users.indexWhere((u) => u.id == receiverId);
        if (index != -1) {
          users[index].isSent = true;
          users[index].isReceived = false;
          users[index].isFriend = false;
          users.refresh();
        }
      }
    } catch (e) {
      loadingIds.remove(receiverId);
    }
  }




  Future<void> acceptRequest(int requestId, int senderId) async {
    try {
      loadingIds.add(senderId);

      final response = await friendsServices.acceptRequest(requestId);

      loadingIds.remove(senderId);

      if (response != null && response.statusCode == 200) {
        // ✅ remove from pending list
        pendingRequests.removeWhere((e) => e.id == requestId);
        pendingRequests.refresh();
      }
    } catch (e) {
      loadingIds.remove(senderId);
    }
  }

  Future<void> rejectRequest(int requestId, int senderId) async {
    try {
      loadingIds.add(senderId);

      final response = await friendsServices.declineRequest(requestId);

      loadingIds.remove(senderId);

      if (response != null && response.statusCode == 200) {
        pendingRequests.removeWhere((e) => e.id == requestId);
        pendingRequests.refresh();
      }
    } catch (e) {
      loadingIds.remove(senderId);
    }
  }




}
