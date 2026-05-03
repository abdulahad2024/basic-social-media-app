import 'dart:io';
import 'package:social_media_app/app/data/services/api/post_services.dart';
import 'package:social_media_app/export.dart';

import '../../main/controllers/main_controller.dart';

class CreatePostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedFile = Rxn<File>();
  var isVideo = false.obs;

  // Edit Mode Variables
  var isEditMode = false.obs;
  var postId = RxnInt();
  var oldImageUrl = RxnString();
  var oldVideoUrl = RxnString();

  final PostServices _postServices = PostServices();
  final MainController mainController = Get.find();
  final ProfilesController profilesController = Get.find();



  final contentController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      isEditMode.value = true;
      var post = Get.arguments;

      postId.value = post['id'];
      contentController.text = post['content'] ?? "";

      if (post['type'] == 'image' && post['image'] != null) {
        oldImageUrl.value = post['image'].toString();
        isVideo.value = false;
      }
      else if (post['type'] == 'video' && post['video'] != null) {
        oldVideoUrl.value = post['video'].toString();
        isVideo.value = true;
      }
    }
  }

  Future<void> submitPost() async {
    final content = contentController.text.trim();
    if (content.isEmpty && selectedFile.value == null && oldImageUrl.value == null && oldVideoUrl.value == null) {
      AppUtils.showError("Please enter content or select media");
      return;
    }

    try {
      isLoading.value = true;
      dynamic response;

      if (isEditMode.value) {
        // Update Logic
        response = await _postServices.updateMyPost(
          postId: postId.value!,
          content: content,
          imageFile: (isVideo.value == false) ? selectedFile.value : null,
          videoFile: (isVideo.value == true) ? selectedFile.value : null,
        );
      } else {
        // Create Logic
        response = await _postServices.createPost(
          content: content,
          imageFile: (isVideo.value == false) ? selectedFile.value : null,
          videoFile: (isVideo.value == true) ? selectedFile.value : null,
        );
      }

      if (response != null && (response.statusCode == 201 || response.statusCode == 200)) {
        final responseData = jsonDecode(response.body);
        String msg = responseData['message'] ?? (isEditMode.value ? "Post updated!" : "Post published!");
        print("Response: $responseData");

        Get.back();
        mainController.fetchFeeds();
        profilesController.getProfileData();

        AppUtils.showSuccess(msg);
      } else {
        final responseData = jsonDecode(response!.body);
        AppUtils.showError(responseData['message'] ?? "Failed to process post");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickMedia({required bool fromVideo}) async {
    final XFile? media = fromVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (media != null) {
      selectedFile.value = File(media.path);
      isVideo.value = fromVideo;
      oldImageUrl.value = null;
      oldVideoUrl.value = null;
    }
  }

  void removeFile() {
    selectedFile.value = null;
    oldImageUrl.value = null;
    oldVideoUrl.value = null;
    isVideo.value = false;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}