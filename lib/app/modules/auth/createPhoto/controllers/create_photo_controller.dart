import 'dart:io';
import 'package:social_media_app/export.dart';

class CreatePhotoController extends GetxController {


  final isLoading = false.obs;

  final AuthServices authServices = AuthServices();

  final ImagePicker picker = ImagePicker();

  var image = File('').obs;
  var cover = File('').obs;

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  void pickCover() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cover.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }



  Future<void> createPhoto() async {

    if (image.value.path.isEmpty || cover.value.path.isEmpty) {
      AppUtils.showWarning("Please select both images!");
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        'image': image.value.path,
        'cover': cover.value.path,
      };

      final response = await authServices.createPhoto(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Get.offAllNamed(Routes.WELCOME);
        } else {
          String errorMsg = result['errors'] is String
              ? result['errors']
              : (result['messages'] ?? "Upload failed");
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      AppUtils.showError("Something went wrong!");
    } finally {
      isLoading.value = false;
    }
  }





}
