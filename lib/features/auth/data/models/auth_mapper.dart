import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/features/auth/data/models/user_model.dart';

class AuthMapper {
  static UserSignUpRequestModel toModel(UserSignUpRequestEntity entity) {
    return UserSignUpRequestModel(
      email: entity.email,
      password: entity.password,
      role: entity.role,
    );
  }

  static UserSignUpResponseEntity toEntity(UserSignUpResponseModel model) {
    return UserSignUpResponseEntity(
      success: model.success,
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
      success: model.success,
      msg: model.msg,
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
      success: model.success,
      token: model.token,
      user: model.user,
    );
  }
}
