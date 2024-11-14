import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/home/presentation/widgets/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //  padding: EdgeInsets.only(top: 40),
        padding: EdgeInsets.zero,
        children: [
          Container(
            //margin: EdgeInsets.only(top: 40),
            height: 100.h,
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(color: HexColor('3572EF')),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfilePhoto(image: 'assets/images/person.jpeg'),
                Text("Rupam Jyoti Baishya."),
                Text("rupamdon2003@gmail.com"),
              ],
            ),
          ),
          // UserAccountsDrawerHeader(
          //   // margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
          //   accountName: const Text("Rupam Jyoti Baishya."),
          //   accountEmail: const Text("rupamdon2003@gmail.com"),
          //   currentAccountPicture: InkWell(
          //       onTap: () {
          //         Navigator.pushNamed(context, DemoPage.routeName);
          //       },
          //       child:
          //           const UserProfilePhoto(image: 'assets/images/person.jpeg')),
          //   decoration: BoxDecoration(
          //     color: HexColor('3572EF'),
          //   ),
          // ),
          _createDrawerItem(
              icon: Icons.book,
              text: 'Your Courses',
              context: context,
              route: AppRoutes.Course_purchased_page),
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
              route: DemoPage.routeName),
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

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    Color? color,
    required String route,
    required BuildContext context}) {
  return ListTile(
    leading: Icon(icon, color: color ?? Colors.black),
    title: Text(text),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}
