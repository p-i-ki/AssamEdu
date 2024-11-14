import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/features/auth/data/models/user_model.dart';

class AuthMapper {
  static UserSignUpRequestModel toModel(UserSignUpRequestEntity entity) {
    return UserSignUpRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  static UserSignUpResponseEntity toEntity(UserSignUpResponseModel model) {
    return UserSignUpResponseEntity(
      code: model.code,
      msg: model.msg,
    );
  }

  static UserSignInRequestModel toModelSignIn(UserSignInRequestEntity entity) {
    return UserSignInRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  static UserSignInResponseEntity toEntitySignIn(
      UserSignInResponseModel model) {
    return UserSignInResponseEntity(
      code: model.code,
      msg: model.msg,
      user: model.user,
    );
  }

  static UserOtpSendRequestModel toModelSendOtp(
      UserOtpSendRequestEntity entity) {
    return UserOtpSendRequestModel(
      email: entity.email,
    );
  }

  static UserOtpSendResponseEntity toEntitySendotp(
      UserOtpSendResponseModel model) {
    return UserOtpSendResponseEntity(
      code: model.code,
      msg: model.msg,
      user: model.user,
    );
  }

  static UserVerifyOtpRequestModel toModelVerifyOtp(
    UserVerifyOtpRequestEntity entity,
  ) {
    return UserVerifyOtpRequestModel(
      email: entity.email,
      otp: entity.otp,
    );
  }

  static UserVerifyOtpResponseEntity toEntityVerifyOtp(
      UserVerifyOtpResponseModel model) {
    return UserVerifyOtpResponseEntity(
      code: model.code,
      msg: model.msg,
      user: model.user,
    );
  }
}
