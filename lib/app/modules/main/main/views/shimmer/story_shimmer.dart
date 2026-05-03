import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});



  @override
  Widget build(BuildContext context) {

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;


    return SizedBox(
      height: 180.0,
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              width: 110,
              margin: const EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ),
    );
  }
}