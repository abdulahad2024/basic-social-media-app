import 'package:social_media_app/export.dart';

class EduInfoController extends GetxController {
  final isLoading = false.obs;

  final eduController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();

  final AuthServices authServices = AuthServices();

  Future<void> eduInfo() async {
    if (eduController.text.isEmpty ||
        aboutController.text.isEmpty ||
        addressController.text.isEmpty) {
      AppUtils.showWarning("Fill in all the boxes!");
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        'education': eduController.text.trim(),
        'address': addressController.text.trim(),
        'about': aboutController.text.trim(),
      };

      final response = await authServices.personalInfo(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Get.toNamed(Routes.CREATE_PASSWORD);
        } else {
          String errorMsg =
              result['messages'] ?? "Failed to save personal info!";
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      debugPrint("Personal Info Error: $e");
      AppUtils.showError("There was an error! Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
