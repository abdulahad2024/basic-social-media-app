import 'dart:io';
import 'package:social_media_app/export.dart';

class EditProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController educationController;
  late TextEditingController addressController;

  var isLoading = false.obs;
  Map<String, dynamic> profileData = {};

  final ImagePicker picker = ImagePicker();

  var image = File('').obs;
  var cover = File('').obs;

  String? initialImageUrl;
  String? initialCoverUrl;

  var selectedGender = ''.obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  var selectedDate = ''.obs;

  final AuthServices authServices = AuthServices();
  final ProfilesController profileController = Get.find();

  @override
  void onInit() {
    super.onInit();
    _getArguments();
  }

  void _getArguments() {
    if (Get.arguments != null) {
      profileData = Get.arguments as Map<String, dynamic>;

      initialImageUrl =ApiUrl.imageUrl+ profileData['profile_image'];
      initialCoverUrl = ApiUrl.imageUrl+profileData['cover_image'];

      String? genderFromDb = profileData['gender'];
      if (genderFromDb != null) {
        String formattedGender = genderFromDb.capitalizeFirst!;
        if (genderList.contains(formattedGender)) {
          selectedGender.value = formattedGender;
        }
      }

      selectedDate.value = profileData['dob'] ?? '';

      nameController = TextEditingController(text: profileData['name'] ?? '');
      bioController = TextEditingController(text: profileData['about'] ?? '');
      educationController = TextEditingController(
        text: profileData['education'] ?? '',
      );
      addressController = TextEditingController(
        text: profileData['address'] ?? '',
      );
    } else {
      nameController = TextEditingController();
      bioController = TextEditingController();
      educationController = TextEditingController();
      addressController = TextEditingController();
    }
  }

  Future<void> updateProfile() async {

    if (nameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        bioController.text.trim().isEmpty ||
        educationController.text.trim().isEmpty) {
      AppUtils.showError("All Field is required!");
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> data = {
        'name': nameController.text.trim(),
        'about': bioController.text.trim(),
        'education': educationController.text.trim(),
        'address': addressController.text.trim(),
        'gender': selectedGender.value.toLowerCase(),
        'dob': selectedDate.value,
        'image': image.value.path.isNotEmpty ? image.value : null,
        'cover': cover.value.path.isNotEmpty ? cover.value : null,
      };

      final response = await authServices.editProfile(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['status'] == true) {
          Get.back();
          AppUtils.showSuccess("Profile updated successfully!");
          profileController.getProfile();
        } else {
          AppUtils.showError(
            responseData['messages'] ?? "Something went wrong!",
          );
        }
      } else if (response.statusCode == 422) {
        AppUtils.showError(responseData['errors'] ?? "Validation failed");
      } else {
        AppUtils.showError("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Update Profile Error: $e");
      AppUtils.showError("Something went wrong!");
    } finally {
      isLoading.value = false;
    }
  }

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

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      selectedDate.value = formattedDate;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    educationController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
