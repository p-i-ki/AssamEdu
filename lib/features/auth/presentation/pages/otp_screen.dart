import 'package:assam_edu/core/common/widgets/assam_edu_backgroung.dart';
import 'package:assam_edu/core/common/widgets/white_box.dart';
import 'package:assam_edu/core/utlis/save_token.dart';
import 'package:assam_edu/core/utlis/show_snack_bar.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/routes/names.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, this.email = "default@gmail.com"});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = "";
  var data = {};

  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    super.didChangeDependencies();
  }

  void _setUserLoggedIn(String token) async {
    final res = await StoreTokenAndNavigate.setUserLoggedIn(token: token);
    if (res == true && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.HOME_PAGE, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthOtpVerificationErrorState) {
        EasyLoading.dismiss();
        showSnackBar(context, state.error);
      }
      if (state is AuthOtpVerificationSuccessState) {
        EasyLoading.dismiss();
        _setUserLoggedIn(state.response.token!);
      }
    }, builder: (context, state) {
      if (state is AuthLoading) {
        EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true,
        );
      }

      return Stack(
        children: [
          assamEduBackgroung(),
          whiteBox(
              text: "OK",
              type: "otp",
              onTap: () {
                if (_otp.isEmpty) {
                  showSnackBar(context, "Otp can't be empty!");
                }
                context
                    .read<AuthBloc>()
                    .add(AuthVerifyOTP(email: data["email"], otp: _otp));
              }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 13.h, 16.w, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(85, 92, 170, 1.0),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  width: 252.w,
                  height: 200.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'OTP SENT TO  ',
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                TextSpan(
                                  text: data["email"],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.only(left: 12.5.w),
                        child: Text(
                          "ENTER OTP",
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      _pinPutField(),
                      SizedBox(height: 18.h),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'RESEND OTP',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      //  SizedBox(height: 1.h),
                      // Container(
                      //   margin: EdgeInsets.only(left: 170.w),
                      //   height: 5.5.h,
                      //   width: 49.w,
                      //   color: HexColor('C6CDEA'),
                      //   alignment: Alignment.topRight,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }));
  }

  Widget _pinPutField() {
    return Pinput(
      length: 6,
      onCompleted: (value) {
        if (value.isNotEmpty) {
          _otp = value;
        }
      },
    );
  }
}
