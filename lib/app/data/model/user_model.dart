class User {
  int? id;
  String? name;
  String? phone;
  String? profileImage;
  bool? isOnline;
  String? lastSeen;

  // 🔥 NEW FIELDS (IMPORTANT)
  bool isFriend;
  bool isSent;
  bool isReceived;

  User({
    this.id,
    this.name,
    this.phone,
    this.profileImage,
    this.isOnline,
    this.lastSeen,

    // default false (safe)
    this.isFriend = false,
    this.isSent = false,
    this.isReceived = false,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        profileImage = json['profile_image'],
        isOnline = json['is_online'],
        lastSeen = json['last_seen'],

  // 🔥 handle null safely
        isFriend = json['is_friend'] ?? false,
        isSent = json['is_sent'] ?? false,
        isReceived = json['is_received'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'profile_image': profileImage,
      'is_online': isOnline,
      'last_seen': lastSeen,

      // 🔥 include these
      'is_friend': isFriend,
      'is_sent': isSent,
      'is_received': isReceived,
    };
  }
}