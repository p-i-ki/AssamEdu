import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/common/widgets/assam_edu_backgroung.dart';
import 'package:assam_edu/core/common/widgets/white_box.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, this.email = "default@gmail.com"});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<String> _otpDigits = List.filled(6, '');
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  var data = {};
  // @override
  // void didChangeDependencies() {
  //   data = ModalRoute.of(context)!.settings.arguments as Map;
  //   print("Data passed is - ${data["email"]}");
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpChange(int index, String value) {
    setState(() {
      _otpDigits[index] = value;
    });

    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _setUserLoggedIn() async {
    final storageServices = getIt<StorageServices>();
    // Here we need to Save the token in the sharedprefs..
    final save = await storageServices.setString(
        AppConstants.STORAGE_USER_TOKEN_KEY, "1111");

    // Check if the widget is still mounted before accessing context
    if (!mounted) return;

    if (save == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.STU_HM_PAGE, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthOtpVerificationState) {
        if (state.status == OTPStatus.emptyEmail) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email can't be empty")));
        }
        if (state.status == OTPStatus.emptyOTP) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP field can't be null")));
        }
        if (state.status == OTPStatus.error) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP verification failed")));
        }
        if (state.status == OTPStatus.verified) {
          EasyLoading.dismiss();
          _setUserLoggedIn();
        }
      } else if (state is AuthSendOtpSuccess) {
        // Handle AuthSendOtpSuccess state here
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("OTP sent successfully")));
      } else if (state is AuthSendOtpError) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("An error occurred")));
      }
    }, builder: (context, state) {
      if (state is AuthOtpVerificationState) {
        if (state.status == OTPStatus.loading) {
          EasyLoading.show(
            indicator: const CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
      }
      return Stack(
        children: [
          assamEduBackgroung(),
          whiteBox(
              text: "OK",
              onTap: () {
                //For testing purpose
                Navigator.pushNamed(context, AppRoutes.STU_HM_PAGE);
                // final otp = _otpDigits.join('');
                // print("OTP Send to --- ${data["email"]}");
                // print("OTP digits are ---- ${otp}");
                // context
                //     .read<AuthBloc>()
                //     .add(AuthVerifyOTP(email: data["email"], otp: otp));
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
                          // TextButton(
                          //   onPressed: () {},
                          //   child: const Text(
                          //     'NOT YOURS?',
                          //     style:
                          //         TextStyle(fontSize: 7, color: Colors.white),
                          //   ),
                          // ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => _buildOTPDigitField(index),
                        ),
                      ),
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
                      SizedBox(height: 3.8.h),
                      Container(
                        margin: EdgeInsets.only(left: 170.w),
                        height: 41.h,
                        width: 49.w,
                        color: HexColor('C6CDEA'),
                        alignment: Alignment.topRight,
                      ),
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

  Widget _buildOTPDigitField(int index) {
    return Container(
      height: 34.h,
      width: 33.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: Colors.white,
      ),
      child: TextFormField(
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 1.h, bottom: 1.h),
          counterText: '',
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: (value) {
          _handleOtpChange(index, value);
          // context
          //     .read<AuthBloc>()
          //     .add(OTPDigitChanged(index: index, value: value));
        },
      ),
    );
  }
}
