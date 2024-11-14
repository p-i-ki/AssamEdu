part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

//final class AuthSignUpInitial extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final UserSignUpResponseEntity signUpData;
  const AuthSignUpSuccess(this.signUpData);
}

final class AuthSignUpError extends AuthState {
  final String error;
  const AuthSignUpError(this.error);
}

final class AuthSignInLoading extends AuthState {}

final class AuthSignInSuccess extends AuthState {
  final UserSignInResponseEntity signInData;
  const AuthSignInSuccess(this.signInData);
}

final class AuthSignInError extends AuthState {
  final String error;
  const AuthSignInError(this.error);
}

final class AuthSendOtpError extends AuthState {
  final String error;
  const AuthSendOtpError(this.error);
}

final class AuthSendOtpSuccess extends AuthState {
  final UserOtpSendResponseEntity otpData;
  const AuthSendOtpSuccess(this.otpData);
}

// For OTP Verification

// OTP Verification related states
enum OTPStatus { initial, loading, verified, error, emptyEmail, emptyOTP }

class AuthOtpVerificationState extends AuthState {
  final List<String> otpDigits;
  final OTPStatus status;

  const AuthOtpVerificationState(
      {required this.otpDigits, required this.status});

  factory AuthOtpVerificationState.initial() {
    return AuthOtpVerificationState(
        otpDigits: List.filled(6, ''), status: OTPStatus.initial);
  }

  AuthOtpVerificationState copyWith(
      {List<String>? otpDigits, OTPStatus? status}) {
    return AuthOtpVerificationState(
      otpDigits: otpDigits ?? this.otpDigits,
      status: status ?? this.status,
    );
  }
}
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
