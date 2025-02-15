part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

// For Sign-Up
final class AuthSignUpSuccess extends AuthState {
  final UserSignUpResponseEntity signUpData;
  const AuthSignUpSuccess(this.signUpData);
}

final class AuthSignUpError extends AuthState {
  final String error;
  const AuthSignUpError(this.error);
}

// For Sign-In
final class AuthSignInSuccess extends AuthState {
  final UserSignInResponseEntity signInData;
  const AuthSignInSuccess(this.signInData);
}

final class AuthSignInError extends AuthState {
  final String error;
  const AuthSignInError(this.error);
}

// For OTP Verification
class AuthOtpVerificationSuccessState extends AuthState {
  final UserVerifyOtpResponseEntity response;
  const AuthOtpVerificationSuccessState({required this.response});
}

class AuthOtpVerificationErrorState extends AuthState {
  final String error;
  const AuthOtpVerificationErrorState({required this.error});
}

// OTP Verification related states
// enum OTPStatus { initial, loading, verified, error, emptyEmail, emptyOTP }

// class AuthOtpVerificationState extends AuthState {
//   final List<String> otpDigits;
//   final OTPStatus status;

//   const AuthOtpVerificationState(
//       {required this.otpDigits, required this.status});

//   factory AuthOtpVerificationState.initial() {
//     return AuthOtpVerificationState(
//         otpDigits: List.filled(6, ''), status: OTPStatus.initial);
//   }

//   AuthOtpVerificationState copyWith(
//       {List<String>? otpDigits, OTPStatus? status}) {
//     return AuthOtpVerificationState(
//       otpDigits: otpDigits ?? this.otpDigits,
//       status: status ?? this.status,
//     );
//   }
// }
