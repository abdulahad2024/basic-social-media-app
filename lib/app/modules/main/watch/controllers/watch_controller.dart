import 'package:share_plus/share_plus.dart';
import 'package:social_media_app/app/data/model/video_model.dart';
import 'package:social_media_app/app/modules/main/watch/controllers/video_manager.dart';

import '../../../../../export.dart';
import '../../../../data/services/api/post_services.dart';

class WatchController extends GetxController {
  final PostServices postServices = PostServices();

  var video = Video().obs;

  /// VIDEO LIST
  var postList = [].obs;

  /// CURRENT PLAYING INDEX — VideoManager-এ রাখা হয়েছে
  final VideoManager videoManager = Get.put(VideoManager());

  /// Convenience getter
  RxInt get currentIndex => videoManager.activeIndex;

  void changeIndex(int index) {
    videoManager.activeIndex.value = index;
  }

  /// LOADING
  var isLoading = false.obs;

  /// COMMENT
  final TextEditingController commentController = TextEditingController();

  List<Data> get data => video.value.data ?? [];

  @override
  void onInit() {
    super.onInit();
    getVideo();
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  /// =========================================================
  /// FETCH VIDEOS
  /// =========================================================
  Future<void> getVideo() async {
    try {
      isLoading.value = true;

      final response = await postServices.getVideo();

      if (response != null && response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        video.value = Video.fromJson(responseData);

        postList.assignAll(responseData['data']);

        // প্রথম video-র জন্য index 0 set করা
        videoManager.activeIndex.value = 0;
      } else {
        AppUtils.showError("Something went wrong");
      }
    } catch (e) {
      debugPrint("Watch Controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================
  /// LIKE FUNCTION
  /// =========================================================
  Future<void> toggleLike(int postId, int index) async {
    var post = Map<String, dynamic>.from(postList[index]);

    bool previousLikedStatus = post['is_liked'] ?? false;
    int previousLikesCount = post['likes_count'] ?? 0;

    /// OPTIMISTIC UPDATE
    post['is_liked'] = !previousLikedStatus;
    post['likes_count'] = !previousLikedStatus
        ? previousLikesCount + 1
        : previousLikesCount - 1;

    postList[index] = post;
    postList.refresh();

    try {
      final response = await postServices.toggleLike(postId);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        post['is_liked'] = result['is_liked'] ?? post['is_liked'];
        post['likes_count'] = result['likes_count'] ?? post['likes_count'];

        postList[index] = post;
        postList.refresh();
      } else {
        rollbackLike(index, previousLikedStatus, previousLikesCount);
      }
    } catch (e) {
      rollbackLike(index, previousLikedStatus, previousLikesCount);
      debugPrint("Like Error: $e");
    }
  }

  void rollbackLike(int index, bool status, int count) {
    var rollbackPost = Map<String, dynamic>.from(postList[index]);
    rollbackPost['is_liked'] = status;
    rollbackPost['likes_count'] = count;
    postList[index] = rollbackPost;
    postList.refresh();
    AppUtils.showError("Something went wrong");
  }

  /// =========================================================
  /// COMMENT FUNCTION
  /// =========================================================
  Future<void> addComment(int postId, int index) async {
    String commentText = commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      final response = await postServices.postComment(postId, commentText);

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final result = jsonDecode(response.body);
        final data = result['data'] ?? result;
        final commentData = data['comment'];

        Map<String, dynamic> newComment = {
          "id": commentData?['id'] ?? DateTime.now().millisecondsSinceEpoch,
          "comment": commentText,
          "created_at": DateTime.now().toIso8601String(),
          "user": {
            "id": commentData?['user']?['id'],
            "name": commentData?['user']?['name'] ?? "User",
            "profile_image": commentData?['user']?['profile_image'],
          }
        };

        var updatedPost = Map<String, dynamic>.from(postList[index]);
        List comments = updatedPost['comments'] != null
            ? List.from(updatedPost['comments'])
            : [];

        comments.insert(0, newComment);
        updatedPost['comments'] = comments;
        updatedPost['comments_count'] =
            (updatedPost['comments_count'] ?? 0) + 1;

        postList[index] = updatedPost;
        postList.refresh();

        commentController.clear();
        FocusManager.instance.primaryFocus?.unfocus();

        AppUtils.showSuccess("Comment added successfully");
      }
    } catch (e) {
      debugPrint("Comment Error: $e");
      AppUtils.showError("Failed to comment");
    }
  }

  /// =========================================================
  /// SHARE
  /// =========================================================
  Future<void> shareVideo(dynamic post) async {
    try {
      String content = post['content'] ?? "";
      String videoPath = post['video'] ?? "";
      String url = "${ApiUrl.imageUrl}$videoPath";
      await Share.share("$content\n\n$url");
    } catch (e) {
      debugPrint("Share Error: $e");
    }
  }
}