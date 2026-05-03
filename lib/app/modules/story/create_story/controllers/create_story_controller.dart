import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:social_media_app/export.dart';

class CreateStoryController extends GetxController {
  var isLoading = false.obs;
  var selectedFile = Rxn<File>();
  var fileType = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickFile(bool isVideo) async {
    final XFile? file = isVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      selectedFile.value = File(file.path);
      fileType.value = isVideo ? 'video' : 'image';
    }
  }

  Future<void> uploadStory() async {
    if (selectedFile.value == null) {
      AppUtils.showError("Please select a file first");
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.addStories),
      );

      final AuthSession authSession = AuthSession();
      final String? token = await authSession.getToken();

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      String fieldName = fileType.value == 'video' ? 'video' : 'image';
      request.files.add(
        await http.MultipartFile.fromPath(fieldName, selectedFile.value!.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        Get.back(result: true);
        AppUtils.showSuccess("Story uploaded successfully!");
      } else {
        AppUtils.showError("Upload failed: ${response.body}");
      }
    } catch (e) {
      debugPrint("Story Upload Error: $e");
      AppUtils.showError("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}