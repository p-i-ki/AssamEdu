import 'package:assam_edu/features/student/student_home/presentation/bloc/bloc/student_home_screen_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

Widget slidersView(BuildContext context, StudentHomeScreenState state) {
  return Column(
    children: [
      SizedBox(
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value) {
            print(value);
            context
                .read<StudentHomeScreenBloc>()
                .add(HomePageDotsChange(index: value));
          },
          children: [
            _slidersContainer(path: "assets/images/python_course.jpg"),
            _slidersContainer(path: "assets/images/java_script_course.jpg"),
            _slidersContainer(path: "assets/images/html_course.jpg"),
          ],
        ),
      ),
      SizedBox(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index,
          decorator: DotsDecorator(
              color: HexColor('3572EF'),
              activeColor: HexColor('3572EF'),
              size: const Size.square(5.0),
              activeSize: const Size(20, 5),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ),
      )
    ],
  );
}

Widget _slidersContainer({String path = "assets/icons/art.png"}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.h),
      image: DecorationImage(fit: BoxFit.fill, image: AssetImage(path)),
    ),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: "React Course",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                TextSpan(
                  text: "\nby Joypal Taid",
                  style: TextStyle(
                      fontSize: 7.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: "\n21",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: "/41",
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: " chapters completed",
                  style: TextStyle(
                      fontSize: 7.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ]))
        ],
      ),
    ),
  );
}
