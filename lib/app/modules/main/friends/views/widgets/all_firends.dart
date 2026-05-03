import 'package:social_media_app/export.dart';

class CustomFriend extends StatelessWidget {
  final String name, image, status;
  final int id;
  final bool isSent;
  final bool isFriend;
  final bool isReceived;
  final bool isLoading;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? profileTap;

  const CustomFriend({
    super.key,
    required this.name,
    required this.image,
    required this.status,
    required this.id,
    required this.isSent,
    required this.isFriend,
    required this.isReceived,
    required this.isLoading,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.profileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String buttonText() {
      if (isFriend) return "Friends";
      if (isSent) return "Requested";
      if (isReceived) return "Accept";
      return "Add Friend";
    }

    Color buttonColor() {
      if (isFriend) return Colors.green;
      if (isSent) return Colors.grey;
      if (isReceived) return Colors.orange;
      return Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: profileTap,
            child: CircleAvatar(
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
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

                if (status.isNotEmpty)
                  Text(status, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading || isFriend || isSent
                            ? null
                            : onPrimaryTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                            : Text(
                                buttonText(),
                                style: AppTypography.bodySmall(),
                              ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: onSecondaryTap,
                        child: const Text("Remove"),
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
