import 'dart:convert';
import 'package:assam_edu/core/entities/user.dart';

class UserSignUpRequestModel extends UserSignUpRequestEntity {
  String? name;
  UserSignUpRequestModel({
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserSignUpResponseModel extends UserSignUpResponseEntity {
  UserSignUpResponseModel({
    required super.success,
    required super.msg,
  });

  factory UserSignUpResponseModel.fromMap(Map<String, dynamic> map) {
    return UserSignUpResponseModel(
      success: map['success'] ?? false,
      msg: map['message'] ?? '',
    );
  }

  // Remove fromJson since it's redundant now
  factory UserSignUpResponseModel.fromJson(Map<String, dynamic> map) =>
      UserSignUpResponseModel.fromMap(map);
}

class UserSignInRequestModel extends UserSignInRequestEntity {
  UserSignInRequestModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserSignInResponseModel extends UserSignInResponseEntity {
  UserSignInResponseModel({
    required super.success,
    required super.msg,
  });

  factory UserSignInResponseModel.fromMap(Map<String, dynamic> map) {
    return UserSignInResponseModel(
      success: map['success'] ?? false,
      msg: map['message'] ?? '',
    );
  }

  // Remove fromJson since it's redundant now
  factory UserSignInResponseModel.fromJson(Map<String, dynamic> map) =>
      UserSignInResponseModel.fromMap(map);
}

class UserVerifyOtpRequestModel extends UserVerifyOtpRequestEntity {
  UserVerifyOtpRequestModel({
    required super.email,
    required super.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserVerifyOtpResponseModel extends UserVerifyOtpResponseEntity {
  UserVerifyOtpResponseModel({
    required super.success,
    required super.token,
    required super.user, // assuming user is a part of the model
  });

  factory UserVerifyOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return UserVerifyOtpResponseModel(
      success: map['success'] as bool,
      token: map['token'] ?? '',
      user: UserModel.fromMap(
          map['user']), // Assuming you have a UserModel for 'user'
    );
  }

  // Remove fromJson since it's redundant now
  factory UserVerifyOtpResponseModel.fromJson(Map<String, dynamic> map) =>
      UserVerifyOtpResponseModel.fromMap(map);
}

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.email,
    required super.password,
    required super.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

// class UserSignUpResponseModel extends UserSignUpResponseEntity {
//   final String id;
//   final String name;
//   final String email;

//   UserSignUpResponseModel({
//     required super.code,
//     required super.msg,
//     required this.id,
//     required this.name,
//     required this.email,
//   });

//   factory UserSignUpResponseModel.fromMap(Map<String, dynamic> map) {
//     return UserSignUpResponseModel(
//       code: map['code'] ?? '',
//       msg: map['msg'] ?? '',
//       id: map['user']?['id'] ?? '',
//       name: map['user']?['name'] ?? '',
//       email: map['user']?['email'] ?? '',
//     );
//   }

//   factory UserSignUpResponseModel.fromJson(String source) =>
//       UserSignUpResponseModel.fromMap(json.decode(source));
// }
