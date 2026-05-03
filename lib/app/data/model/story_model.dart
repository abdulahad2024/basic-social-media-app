class StoryGroup {
  final int userId;
  final List<StoryModel> stories;

  StoryGroup({required this.userId, required this.stories});
}

class StoryModel {
  final int id;
  final int userId;
  final String mediaUrl;
  final String type;
  final String? userName;
  final String? userProfile;

  StoryModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.type,
    this.userName,
    this.userProfile,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['user_id'],
      mediaUrl: json['media_url'],
      type: json['type'],
      userName: json['user']['name'],
      userProfile: json['user']['profile_image'],
    );
  }
}