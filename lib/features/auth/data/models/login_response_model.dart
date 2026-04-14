class LoginResponseModel {
  LoginResponseModel({required this.success, this.message, this.token});

  final String success;
  final String? message;
  final String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: (json['success'] ?? '').toString(),
      message: json['message']?.toString(),
      token: json['token']?.toString(),
    );
  }
}
