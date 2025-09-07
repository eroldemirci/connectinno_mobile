class UserModel {
  final String id;
  final String email;
  final String? accessToken;

  UserModel({required this.id, required this.email, this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as String, email: json['email'] as String, accessToken: json['access_token'] as String?);
  }

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'access_token': accessToken};
}
