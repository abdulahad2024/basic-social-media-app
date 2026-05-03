import 'package:social_media_app/export.dart';

class FriendHorizontalList extends StatelessWidget {
  final int itemCount;
  final Function(int index)? onTap;
  final String Function(int index)? nameBuilder;
  final String Function(int index)? imageBuilder;

  const FriendHorizontalList({
    super.key,
    this.itemCount = 10,
    this.onTap,
    this.nameBuilder,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final String name = nameBuilder?.call(index) ?? 'Friend Name';
          final String image =
              imageBuilder?.call(index) ??
              'https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png';

          return SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onTap?.call(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
