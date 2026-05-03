class UserProfileModel {
  bool? status;
  User? user;
  List<Post>? posts;

  UserProfileModel({this.status, this.user, this.posts});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? about;
  String? education;
  String? address;
  String? profileImage;
  String? coverImage;
  bool? isProfileComplete;
  bool? isOnline;
  int? postsCount;

  User({this.id, this.name, this.email, this.phone, this.dob, this.gender,
    this.about, this.education, this.address, this.profileImage,
    this.coverImage, this.isProfileComplete, this.isOnline, this.postsCount});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    about = json['about'];
    education = json['education'];
    address = json['address'];
    profileImage = json['profile_image'];
    coverImage = json['cover_image'];
    isProfileComplete = json['is_profile_complete'];
    isOnline = json['is_online'];
    postsCount = json['posts_count'];
  }
}

class Post {
  int? id;
  String? content;
  String? image;
  String? video;
  String? type;
  int? likesCount;
  int? commentsCount;
  bool? isLiked;
  bool? canModify;
  List<Comment>? comments;

  Post({this.id, this.content, this.image, this.video, this.type,
    this.likesCount, this.commentsCount, this.isLiked,
    this.canModify, this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
    video = json['video'];
    type = json['type'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    isLiked = json['is_liked'];
    canModify = json['can_modify'];
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }
  }
}

class Comment {
  int? id;
  String? comment;
  User? user; // Commenter profile info

  Comment({this.id, this.comment, this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}