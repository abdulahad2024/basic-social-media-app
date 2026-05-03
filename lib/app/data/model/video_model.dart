class Video {
  bool? status;
  String? message;
  List<Data>? data;

  Video({this.status, this.message, this.data});

  Video.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? content;
  Null? image;
  String? video;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  int? commentsCount;
  int? sharesCount;
  bool? isLiked;
  bool? canModify;
  User? user;
  List<Comments>? comments;

  Data(
      {this.id,
        this.userId,
        this.content,
        this.image,
        this.video,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.likesCount,
        this.commentsCount,
        this.sharesCount,
        this.isLiked,
        this.canModify,
        this.user,
        this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    image = json['image'];
    video = json['video'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    sharesCount = json['shares_count'];
    isLiked = json['is_liked'];
    canModify = json['can_modify'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['image'] = this.image;
    data['video'] = this.video;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['shares_count'] = this.sharesCount;
    data['is_liked'] = this.isLiked;
    data['can_modify'] = this.canModify;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
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
  String? lastSeen;
  String? createdAt;
  String? updatedAt;
  int? postsCount;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.dob,
        this.gender,
        this.about,
        this.education,
        this.address,
        this.profileImage,
        this.coverImage,
        this.isProfileComplete,
        this.isOnline,
        this.lastSeen,
        this.createdAt,
        this.updatedAt,
        this.postsCount});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
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
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    postsCount = json['posts_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['education'] = this.education;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['cover_image'] = this.coverImage;
    data['is_profile_complete'] = this.isProfileComplete;
    data['is_online'] = this.isOnline;
    data['last_seen'] = this.lastSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['posts_count'] = this.postsCount;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? postId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
        this.userId,
        this.postId,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class VideoUser {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
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
  String? lastSeen;
  String? createdAt;
  String? updatedAt;

  VideoUser(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.dob,
        this.gender,
        this.about,
        this.education,
        this.address,
        this.profileImage,
        this.coverImage,
        this.isProfileComplete,
        this.isOnline,
        this.lastSeen,
        this.createdAt,
        this.updatedAt});

  VideoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
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
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['education'] = this.education;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['cover_image'] = this.coverImage;
    data['is_profile_complete'] = this.isProfileComplete;
    data['is_online'] = this.isOnline;
    data['last_seen'] = this.lastSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
