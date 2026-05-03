import 'package:get/get.dart';

import '../data/model/story_model.dart';
import '../modules/auth/createPassword/bindings/create_password_binding.dart';
import '../modules/auth/createPassword/views/create_password_view.dart';
import '../modules/auth/createPhoto/bindings/create_photo_binding.dart';
import '../modules/auth/createPhoto/views/create_photo_view.dart';
import '../modules/auth/eduInfo/bindings/edu_info_binding.dart';
import '../modules/auth/eduInfo/views/edu_info_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/otp/bindings/otp_binding.dart';
import '../modules/auth/otp/views/otp_view.dart';
import '../modules/auth/personalInfo/bindings/personal_info_binding.dart';
import '../modules/auth/personalInfo/views/personal_info_view.dart';
import '../modules/auth/phone/bindings/phone_binding.dart';
import '../modules/auth/phone/views/phone_view.dart';
import '../modules/auth/welcome/bindings/welcome_binding.dart';
import '../modules/auth/welcome/views/welcome_view.dart';
import '../modules/forgot_password/forgorPassword/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/forgorPassword/views/forgot_password_view.dart';
import '../modules/forgot_password/resetPassword/bindings/reset_password_binding.dart';
import '../modules/forgot_password/resetPassword/views/reset_password_view.dart';
import '../modules/forgot_password/verifyOtp/bindings/verify_otp_binding.dart';
import '../modules/forgot_password/verifyOtp/views/verify_otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/create_post/bindings/create_post_binding.dart';
import '../modules/main/create_post/views/create_post_view.dart';
import '../modules/main/friends/bindings/friends_binding.dart';
import '../modules/main/friends/views/friends_view.dart';
import '../modules/main/main/bindings/main_binding.dart';
import '../modules/main/main/views/main_view.dart';
import '../modules/main/menus/bindings/menus_binding.dart';
import '../modules/main/menus/views/menus_view.dart';
import '../modules/main/notification/bindings/notification_binding.dart';
import '../modules/main/notification/views/notification_view.dart';
import '../modules/main/watch/bindings/watch_binding.dart';
import '../modules/main/watch/views/watch_view.dart';
import '../modules/messages/message/bindings/message_binding.dart';
import '../modules/messages/message/views/message_view.dart';
import '../modules/profile/editProfile/bindings/edit_profile_binding.dart';
import '../modules/profile/editProfile/views/edit_profile_view.dart';
import '../modules/profile/profiles/bindings/profiles_binding.dart';
import '../modules/profile/profiles/views/profiles_view.dart';
import '../modules/profile/user_profile/bindings/user_profile_binding.dart';
import '../modules/profile/user_profile/views/user_profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/story/create_story/bindings/create_story_binding.dart';
import '../modules/story/create_story/views/create_story_view.dart';
import '../modules/story/view_story/bindings/view_story_binding.dart';
import '../modules/story/view_story/views/view_story_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.PHONE,
      page: () => const PhoneView(),
      binding: PhoneBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.EDU_INFO,
      page: () => const EduInfoView(),
      binding: EduInfoBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => const CreatePasswordView(),
      binding: CreatePasswordBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.CREATE_PHOTO,
      page: () => const CreatePhotoView(),
      binding: CreatePhotoBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FORGOR_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FRIENDS,
      page: () => const FriendsView(),
      binding: FriendsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.WATCH,
      page: () => const WatchView(),
      binding: WatchBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: _Paths.MENUS,
      page: () => const MenusView(),
      binding: MenusBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.rightToLeftWithFade,
      children: [

      ],
    ),
    GetPage(
      name: _Paths.CREATE_POST,
      page: () => const CreatePostView(),
      binding: CreatePostBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.PROFILES,
      page: () => const ProfilesView(),
      binding: ProfilesBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.CREATE_STORY,
      page: () => const CreateStoryView(),
      binding: CreateStoryBinding(),
    ),

    GetPage(
      name: _Paths.VIEW_STORY,
      page: () => ViewStoryView(
        // এখানে arguments থেকে ডাটা রিসিভ করা হচ্ছে
        stories: Get.arguments as List<StoryModel>,
      ),
      binding: ViewStoryBinding(),
    ),

    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
  ];
}
