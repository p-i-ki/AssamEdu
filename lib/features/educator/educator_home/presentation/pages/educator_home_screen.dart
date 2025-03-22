import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/resuable_text.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/show_snack_bar.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/bloc/educator_home_screen_bloc.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/custom_tab_bar.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/custom_tab_sections.dart';

class EducatorHomeScreen extends StatefulWidget {
  const EducatorHomeScreen({super.key});

  @override
  State<EducatorHomeScreen> createState() => _EducatorHomeScreenState();
}

class _EducatorHomeScreenState extends State<EducatorHomeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    _fetchAllCourses();
  }

  void _fetchAllCourses() {
    if (context.mounted) {
      context.read<EducatorHomeScreenBloc>().add(GetCoursesEvent());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EducatorHomeScreenBloc, EducatorHomeScreenState>(
      listener: (context, state) {
        if (state is EducatorGetCourseError) {
          showSnackBar(context, "can't retrieve courses ! please refresh!!");
        }
        if (state is EducatorGetCourseSuccess) {
          courses = state.res.courses!;
        }
      },
      builder: (context, state) {
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
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade300),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13.w, top: 10, right: 13.h),
                    height: 35.h,
                    child: SearchAnchor(builder:
                        (BuildContext context, SearchController controller) {
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
                        padding: WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
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
                                Navigator.pushNamed(
                                    context, AppRoutes.Create_course);
                              },
                              icon: Icon(
                                Icons.add_circle,
                                size: 55,
                                color: Colors.white.withValues(alpha: 0.8),
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // CustomButton(
                  //     text: "Add Section",
                  //     backgroungColor: Colors.blue,
                  //     textStyle: appStyle(
                  //         size: 12,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //     borderSide: BorderSide.none,
                  //     customFun: () {
                  //       Navigator.pushNamed(context, AppRoutes.ADD_SECTION,
                  //           arguments: {"courseId": 1});
                  //     })
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ReusableText(
                        text: "Dashboard",
                        style: appStyle(
                            size: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CstmTabBar(tabController: _tabController),
                  const SizedBox(
                    height: 10,
                  ),
                  // ADD tab bar section ->
                  courses.isNotEmpty
                      ? CstmTabSections(
                          tabController: _tabController,
                          courses: courses,
                        )
                      : Container(
                          padding: const EdgeInsets.only(top: 200),
                          color: Colors.transparent,
                          child: Center(
                              child: IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              size: 35,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              _fetchAllCourses();
                            },
                          )),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
