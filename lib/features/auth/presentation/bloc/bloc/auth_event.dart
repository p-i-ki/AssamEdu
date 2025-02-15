part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  // final String name;
  const AuthSignUpEvent({
    required this.email,
    required this.password,
    //  required this.name,
  });
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({
    required this.email,
    required this.password,
  });
}

class AuthVerifyOTP extends AuthEvent {
  final String email;
  final String otp;

  const AuthVerifyOTP({required this.email, required this.otp});
}
