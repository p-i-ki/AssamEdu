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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void submitFormData() {
    if (_formKey.currentState!.validate()) {
      print("email - ${emailController.text}");
      print("email - ${passwordController.text}");
      context.read<AuthBloc>().add(
            AuthSignUpEvent(
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
            if (state is AuthSignUpError) {
              print(state.error);
              EasyLoading.dismiss();
              showSnackBar(context, state.error);
            }
            if (state is AuthSignUpSuccess) {
              EasyLoading.dismiss();
              showSnackBar(context, state.signUpData.msg!, color: Colors.green);
              Navigator.pushNamed(context, AppRoutes.SIGN_IN);
            }
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
                    text: "SIGNUP",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.SIGN_IN);
                      //submitFormData();
                    },
                  ),
                  // Login form
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 265.w,
                          height: 256.h,
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
                              SizedBox(height: 18.h),
                              reusableText('PASSWORD'),
                              buildTextField(
                                'password',
                                'password',
                                passwordController,
                              ),
                              SizedBox(height: 10.h),
                              reusableText('OR'),
                              SizedBox(height: 10.h),
                              googleAuth(
                                  onTap: () {}, text: 'SIGNUP WITH GOOGLE'),
                              Container(
                                height: 54.5.h,
                                width: 50.w,
                                margin:
                                    EdgeInsets.only(left: 175.w, top: 13.6.h),
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
