class UserData {
  final String userId;
  final String userName;
  final String userEmail;

  UserData({
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
      );

  Map<String, dynamic> toJson() =>
      {"user_id": userId, "user_name": userName, "user_email": userEmail};
}
