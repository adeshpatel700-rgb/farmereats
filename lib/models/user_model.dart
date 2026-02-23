class LoginRequest {
  final String email;
  final String password;
  final String role;
  final String deviceToken;
  final String type;
  final String? socialId;

  LoginRequest({
    required this.email,
    required this.password,
    this.role = 'farmer',
    this.deviceToken = '',
    this.type = 'email',
    this.socialId,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'device_token': deviceToken,
      'type': type,
      if (socialId != null) 'social_id': socialId,
    };
  }
}

class RegisterRequest {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String? registrationProof;
  final Map<String, dynamic>? businessHours;
  final String deviceToken;
  final String type;
  final String? socialId;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.role = 'farmer',
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.registrationProof,
    this.businessHours,
    this.deviceToken = '',
    this.type = 'email',
    this.socialId,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'business_name': businessName,
      'informal_name': informalName,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      if (registrationProof != null) 'registration_proof': registrationProof,
      if (businessHours != null) 'business_hours': businessHours,
      'device_token': deviceToken,
      'type': type,
      if (socialId != null) 'social_id': socialId,
    };
  }
}

class ForgotPasswordRequest {
  final String mobile;

  ForgotPasswordRequest({required this.mobile});

  Map<String, dynamic> toJson() {
    return {'mobile': mobile};
  }
}

class VerifyOtpRequest {
  final String otp;

  VerifyOtpRequest({required this.otp});

  Map<String, dynamic> toJson() {
    return {'otp': otp};
  }
}

class ResetPasswordRequest {
  final String token;
  final String password;
  final String cpassword;

  ResetPasswordRequest({
    required this.token,
    required this.password,
    required this.cpassword,
  });

  Map<String, dynamic> toJson() {
    return {'token': token, 'password': password, 'cpassword': cpassword};
  }
}
