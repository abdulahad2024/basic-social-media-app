import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../export.dart';
import '../../../../data/model/story_model.dart';
import '../../../../data/services/api/post_services.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  var postList = [].obs;
  var isLoading = true.obs;

  final PostServices _postServices = PostServices();

  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    fetchFeeds();
    getStories();
    super.onInit();
  }

  Future<void> fetchFeeds() async {
    try {
      isLoading.value = true;

      final response = await _postServices.getFeeds();

      if (response != null && response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        if (result['status'] == true) {
          postList.assignAll(result['data']);
        }
      } else {
        AppUtils.showError("Failed to load feed");
      }
    } catch (e) {
      print("Feed Controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> toggleLike(int postId, int index) async {
    if (index < 0 || index >= postList.length) return;

    final currentPost = postList[index];

    // Backup data for rollback
    bool previousStatus = currentPost['is_liked'] == true ||
        currentPost['is_liked'].toString() == '1' ||
        currentPost['is_liked'].toString() == 'true';
    int previousLikes = int.tryParse(currentPost['likes_count'].toString()) ?? 0;

    try {
      // --- STEP 1: UI-TE INSTANT CHANGE ---
      // Notun Map reference toiri kora (Must do for GetX)
      final updatedPost = Map<String, dynamic>.from(currentPost);
      updatedPost['is_liked'] = !previousStatus;
      updatedPost['likes_count'] = !previousStatus ? previousLikes + 1 : previousLikes - 1;

      postList[index] = updatedPost;
      postList.refresh(); // List-ke bolbe rebuild hote

      // --- STEP 2: API CALL ---
      final response = await _postServices.toggleLike(postId);

      if (response != null && response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Server response theke status set kora
        final serverPost = Map<String, dynamic>.from(postList[index]);
        serverPost['is_liked'] = result['is_liked'] == true || result['is_liked'].toString() == '1';
        serverPost['likes_count'] = result['likes_count'] ?? serverPost['likes_count'];

        postList[index] = serverPost;
        postList.refresh();
      } else {
        _rollback(index, previousStatus, previousLikes);
      }
    } catch (e) {
      _rollback(index, previousStatus, previousLikes);
    }
  }








  // Fail korle ager state-e niye jaoar function
  void _rollback(int index, bool status, int count) {
    if (index >= 0 && index < postList.length) {
      final rollbackPost = Map<String, dynamic>.from(postList[index]);
      rollbackPost['is_liked'] = status;
      rollbackPost['likes_count'] = count;
      postList[index] = rollbackPost;
      postList.refresh();

      // User-ke error message dekhano
      Get.snackbar(
        "Error",
        "Network error! Like sync hoyni.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }








  Future<void> addComment(int postId, int index) async {
    String commentText = commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      final response = await _postServices.postComment(postId, commentText);

      if (response != null &&
          (response.statusCode == 201 || response.statusCode == 200)) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final data = result['data'] ?? result;
        final commentData = data['comment'] ?? "";
        print(commentData);

        var newComment = {
          "id": commentData['id'] ?? DateTime.now().millisecondsSinceEpoch,
          "comment": commentText,
          "created_at": DateTime.now().toIso8601String(),
          "user": {
            "id": commentData['user'] != null
                ? commentData['user']['id']
                : null,
            "name": commentData['user'] != null
                ? commentData['user']['name']
                : "User",
            "profile_image": commentData['user'] != null
                ? commentData['user']['profile_image']
                : null,
          },
        };

        var targetPost = Map<String, dynamic>.from(postList[index]);

        List currentComments = targetPost['comments'] != null
            ? List.from(targetPost['comments'])
            : [];

        currentComments.insert(0, newComment);

        targetPost['comments'] = currentComments;
        targetPost['comments_count'] = (targetPost['comments_count'] ?? 0) + 1;

        postList[index] = targetPost;
        postList.refresh();

        commentController.clear();
        AppUtils.showSuccess("Comment added successfully!");
        FocusManager.instance.primaryFocus?.unfocus();
      }
    } catch (e) {
      debugPrint("Update Error: $e");
      AppUtils.showError("Something went wrong!");
    }
  }

  Future<void> sharePost(dynamic post) async {
    try {
      String content = post['content'] ?? "";
      String? imagePath = post['image'];
      String? videoPath = post['video'];

      if (imagePath != null && imagePath.isNotEmpty) {
        String imageUrl = ApiUrl.imageUrl + imagePath;

        final response = await http.get(Uri.parse(imageUrl));
        final directory = await getTemporaryDirectory();
        final file = await File(
          '${directory.path}/temp_share_image.png',
        ).create();
        await file.writeAsBytes(response.bodyBytes);

        await Share.shareXFiles([XFile(file.path)], text: content);
      }
      else if (videoPath != null && videoPath.isNotEmpty) {
        String videoUrl = ApiUrl.imageUrl + videoPath;

        await Share.share("$content\n\nWatch Video: $videoUrl");
      }
      else if (content.isNotEmpty) {
        await Share.share(content);
      }
      else {
        print("Nothing to share");
      }
    } catch (e) {
      debugPrint("Sharing Error: $e");
    }
  }

  var storyGroups = <StoryGroup>[].obs;

  Future<void> getStories() async {
    final AuthSession authSession = AuthSession();
    final String? token = await authSession.getToken();

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(ApiUrl.stories),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> data = responseData['data'];

        List<StoryGroup> tempGroups = [];
        data.forEach((key, value) {
          List<StoryModel> stories = (value as List)
              .map((e) => StoryModel.fromJson(e))
              .toList();
          tempGroups.add(StoryGroup(userId: int.parse(key), stories: stories));
        });

        storyGroups.value = tempGroups;
      }
    } catch (e) {
      print("Story Error: $e");
    } finally {
      isLoading.value = false;
    }
  }






}
