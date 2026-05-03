import 'package:flutter/material.dart';

class PendingFriendCard extends StatelessWidget {
  final String name;
  final String image;
  final bool isLoading;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const PendingFriendCard({
    super.key,
    required this.name,
    required this.image,
    required this.isLoading,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: ClipOval(
              child: Image.network(
                image.isNotEmpty
                    ? image
                    : "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png",

                width: 60,
                height: 60,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator(strokeWidth: 2);
                },

                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold)),

                const Text(
                  "Sent you a friend request",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : onAccept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Confirm"),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: isLoading ? null : onReject,
                        child: const Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}