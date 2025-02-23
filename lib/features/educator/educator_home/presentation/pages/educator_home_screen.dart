import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class EducatorHomeScreen extends StatefulWidget {
  const EducatorHomeScreen({super.key});

  @override
  State<EducatorHomeScreen> createState() => _EducatorHomeScreenState();
}

class _EducatorHomeScreenState extends State<EducatorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Container(
          color: Colors.transparent,
          //padding: const EdgeInsets.only(top: 40),
          // margin: EdgeInsets.only(top: 25.h),
          height: 110.h,
          child: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.transparent,
            backgroundColor: HexColor('3572EF'),
            elevation: 0, // No shadow for AppBar itself
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
                    maxLines: 1,
                  ),
                  const Text('Rupam Jyoti Baishya.',
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            leadingWidth: double.infinity,
            actions: [
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    // decoration: const BoxDecoration(color: Colors.amber),
                    child: const UserProfilePhoto(
                        image: 'assets/images/person.jpeg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      endDrawer: const UserDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 13.w, top: 10, right: 13.h),
              height: 30.h,
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  //  overlayColor: WidgetStatePropertyAll(Colors.red),
                  // backgroundColor:
                  //     const WidgetStatePropertyAll(Colors.grey),
                  controller: controller,
                  hintText: "search",
                  side: const WidgetStatePropertyAll(
                      BorderSide(color: Colors.grey)),
                  elevation: const WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2.w))),
                  padding:
                      WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(
                    horizontal: 2.w,
                  )),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: const Icon(Icons.search),
                  ),
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'course $index';
                  return ListTile(
                    hoverColor: Colors.red,
                    splashColor: Colors.grey,
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              }),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/image 31.png'),
                    fit: BoxFit.contain),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: RichText(
                        text: const TextSpan(
                            text: 'Add a',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            children: [
                          TextSpan(
                              text: '\nNew Course',
                              style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Align(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.Create_course);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          size: 55,
                          color: Colors.white.withValues(alpha: 0.8),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
