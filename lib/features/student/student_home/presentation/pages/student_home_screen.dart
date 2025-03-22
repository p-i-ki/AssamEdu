import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/student_home/presentation/bloc/bloc/student_home_screen_bloc.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/course_category_tabs.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/course_sections.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/course_slider.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/user_drawer.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

// We need separete bloc for other pages ,, so that we can preserve the state of each page..

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 5, vsync: this);
  List<CourseItem> courses = [];
  bool _boughtCourse = true;

  @override
  void initState() {
    super.initState();
    _fetchAllCourses();
  }

  void _fetchAllCourses() {
    if (context.mounted) {
      final sv = getIt<StorageServices>();
      final String token = sv.getUserToken();
      final courseReq = CourseListRequestEntity(token: token);
      // isRequestMade = true;
      context
          .read<StudentHomeScreenBloc>()
          .add(HomePageGetAllCourses(courseReq: courseReq));
    }
  }

  @override
  void didChangeDependencies() {
    context
        .read<StudentHomeScreenBloc>()
        .add(const HomePageDotsChange(index: 0));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!isRequestMade) {
    //   _fetchAllCourses();
    // }
    return BlocConsumer<StudentHomeScreenBloc, StudentHomeScreenState>(
        listener: (context, state) {
      if (state is HomePageGetAllCoursesError) {
        // Put a alert dialogue here instead of snackbar
        EasyLoading.dismiss();
        //  showSnackBar(context, state.error);
      }
      if (state is HomePageGetAllCoursesSuccess) {
        courses = state.courses;
        EasyLoading.dismiss();
      }
    }, builder: (context, state) {
      if (state is HomePageGetAllCoursesLoading) {
        EasyLoading.show(
          indicator: const CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.blueAccent,
          ),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true,
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Container(
            color: Colors.transparent,
            //padding: const EdgeInsets.only(top: 40),
            //margin: EdgeInsets.only(top: 0.h),
            // padding: EdgeInsets.only(bottom: 10),
            height: 110.h,
            child: AppBar(
              automaticallyImplyLeading: false,

              backgroundColor: HexColor('3572EF'),
              elevation: 0, // No shadow for AppBar itself
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade300),
                      maxLines: 1,
                    ),
                    const Text("Piki Saikia",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 13.w),
                      height: 40.h,
                      child: SearchAnchor(builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
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
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7.w, right: 7.w),
                    //  padding: EdgeInsets.only(left: 5.w),
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        color: HexColor('3572EF'),
                        borderRadius: BorderRadius.circular(4.w)),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),
            // --   check  -- for bought courses ------
            _boughtCourse
                ? SliverToBoxAdapter(child: slidersView(context, state))
                : SliverToBoxAdapter(
                    child: SizedBox(
                      width: 325.w,
                      height: 160.h,
                      child: const Center(
                        child: Text(
                          "Your courses will appear here",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),
            //Add Tab bar
            SliverToBoxAdapter(
              child: CourseCategoryTabs(tabController: tabController),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            courses.isNotEmpty
                ? SliverToBoxAdapter(
                    //  padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CourseSections(
                        tabController: tabController, courses: courses),
                  )
                : SliverToBoxAdapter(
                    child: Container(
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
                  )
          ],
        ),
      );
    });
  }
}
