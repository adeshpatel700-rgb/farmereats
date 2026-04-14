import 'dart:io';

import 'package:farmer_eats/features/auth/data/models/register_request_model.dart';
import 'package:farmer_eats/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmer_eats/features/auth/presentation/cubits/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._repository) : super(const SignupState());

  final AuthRepository _repository;

  void updateStep1({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(
      state.copyWith(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      ),
    );
  }

  void updateStep2({
    required String businessName,
    required String informalName,
    required String address,
    required String city,
    required String stateName,
    required String zipCode,
  }) {
    emit(
      state.copyWith(
        businessName: businessName,
        informalName: informalName,
        address: address,
        city: city,
        stateName: stateName,
        zipCode: zipCode,
      ),
    );
  }

  void updateStep3(File? registrationProof) {
    emit(state.copyWith(registrationProof: registrationProof));
  }

  void toggleBusinessHourSlot({required String day, required String slot}) {
    final updated = <String, List<String>>{};
    for (final entry in state.businessHours.entries) {
      updated[entry.key] = List<String>.from(entry.value);
    }

    final daySlots = updated[day] ?? <String>[];
    if (daySlots.contains(slot)) {
      daySlots.remove(slot);
    } else {
      daySlots.add(slot);
    }
    updated[day] = daySlots;

    emit(state.copyWith(businessHours: updated));
  }

  Future<void> submitRegistration() async {
    emit(state.copyWith(status: SignupStatus.loading, errorMessage: null));
    try {
      final token = await _repository.register(
        RegisterRequestModel(
          fullName: state.fullName,
          email: state.email,
          phone: state.phone,
          password: state.password,
          businessName: state.businessName,
          informalName: state.informalName,
          address: state.address,
          city: state.city,
          state: state.stateName,
          zipCode: state.zipCode,
          registrationProof: state.registrationProof,
          businessHours: state.businessHours,
        ),
      );

      emit(state.copyWith(status: SignupStatus.success, token: token));
    } catch (error) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: SignupStatus.initial, errorMessage: null));
  }
}
