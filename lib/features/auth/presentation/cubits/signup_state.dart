import 'dart:io';

import 'package:equatable/equatable.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  const SignupState({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.businessName = '',
    this.informalName = '',
    this.address = '',
    this.city = '',
    this.stateName = '',
    this.zipCode = '',
    this.registrationProof,
    this.businessHours = const {
      'mon': <String>[],
      'tue': <String>[],
      'wed': <String>[],
      'thu': <String>[],
      'fri': <String>[],
      'sat': <String>[],
      'sun': <String>[],
    },
    this.status = SignupStatus.initial,
    this.errorMessage,
    this.token,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;

  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String stateName;
  final String zipCode;

  final File? registrationProof;
  final Map<String, List<String>> businessHours;

  final SignupStatus status;
  final String? errorMessage;
  final String? token;

  SignupState copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? businessName,
    String? informalName,
    String? address,
    String? city,
    String? stateName,
    String? zipCode,
    File? registrationProof,
    bool clearRegistrationProof = false,
    Map<String, List<String>>? businessHours,
    SignupStatus? status,
    String? errorMessage,
    String? token,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      businessName: businessName ?? this.businessName,
      informalName: informalName ?? this.informalName,
      address: address ?? this.address,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      zipCode: zipCode ?? this.zipCode,
      registrationProof: clearRegistrationProof
          ? null
          : (registrationProof ?? this.registrationProof),
      businessHours: businessHours ?? this.businessHours,
      status: status ?? this.status,
      errorMessage: errorMessage,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    phone,
    password,
    businessName,
    informalName,
    address,
    city,
    stateName,
    zipCode,
    registrationProof,
    businessHours,
    status,
    errorMessage,
    token,
  ];
}
