class UserModel {
  String? userId;
  final int call;
  final String dateOfBirth;
  final String email;
  final String password;
  final String fullName;
  String? image;
  final bool isServiceProvider;

  UserModel({
    this.userId,
    required this.call,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    required this.fullName,
    this.image,
    required this.isServiceProvider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      call: json["call"],
      dateOfBirth: json["date_of_birth"],
      email: json["e-mail"],
      password: json["password"],
      fullName: json["full_name"],
      image: json["image"],
      isServiceProvider: json["is_service_provider"],
    );
  }
  toJson() {
    return {
      "userId": userId,
      "call": call,
      "date_of_birth": dateOfBirth,
      "e-mail": email,
      "password": password,
      "full_name": fullName,
      "image": image,
      "is_service_provider": isServiceProvider,
    };
  }
}
