import 'package:social_media_app/export.dart';

class PersonalInfoController extends GetxController {
  final isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final AuthServices authServices = AuthServices();

  var selectedGender = ''.obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  var selectedDate = ''.obs;

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
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

  Future<void> personalInfo() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String gender = selectedGender.value;
    final String dob = selectedDate.value;

    if (name.isEmpty || email.isEmpty) {
      AppUtils.showWarning("Please enter your name and email!");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      AppUtils.showError("Please enter a valid email address!");
      return;
    }

    if (gender.isEmpty) {
      AppUtils.showWarning("Please select your gender!");
      return;
    }

    if (dob.isEmpty) {
      AppUtils.showWarning("Please select your date of birth!");
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        'name': name,
        'email': email,
        'gender': gender.toLowerCase(),
        'dob': dob,
      };

      final response = await authServices.personalInfo(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.EDU_INFO);
      } else if (response.statusCode == 422) {
        String errorMsg = result['errors'] ?? "Something went wrong!";
        AppUtils.showError(errorMsg);
      }
    } catch (e) {
      debugPrint("Personal Info Error: $e");
      AppUtils.showError("Could not connect to the server. Try again!");
    } finally {
      isLoading.value = false;
    }
  }
}
