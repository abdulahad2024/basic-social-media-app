import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final Color highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          children: List.generate(3, (index) => _buildSinglePostShimmer()),
        ),
      ),
    );
  }

  Widget _buildSinglePostShimmer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.white, radius: 20),
            title: Container(
              height: 12,
              width: 100,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            subtitle: Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: double.infinity, color: Colors.white),
                const SizedBox(height: 5),
                Container(height: 10, width: 200, color: Colors.white),
              ],
            ),
          ),

          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(height: 20, width: 60, color: Colors.white),
                const SizedBox(width: 20),
                Container(height: 20, width: 60, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}