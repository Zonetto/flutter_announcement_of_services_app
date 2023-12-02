class AuthModel {
  final String? userId;
  final String email;
  final String password;

  AuthModel({
    this.userId,
    required this.email,
    required this.password,
  });

  factory AuthModel.formJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json["e-mail"],
      password: json["password"],
    );
  }
  toJson() {
    return {
      "e-mail": email,
      "password": password,
    };
  }
}
