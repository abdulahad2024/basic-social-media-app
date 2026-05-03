import 'package:get/get.dart';
import 'package:story_view/story_view.dart';
import '../../../../data/model/story_model.dart';
import '../../../../data/services/seassion/auth_seassion.dart';
import '../../../../utils/api_url/api_url.dart';
import 'package:http/http.dart' as http;

class ViewStoryController extends GetxController {
  // story_view প্যাকেজের নিজস্ব কন্ট্রোলার
  final storyController = StoryController();

  // স্টোরি আইটেম লিস্ট (RxList)
  final storyItems = <StoryItem>[].obs;
  var isInitialized = false.obs;
  var isLoading = false.obs;

  void initializeStories(List<StoryModel> stories) {
    // যদি আগে থেকেই ইনিশিয়ালাইজ করা থাকে তবে পুনরায় করবে না
    if (isInitialized.value) return;

    storyItems.clear(); // পুরানো ডাটা ক্লিয়ার করা

    for (var story in stories) {
      final String fullUrl = ApiUrl.imageUrl + story.mediaUrl;

      if (story.type == 'video') {
        storyItems.add(
          StoryItem.pageVideo(
            fullUrl,
            controller: storyController,
            duration: const Duration(seconds: 30), // ভিডিওর জন্য সর্বোচ্চ সময়
          ),
        );
      } else {
        storyItems.add(
          StoryItem.pageImage(
            url: fullUrl,
            controller: storyController,
          ),
        );
      }
    }
    isInitialized.value = true;
  }




  Future<void> deleteStory(int storyId) async {
    try {
      isLoading.value = true;

      final AuthSession authSession = AuthSession();
      final String? token = await authSession.getToken();

      final response = await http.delete(
        Uri.parse('${ApiUrl.deleteStory}/$storyId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // আপনার স্টোর করা টোকেন
        },
      );

      if (response.statusCode == 200) {
        Get.back(); // ডিলিট সফল হলে স্টোরি ভিউ থেকে বের হয়ে যাবে
        Get.snackbar('Success', 'Story deleted successfully');

        // আপনার স্টোরি লিস্ট থেকে ওই স্টোরিটি রিমুভ করার জন্য (ঐচ্ছিক)
        // storyItems.removeWhere((item) => item.id == storyId);
      } else {
        Get.snackbar('Error', 'Failed to delete story');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }













  @override
  void onClose() {
    storyController.dispose();
    super.onClose();
  }
}