import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../export.dart';

class PostServices {


  final AuthSession authSession = AuthSession();

  Future<http.Response?> createPost({
    required String content,
    File? imageFile,
    File? videoFile,
  }) async {
    try {

      String? token = await authSession.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.createPost));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['content'] = content;

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ));
      }

      if (videoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
        ));
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      debugPrint("Post Service Error: $e");
      return null;
    }
  }





  Future<http.Response> toggleLike(int postId) async {

    String? token = await authSession.getToken();

    final url = Uri.parse(ApiUrl.toggleLike(postId));
    return await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }


  Future<http.Response?> postComment(int postId, String comment) async {
    try {
      String? token = await authSession.getToken();
      final url = Uri.parse(ApiUrl.storeComment(postId));

      return await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'comment': comment}),
      );
    } catch (e) {
      debugPrint("Comment Service Error: $e");
      return null;
    }
  }



// getFeeds function-ta eibhabe update korun
  Future<http.Response?> getFeeds() async {
    try {
      // 1. Token load kora joruri jate server user-ke chinhte pare
      String? token = await authSession.getToken();

      final response = await http.get(
        Uri.parse(ApiUrl.allPosts),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 2. Token pathalei server 'is_liked' status true pathabe
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print("Feed Service Error: $e");
      return null;
    }
  }

// getVideo function-teo same bhabe token add korun
  Future<http.Response?> getVideo() async {
    try {
      String? token = await authSession.getToken();

      final response = await http.get(
        Uri.parse(ApiUrl.videoPosts),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print("Feed Service Error: $e");
      return null;
    }
  }



  Future<http.Response?> updateMyPost({
    required int postId,
    required String content,
    File? imageFile,
    File? videoFile,
  }) async {
    try {
      final token = await authSession.getToken();
      var request = http.MultipartRequest(
          'POST', // Laravel-এ ফাইল আপলোডের জন্য POST মেথডই নিরাপদ
          Uri.parse("${ApiUrl.updatePosts}/$postId")
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      request.fields['content'] = content;

      // ইমেজ ফাইল চেক
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      }

      // ভিডিও ফাইল চেক (এটি তোমার আগের কোডে মিসিং ছিল)
      if (videoFile != null) {
        request.files.add(await http.MultipartFile.fromPath('video', videoFile.path));
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);

    } catch (e) {
      debugPrint("Update Error: $e");
      return null;
    }
  }


}