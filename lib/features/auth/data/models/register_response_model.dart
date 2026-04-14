class RegisterResponseModel {
  RegisterResponseModel({required this.success, this.message, this.token});

  final String success;
  final String? message;
  final String? token;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: (json['success'] ?? '').toString(),
      message: json['message']?.toString(),
      token: json['token']?.toString(),
    );
  }
}
