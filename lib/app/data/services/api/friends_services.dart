import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:social_media_app/app/data/model/friend_list.dart';

import '../../../../export.dart';

class FriendsServices {
  final AuthSession authSession = AuthSession();

  Future<http.Response?> allUser() async {
    try {
      final String? token = await authSession.getToken();

      final url = Uri.parse(ApiUrl.allUser);
      final response = http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      debugPrint("All User Error: $e");
    }
    return null;
  }

  Future<http.Response?> pendingRequests() async {
    try {
      final String? token = await authSession.getToken();
      final url = Uri.parse(ApiUrl.pendingRequests);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      debugPrint("Pending Requests Service Error: $e");
      return null;
    }
  }

  Future<http.Response?> sendFriendRequest(String receiverId) async {
    try {
      final String? token = await authSession.getToken();
      final url = Uri.parse(ApiUrl.sendFriendRequest);

      // ১. ম্যাপ তৈরি করা
      final Map<String, String> receiverIdMap = {
        "receiver_id": receiverId
      };

      // ২. রিকোয়েস্ট পাঠানো
      final response = await http.post(
        url,
        body: jsonEncode(receiverIdMap), // JSON হিসেবে পাঠাচ্ছেন
        headers: {
          "Content-Type": "application/json", // এটি অবশ্যই লাগবে কারণ আপনি jsonEncode করছেন
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      debugPrint("Send Friend Request Service Error: $e");
      return null;
    }
  }


  Future<http.Response?> acceptRequest(int requestId) async {
    try {
      final token = await authSession.getToken();

      final url = Uri.parse(ApiUrl.acceptFriendRequest(requestId));

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      debugPrint("Accept Request Error: $e");
      return null;
    }
  }

  Future<http.Response?> declineRequest(int requestId) async {
    try {
      final token = await authSession.getToken();

      final url = Uri.parse(ApiUrl.declineFriendRequest(requestId)
      );

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      debugPrint("Decline Request Error: $e");
      return null;
    }
  }

  Future<List<Data>> getFriendList() async {
    try {
      final token = await authSession.getToken();
      final url = Uri.parse(ApiUrl.friendList);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // Body decode kore FriendList model-e convert kora
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final friendListModel = FriendList.fromJson(responseData);

        // Sudhu users (data) list-ti return korchi
        return friendListModel.data ?? [];
      } else {
        debugPrint("Server Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Get Friend List Error: $e");
      return [];
    }
  }


  Future<Map<String, dynamic>?> myPost() async {
    try {
      final token = await authSession.getToken();
      final url = Uri.parse(ApiUrl.myPost);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("My Post Fetch Error: $e");
      return null;
    }
  }



  Future<bool> deletePost(int postId) async {
    try {
      final token = await authSession.getToken();
      final url = Uri.parse("${ApiUrl.deletePosts}/$postId");

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("Failed to delete: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Error deleting post: $e");
      return false;
    }
  }









}
