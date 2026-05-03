import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:social_media_app/app/modules/main/main/views/shimmer/post_input_shimmer.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../../../../utils/theme/app_typography.dart';
import '../../../../profile/profiles/controllers/profiles_controller.dart';

class PostInputArea extends StatelessWidget {
  const PostInputArea({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfilesController());


   return Obx(() {

     if(controller.isLoading.value){
       return PostInputShimmer();
     }

     String? profilePath = controller.profile['profile_image'];
     final String userImg = (profilePath != null && profilePath.isNotEmpty)
         ? ApiUrl.imageUrl + profilePath
         : "";


     return Container(
       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
       margin: const EdgeInsets.symmetric(vertical: 8.0),
       child: Row(
         children: [

           InkWell(
             onTap: () {
               Get.toNamed(Routes.PROFILES);
             },
             child:CircleAvatar(
               radius: 20,
               backgroundColor: Colors.grey[300], // ইমেজ লোড না হওয়া পর্যন্ত ব্যাকগ্রাউন্ড
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(20), // রেডিয়াসের সমান করে কাটতে হবে
                 child: Image.network(
                   userImg,
                   width: 40, // radius * 2
                   height: 40,
                   fit: BoxFit.cover,

                   // ছবি লোড হওয়ার সময় যা দেখাবে
                   loadingBuilder: (context, child, loadingProgress) {
                     if (loadingProgress == null) return child;
                     return const Center(
                       child: SizedBox(
                         width: 15,
                         height: 15,
                         child: CircularProgressIndicator(
                           strokeWidth: 2,
                           color: Colors.white,
                         ),
                       ),
                     );
                   },

                   // যদি কোনো কারণে ছবি না পাওয়া যায় বা নেটওয়ার্ক এরর হয়
                   errorBuilder: (context, error, stackTrace) {
                     return Container(
                       color: Colors.grey[400],
                       child: Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png"),
                     );
                   },
                 ),
               ),
             )
           ),


           const SizedBox(width: 8.0),
           Expanded(
             child: InkWell(
               onTap: () => Get.toNamed(Routes.CREATE_POST),
               borderRadius: BorderRadius.circular(30.0),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                 decoration: BoxDecoration(
                   border: Border.all(color: AppColors.borderGrey.withOpacity(0.5)),
                   borderRadius: BorderRadius.circular(30.0),
                 ),
                 child: Text(
                   'What\'s on your mind?',
                   style: AppTypography.bodyMedium(color: AppColors.darkGrey),
                 ),
               ),
             ),
           ),          const SizedBox(width: 8.0),
           Column(
             children: [
               InkWell(
                 onTap: () => Get.toNamed(Routes.CREATE_POST),
                   child: Icon(Icons.photo_library, color: AppColors.primary600,size: 25,)),
               const SizedBox(height: 2.0),
               Text('Photo', style: AppTypography.bodySmall()),
             ],
           ),

         ],
       ),
     );

    });

  }
}
