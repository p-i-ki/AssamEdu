// It acts as interface or parent class or base model for UserModel class.. And we will require it througout our app to access user data..
class UserSignUpRequestEntity {
  final String email;
  final String password;
  final String role;

  UserSignUpRequestEntity({
    required this.email,
    required this.password,
    required this.role,
  });
}

class UserSignUpResponseEntity {
  // int? code;
  bool? success;
  String? msg;

  UserSignUpResponseEntity({
    this.msg,
    this.success,
  });
}

class UserSignInRequestEntity {
  final String email;
  final String password;

  UserSignInRequestEntity({
    required this.email,
    required this.password,
  });
}

class UserSignInResponseEntity {
  // int? code;
  bool? success;
  String? msg;
  // UserEntity? user;

  UserSignInResponseEntity({
    this.success,
    this.msg,
  });
}

class UserVerifyOtpRequestEntity {
  final String email;
  final String otp;
  UserVerifyOtpRequestEntity({
    required this.email,
    required this.otp,
  });
}

class UserVerifyOtpResponseEntity {
  bool? success;
  UserEntity? user;
  String? token;

  UserVerifyOtpResponseEntity({
    required this.success,
    required this.token,
    required this.user,
  });
}

class UserEntity {
  String? userId;
  String? username;
  String? email;
  String? password;
  String? role;
  dynamic otp;
  dynamic otpExpiration;
  dynamic resetPasswordToken;
  dynamic resetPasswordExpires;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserEntity({
    this.userId,
    this.username,
    this.email,
    this.password,
    this.role,
    this.otp,
    this.otpExpiration,
    this.resetPasswordToken,
    this.resetPasswordExpires,
    this.createdAt,
    this.updatedAt,
  });
}

class NoParams {}
