import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_verify_otp.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserVerifyOtp _userVerifyOtp;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserVerifyOtp userVerifyOtp,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userVerifyOtp = userVerifyOtp,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthSignInEvent>(_onSignIn);
    on<AuthVerifyOTP>(_onVerifyOTP);
  }

  void _onSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final storageService = getIt<StorageServices>();
    String userType = storageService.getUserType();
    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      role: userType,
    ));

    res.fold((error) => emit(AuthSignUpError(error.message)), (success) {
      if (success.success == true) {
        return emit(AuthSignUpSuccess(success));
      }
      return emit(AuthSignUpError(success.msg!));
    });
  }

  void _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));

    res.fold((error) => emit(AuthSignInError(error.message)), (success) {
      if (success.success == true) {
        return emit(AuthSignInSuccess(success));
      }
      return emit(AuthSignInError(success.msg!));
    });
  }

  void _onVerifyOTP(AuthVerifyOTP event, Emitter<AuthState> emit) async {
    final res = await _userVerifyOtp(UserVerifyOtpParams(
      email: event.email,
      otp: event.otp,
    ));
    res.fold(
        (error) => emit(AuthOtpVerificationErrorState(error: error.message)),
        (success) {
      if (success.success = true) {
        return emit(AuthOtpVerificationSuccessState(response: success));
      }
      return emit(const AuthOtpVerificationErrorState(error: "Server Error!"));
    });
  }

  // void _onSendOtp(AuthSendOtpEvent event, Emitter<AuthState> emit) async {
  //   final res = await _userSendOtp(UserSendOtpParams(
  //     email: event.email,
  //   ));

  //   res.fold((error) => emit(AuthSendOtpError(error.message)), (success) {
  //     if (success.code == 200) {
  //       return emit(AuthSendOtpSuccess(success));
  //     }
  //     return emit(AuthSignInError(success.msg!));
  //   });
  // }

  // // OTP Digit Changed logic
  // void _onOTPDigitChanged(
  //   AuthOTPDigitChanged event,
  //   Emitter<AuthState> emit,
  // ) {
  //   if (state is AuthOtpVerificationState) {
  //     final otpState = state as AuthOtpVerificationState;
  //     final updatedDigits = List<String>.from(otpState.otpDigits)
  //       ..[event.index] = event.value;
  //     emit(otpState.copyWith(otpDigits: updatedDigits));
  //   }
  // }

  // // OTP Verification logic
  // void _onVerifyOTP(AuthVerifyOTP event, Emitter<AuthState> emit) async {
  //   print("-----   AuthVerifyOTP Event is called   ------");
  //   print("------ State is $state");
  //   emit(const AuthOtpVerificationState(
  //       otpDigits: [], status: OTPStatus.loading));
  //   print("------ State is $state");
  //   if (state is AuthOtpVerificationState) {
  //     final otpState = state as AuthOtpVerificationState;
  //     emit(otpState.copyWith(status: OTPStatus.loading));
  //     // final otp = otpState.otpDigits.join();
  //     print("OTP for verification ---- ${event.otp}");
  //     if (event.otp.isNotEmpty) {
  //       emit(otpState.copyWith(status: OTPStatus.loading));
  //       // Call verify OTP logic here with event.email and otp
  //       // You can add your OTP verification use case here
  //       final result = await _userVerifyOtp(UserVerifyOtpParams(
  //         email: event.email,
  //         otp: event.otp,
  //       ));

  //       result.fold(
  //         (error) => emit(otpState.copyWith(status: OTPStatus.error)),
  //         (success) => emit(otpState.copyWith(status: OTPStatus.verified)),
  //       );
  //     } else {
  //       emit(otpState.copyWith(status: OTPStatus.emptyOTP));
  //     }
  //   }
  // }
}
