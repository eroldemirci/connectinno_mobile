class AuthModel {
  final String email;
  final String password;
  final String? confirmPassword;

  AuthModel({required this.email, required this.password, this.confirmPassword});

  AuthModel copyWith({String? email, String? password, String? confirmPassword}) {
    return AuthModel(email: email ?? this.email, password: password ?? this.password, confirmPassword: confirmPassword ?? this.confirmPassword);
  }
}
