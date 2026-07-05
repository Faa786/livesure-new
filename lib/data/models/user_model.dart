class UserModel {
  final String id;
  final String email;
  final String phone;
  final String fullName;
  final String role;
  final String status;
  final String? profileImageUrl;
  final String? fcmToken;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.fullName,
    required this.role,
    required this.status,
    this.profileImageUrl,
    this.fcmToken,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? 'customer',
      status: json['status'] ?? 'active',
      profileImageUrl: json['profile_image_url'],
      fcmToken: json['fcm_token'],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'full_name': fullName,
      'role': role,
      'status': status,
      'profile_image_url': profileImageUrl,
      'fcm_token': fcmToken,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
