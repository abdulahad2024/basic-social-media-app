import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/video_manager.dart';
import '../../controllers/watch_controller.dart';
import 'package:social_media_app/export.dart';

class ReelVideoItem extends StatefulWidget {
  final dynamic post;
  final int index;

  const ReelVideoItem({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  State<ReelVideoItem> createState() => _ReelVideoItemState();
}

class _ReelVideoItemState extends State<ReelVideoItem>
    with AutomaticKeepAliveClientMixin {

  late VideoPlayerController _videoController;

  final WatchController watchController = Get.find<WatchController>();
  final VideoManager videoManager = Get.find<VideoManager>();

  bool isReady = false;
  bool showIcon = false;
  bool _isMuted = false;

  @override
  bool get wantKeepAlive => true;

  // এই item কি এখন active?
  bool get _isActive => videoManager.activeIndex.value == widget.index;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  /// =========================================================
  /// VIDEO INITIALIZE
  /// =========================================================
  Future<void> _initializeVideo() async {
    try {
      final String videoUrl =
          ApiUrl.imageUrl + (widget.post['video'] ?? "");

      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
      );

      await _videoController.initialize();
      await _videoController.setLooping(true);
      await _videoController.setVolume(1.0);

      if (mounted) {
        setState(() => isReady = true);

        // Initialize হওয়ার পর যদি এটা active হয় তাহলে play করো
        if (_isActive) {
          _videoController.play();
        }
      }
    } catch (e) {
      debugPrint("Video Init Error: $e");
    }
  }

  /// =========================================================
  /// ACTIVE INDEX CHANGE হলে PLAY/PAUSE
  /// =========================================================
  @override
  void didUpdateWidget(covariant ReelVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!isReady) return;

    if (_isActive) {
      if (!_videoController.value.isPlaying) {
        _videoController.seekTo(Duration.zero); // শুরু থেকে শুরু হবে
        _videoController.play();
      }
    } else {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      }
    }
  }

  @override
  void deactivate() {
    if (isReady && _videoController.value.isPlaying) {
      _videoController.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    try {
      _videoController.pause();
      _videoController.dispose();
    } catch (_) {}
    super.dispose();
  }

  /// =========================================================
  /// TAP → PLAY / PAUSE TOGGLE
  /// =========================================================
  void _togglePlayPause() {
    if (!isReady) return;

    setState(() => showIcon = true);

    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => showIcon = false);
    });
  }

  /// =========================================================
  /// MUTE TOGGLE
  /// =========================================================
  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    _videoController.setVolume(_isMuted ? 0.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: [

        // ─── VIDEO ──────────────────────────────────────────
        GestureDetector(
          onTap: _togglePlayPause,
          child: isReady
              ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: VideoPlayer(_videoController),
            ),
          )
              : const ColoredBox(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ),

        // ─── GRADIENT OVERLAY ────────────────────────────────
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.3, 0.7, 1.0],
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),
        ),

        // ─── PLAY/PAUSE ICON OVERLAY ─────────────────────────
        if (showIcon)
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: showIcon ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _videoController.value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 56,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        // ─── PROGRESS BAR (TikTok style — bottom) ────────────
        if (isReady)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VideoProgressIndicator(
              _videoController,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Colors.white,
                bufferedColor: Colors.white30,
                backgroundColor: Colors.white12,
              ),
              padding: EdgeInsets.zero,
            ),
          ),

        // ─── LEFT: USER INFO + CAPTION ────────────────────────
        Positioned(
          left: 16,
          right: 90,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // User row
              GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.USER_PROFILE,
                  arguments: widget.post['user']['id'],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white24,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.post['user']?['profile_image'] != null
                            ? ApiUrl.imageUrl + widget.post['user']['profile_image']
                            : "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        widget.post['user']?['name'] ?? "User",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Caption
              Text(
                widget.post['content'] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  shadows: [
                    Shadow(blurRadius: 4, color: Colors.black54),
                  ],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Song / Audio row (TikTok style)
              Row(
                children: const [
                  Icon(Icons.music_note, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      "Original Audio",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ─── RIGHT: ACTION BUTTONS ────────────────────────────
        Positioned(
          right: 10,
          bottom: 80,
          child: Column(
            children: [

              // LIKE
              Obx(() {
                final updatedPost = watchController.postList[widget.index];
                final isLiked = updatedPost['is_liked'] ?? false;
                final likes = updatedPost['likes_count'] ?? 0;

                return _ActionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  label: _formatCount(likes),
                  color: isLiked ? Colors.red : Colors.white,
                  onTap: () => watchController.toggleLike(
                    updatedPost['id'],
                    widget.index,
                  ),
                );
              }),

              const SizedBox(height: 20),

              // COMMENT
              Obx(() {
                final updatedPost = watchController.postList[widget.index];
                return _ActionButton(
                  icon: Icons.mode_comment_outlined,
                  label: _formatCount(updatedPost['comments_count'] ?? 0),
                  color: Colors.white,
                  onTap: () => _showCommentSheet(
                    context,
                    widget.index,
                    updatedPost['id'],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // SHARE
              _ActionButton(
                icon: Icons.reply,
                label: "Share",
                color: Colors.white,
                onTap: () => watchController
                    .shareVideo(watchController.postList[widget.index]),
              ),

              const SizedBox(height: 20),

              // MUTE / UNMUTE
              _ActionButton(
                icon: _isMuted ? Icons.volume_off : Icons.volume_up,
                label: _isMuted ? "Muted" : "Sound",
                color: Colors.white,
                onTap: _toggleMute,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── FORMAT COUNT (1.2K, 3.4M) ─────────────────────────────
  String _formatCount(int count) {
    if (count >= 1000000) return "${(count / 1000000).toStringAsFixed(1)}M";
    if (count >= 1000) return "${(count / 1000).toStringAsFixed(1)}K";
    return count.toString();
  }

  // ─── COMMENT BOTTOM SHEET ───────────────────────────────────
  void _showCommentSheet(BuildContext context, int index, int postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(ctx).size.height * .75,
          child: Column(
            children: [
              // Handle
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 14),

              // Title
              Obx(() {
                final count = watchController.postList[index]
                ['comments_count'] ?? 0;
                return Text(
                  "$count Comments",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              }),

              const Divider(color: Colors.white12, height: 20),

              // Comments List
              Expanded(
                child: Obx(() {
                  final comments =
                  watchController.postList[index]['comments'];

                  if (comments == null || comments.isEmpty) {
                    return const Center(
                      child: Text(
                        "Be the first to comment! 🎉",
                        style: TextStyle(),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: comments.length,
                    itemBuilder: (_, i) {
                      final comment = comments[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.post['user']?['profile_image'] != null
                                    ? ApiUrl.imageUrl + widget.post['user']['profile_image']
                                    : "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment['user']['name'] ?? "User",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    comment['comment'] ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),

              // Input area
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide()),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: watchController.commentController,
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                            hintText: "Add a comment...",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          watchController.addComment(postId, index),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.primary600,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── REUSABLE ACTION BUTTON WIDGET ───────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              shadows: const [Shadow(blurRadius: 4, color: Colors.black54)],
            ),
          ),
        ],
      ),
    );
  }
}