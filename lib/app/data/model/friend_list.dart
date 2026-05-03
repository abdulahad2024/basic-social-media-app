class FriendList {
  bool? status;
  String? message;
  List<Data>? data;

  FriendList({this.status, this.message, this.data});

  FriendList.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
