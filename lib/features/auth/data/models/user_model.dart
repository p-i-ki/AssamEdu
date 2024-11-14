import 'dart:convert';
import 'package:assam_edu/core/entities/user.dart';

class UserSignUpRequestModel extends UserSignUpRequestEntity {
  String? name;
  UserSignUpRequestModel({
    required super.email,
    required super.password,
    name = "piki",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': "piki",
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserSignUpResponseModel extends UserSignUpResponseEntity {
  UserSignUpResponseModel({
    required super.code,
    required super.msg,
    //required super.user, // assuming user is a part of the model
  });

  factory UserSignUpResponseModel.fromMap(Map<String, dynamic> map) {
    return UserSignUpResponseModel(
      code: map['code'] ?? '',
      msg: map['msg'] ?? '',
      // user: UserModel.fromMap(map['user']), // Assuming you have a UserModel for 'user'
    );
  }

  // Remove fromJson since it's redundant now
  factory UserSignUpResponseModel.fromJson(Map<String, dynamic> map) =>
      UserSignUpResponseModel.fromMap(map);
}

class UserSignInRequestModel extends UserSignInRequestEntity {
  String? name;
  UserSignInRequestModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': "piki",
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserSignInResponseModel extends UserSignInResponseEntity {
  UserSignInResponseModel({
    required super.code,
    required super.msg,
    required super.user, // assuming user is a part of the model
  });

  factory UserSignInResponseModel.fromMap(Map<String, dynamic> map) {
    return UserSignInResponseModel(
      code: map['code'] ?? '',
      msg: map['msg'] ?? '',
      user: map['user'] != null
          ? UserModel.fromMap(map['user'])
          : null, // Assuming you have a UserModel for 'user'
    );
  }

  // Remove fromJson since it's redundant now
  factory UserSignInResponseModel.fromJson(Map<String, dynamic> map) =>
      UserSignInResponseModel.fromMap(map);
}

class UserOtpSendRequestModel extends UserOtpSendRequestEntity {
  UserOtpSendRequestModel({
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserOtpSendResponseModel extends UserOtpSendResponseEntity {
  UserOtpSendResponseModel({
    required super.code,
    required super.msg,
    required super.user, // assuming user is a part of the model
  });

  factory UserOtpSendResponseModel.fromMap(Map<String, dynamic> map) {
    return UserOtpSendResponseModel(
      code: map['code'] as int,
      msg: map['msg'] ?? '',
      user: UserModel.fromMap(
          map['user']), // Assuming you have a UserModel for 'user'
    );
  }

  // Remove fromJson since it's redundant now
  factory UserOtpSendResponseModel.fromJson(Map<String, dynamic> map) =>
      UserOtpSendResponseModel.fromMap(map);
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
    required super.code,
    required super.msg,
    required super.user, // assuming user is a part of the model
  });

  factory UserVerifyOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return UserVerifyOtpResponseModel(
      code: map['code'] as int,
      msg: map['msg'] ?? '',
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
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
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
