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

// class UserOtpSendRequestEntity {
//   final String email;
//   UserOtpSendRequestEntity({required this.email});
// }

// class UserOtpSendResponseEntity {
//   int? code;
//   String? msg;
//   UserEntity? user;

//   UserOtpSendResponseEntity({
//     this.code,
//     this.msg,
//     this.user,
//   });
// }

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

// class LoginRequestEntity {
//   //fields for signUp and logIn request
//   int? loginType;
//   String? name;
//   String? email;
//   String? phone;
//   String? password;
//   int? online;

//   LoginRequestEntity({
//     this.loginType,
//     this.name,
//     this.email,
//     this.phone,
//     this.password,
//     this.online,
//   });

//   Map<String, dynamic> toJson() => {
//         "type": loginType,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "password": password,
//         "online": online,
//       };
// }

// //api post response msg
// class UserLoginResponseEntity {
//   int? code;
//   String? msg;
//   UserItem? data;

//   UserLoginResponseEntity({
//     this.code,
//     this.msg,
//     this.data,
//   });

//   factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
//       // this must be same as backend response..
//       UserLoginResponseEntity(
//         code: json["code"],
//         msg: json["msg"],
//         data: UserItem.fromJson(json["data"]),
//         // data itself is a json so we again need to covert it to dart object
//         // so data itself become an object here..
//       );
// }

// // login result
// class UserItem {
//   String? token;
//   String? name;
//   String? email;
//   String? phone;
//   String? avatar;
//   int? online;
//   int? loginType;
// //  String? userType;
//   String? address;
//   String? academics;
//   String? dob;

//   UserItem({
//     this.token,
//     this.name,
//     this.email,
//     this.phone,
//     this.avatar,
//     this.online,
//     this.loginType,
//     this.address,
//     this.academics,
//     this.dob,
// //    this.userType,
//   });

//   factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
//       token: json["token"],
//       name: json["name"],
//       email: json["email"],
//       phone: json["phone"],
//       avatar: json["avatar"],
//       online: json["online"],
//       loginType: json["type"],
//       address: json["address"],
//       academics: json["academics"],
//       dob: json["dob"]);

//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "avatar": avatar,
//         "online": online,
//         "type": loginType,
//         "address": address,
//         "academics": academics,
//         "dob": dob
//       };
// }
