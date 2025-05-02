import 'package:assam_edu/core/api/logout_api.dart';
import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/core/api/http_util.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/demo_page.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/config/google_sign_in_config.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key, this.userType = 'student'});

  final String userType;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 130.h,
            padding: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(color: HexColor('3572EF')),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      final routeName = userType == 'student'
                          ? AppRoutes.STU_PROFILE_PAGE
                          : AppRoutes.EDU_PROFILE_PAGE;
                      Navigator.pushNamed(context, routeName);
                    },
                    child: const UserProfilePhoto(
                        image: 'assets/images/person.jpeg')),
                const Text("Rupam Jyoti Baishya."),
                const Text("rupamdon2003@gmail.com"),
              ],
            ),
          ),
          _createDrawerItem(
              icon: Icons.book,
              text: 'Your Courses',
              context: context,
              route: userType == 'student'
                  ? AppRoutes.Course_purchased_page
                  : AppRoutes.EDU_PROFILE_PAGE),
          _createDrawerItem(
              icon: Icons.library_books,
              text: 'Library',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.school,
              text: 'Free Courses',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.request_page,
              text: 'Request Demo',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.history,
              text: 'Previous Transactions',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.check_circle,
              text: 'Completed Courses',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.card_giftcard,
              text: 'Certificates',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.download,
              text: 'Downloads',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
              icon: Icons.question_answer,
              text: 'FAQs',
              context: context,
              route: DemoPage.routeName),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Log Out',
            context: context,
            // route: DemoPage.routeName,
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.contact_support,
              text: 'Contact Us',
              color: Colors.blue,
              context: context,
              route: DemoPage.routeName),
        ],
      ),
    );
  }
}

Widget _createDrawerItem({
  required IconData icon,
  required String text,
  Color? color,
  String? route,
  required BuildContext context,
}) {
  return ListTile(
    leading: Icon(icon, color: color ?? Colors.black),
    title: Text(text),
    onTap: () {
      if (route != null) {
        Navigator.pushNamed(context, route);
      } else if (text == "Log Out") {
        _logout(context);
      }
    },
  );
}

void _logout(BuildContext context) async {
  final httpUtil = getIt<HttpUtil>();
  final storageService = getIt<StorageServices>();
  final signInType = storageService.getSignInType();
  if (signInType == 'google_sign_in') {
    await GoogleSigninApi.logOut();
  }
  await LogoutApi.logout(httpUtil: httpUtil);
  // clear storage:
  bool deviceFirstOpen = await storageService
      .deleteSharedPrefValue(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME);
  bool userToken = await storageService
      .deleteSharedPrefValue(AppConstants.STORAGE_USER_TOKEN_KEY);
  bool userType = await storageService
      .deleteSharedPrefValue(AppConstants.STORAGE_USER_PROFILE_KEY);
  if (deviceFirstOpen && userToken && userType && context.mounted) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.GET_STARTED, (route) => false);
  }
}
