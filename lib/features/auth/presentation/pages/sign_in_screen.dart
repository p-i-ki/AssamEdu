import 'package:assam_edu/core/common/widgets/assam_edu_backgroung.dart';
import 'package:assam_edu/core/common/widgets/white_box.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/show_snack_bar.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:assam_edu/features/auth/presentation/widgets/google_auth.dart';
import 'package:assam_edu/features/auth/presentation/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void submitFormData() {
    if (_formKey.currentState!.validate()) {
      print(
          "email - ${emailController.text} , password - ${passwordController.text}");
      context.read<AuthBloc>().add(
            AuthSignInEvent(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignInError) {
              //  print(state.error);
              EasyLoading.dismiss();
              showSnackBar(context, state.error);
            }
            if (state is AuthSignInSuccess) {
              EasyLoading.dismiss();
              showSnackBar(context, state.signInData.msg!);
              Navigator.pushNamed(context, AppRoutes.OTP,
                  arguments: {"email": emailController.text.trim()});
              // otp will be sent from the backend directly as soon as email and passwords are varified..
              // context
              //     .read<AuthBloc>()
              //     .add(AuthSendOtpEvent(email: state.signInData.user!.email!));
            }
            // if (state is AuthSendOtpSuccess) {
            //   EasyLoading.dismiss();
            //   Navigator.pushNamed(context, AppRoutes.OTP,
            //       arguments: {'email': state.otpData.user!.email});
            // }
            // if (state is AuthSendOtpError) {
            //   EasyLoading.dismiss();
            //   showSnackBar(context, state.error);
            // }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              EasyLoading.show(
                indicator: const CircularProgressIndicator(),
                maskType: EasyLoadingMaskType.clear,
                dismissOnTap: true,
              );
            }
            return Form(
              key: _formKey,
              child: Stack(
                children: [
                  assamEduBackgroung(),
                  whiteBox(
                    text: "LOGIN",
                    onTap: () {
                      submitFormData();
                      //for testing purpose
                      // Navigator.pushNamed(context, AppRoutes.OTP);
                    },
                  ),
                  // Login form
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 265.w,
                          height: 260.h,
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(85, 92, 170, 1.0),
                            borderRadius: BorderRadius.circular(10.0.w),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText('EMAIL ID OR PHONE NUMBER'),
                              buildTextField(
                                'email',
                                'email',
                                emailController,
                              ),
                              SizedBox(height: 16.h),
                              reusableText('PASSWORD'),
                              buildTextField(
                                'password',
                                'password',
                                passwordController,
                              ),
                              SizedBox(height: 3.h),
                              GestureDetector(
                                  onTap: () {},
                                  child: reusableText('FORGOT PASSWORD',
                                      fontSize: 10.sp)),
                              SizedBox(height: 6.h),
                              Center(child: reusableText('OR')),
                              SizedBox(height: 6.h),
                              Center(
                                  child: googleAuth(
                                      onTap: () {}, text: 'LOGIN WITH GOOGLE')),
                              Container(
                                height: 45.h,
                                width: 40.w,
                                margin: EdgeInsets.only(left: 180.w, top: 6.h),
                                decoration:
                                    BoxDecoration(color: HexColor('8EB4C1')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
