import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/resuable_text.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:assam_edu/features/student/presentation/bloc/home_page_bloc.dart';
import 'package:assam_edu/features/student/presentation/widgets/course_grid.dart';
import 'package:assam_edu/features/student/presentation/widgets/course_slider.dart';
import 'package:assam_edu/features/student/presentation/widgets/user_drawer.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 5, vsync: this);
  late final List<CourseItem> courses;
  bool isCoursesFetched = false;
  bool isCoursesLoading = false;
  bool isRequestMade = false;

  @override
  void initState() {
    super.initState();
    //_fetchAllCourses();
  }

  void _fetchAllCourses() {
    if (context.mounted) {
      final sv = getIt<StorageServices>();
      final String token = sv.getUserToken();
      final courseReq = CourseListRequestEntity(token: token);
      isRequestMade = true;
      context
          .read<HomePageBloc>()
          .add(HomePageGetAllCourses(courseReq: courseReq));
    }
  }
  // final List<String> _tabs = [
  //   "All",
  //   "Popular",
  //   "New",
  //   "Categories",
  //   "BestSellers"
  // ];
  // Map<String, String> _apiUrls = {
  //   // Map tab titles to corresponding API URLs
  //   "Popular": "https://your_api.com/popular_courses",
  //   "New": "https://your_api.com/new_courses",
  //   "Categories": "https://your_api.com/categories",
  //   "BestSellers": "https://your_api.com/bestsellers",
  // };
  // String _currentContent = ""; // Stores content for the selected tab

  @override
  void didChangeDependencies() {
    context.read<HomePageBloc>().add(const HomePageDotsChange(index: 0));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final sv = getIt<StorageServices>();
    final String token = sv.getUserToken();
    if (!isRequestMade) {
      _fetchAllCourses();
    }
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageGetAllCoursesError) {
          isCoursesLoading = false;
          //  showSnackBar(context, state.error);
        }
        if (state is HomePageGetAllCoursesSuccess) {
          isCoursesFetched = true;
          isCoursesLoading = false;
          courses = state.courses;
          print("------Courses Fetched Succesfully!!----------");
          // showSnackBar(context, "Courses Fetched Succesfully!!");
        }
      },
      builder: (context, state) {
        if (state is HomePageGetAllCoursesLoading) {
          isCoursesLoading = true;
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
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade300),
                        maxLines: 1,
                      ),
                      Text(token,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
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
                        child: SearchAnchor(builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                            // backgroundColor:
                            //     const WidgetStatePropertyAll(Colors.grey),
                            controller: controller,
                            hintText: "search",
                            side: const WidgetStatePropertyAll(
                                BorderSide(color: Colors.grey)),
                            elevation: const WidgetStatePropertyAll(0),
                            shape: WidgetStatePropertyAll(
                                BeveledRectangleBorder(
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
                        }, suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
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
              // --check--
              if (state is HomePageInitial)
                SliverToBoxAdapter(child: slidersView(context, state)),
              SliverToBoxAdapter(child: SizedBox(height: 15.h)),

              //Add Tab bar
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: HexColor('D4D4D4'),
                    border: Border.all(
                      width: 0,
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConstants.dRadius - 5)),
                  ),
                  child: TabBar(
                    controller: tabController,

                    padding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: HexColor('050C9C'),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppConstants.dRadius)),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,

                    labelPadding: EdgeInsets.zero,
                    isScrollable:
                        false, // Keep isScrollable set to false for uniform spacing
                    labelStyle: appStyle(
                      size: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: Colors.white,
                    // tabs:
                    //     _tabs.map((tabTitle) => _buildTab(tabTitle)).toList(),
                    tabs: [
                      // Use a fixed width for each tab
                      Tab(
                        child: SizedBox(
                          width: AppConstants.dWidth *
                              0.2, // Adjust width for all tabs
                          child: Center(
                            child: ReusableText(
                              text: "All",
                              style: appStyle(
                                size: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: AppConstants.dWidth *
                              0.2, // Adjust width for all tabs
                          child: Center(
                            child: ReusableText(
                              text: "Popular",
                              style: appStyle(
                                size: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: AppConstants.dWidth *
                              0.2, // Adjust width for all tabs
                          child: Center(
                            child: ReusableText(
                              text: "New",
                              style: appStyle(
                                size: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: AppConstants.dWidth *
                              0.2, // Adjust width for all tabs
                          child: Center(
                            child: ReusableText(
                              text: "Categories",
                              style: appStyle(
                                size: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: AppConstants.dWidth *
                              0.2, // Adjust width for all tabs
                          child: Center(
                            child: ReusableText(
                              text: "BestSellers",
                              style: appStyle(
                                size: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              isCoursesFetched && state is HomePageGetAllCoursesSuccess
                  ? SliverToBoxAdapter(
                      //  padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        height: AppConstants.dHeight * 0.5,
                        width: AppConstants.dWidth,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppConstants.dRadius)),
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(4),
                                height: AppConstants.dHeight * 0.3,
                                child: MyGridView(
                                  courses: courses,
                                ),
                              ),
                              Container(
                                color: Colors.red,
                                padding: const EdgeInsets.all(4),
                                height: AppConstants.dHeight * 0.3,
                                child: MyGridView(courses: courses),
                              ),
                              Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.all(4),
                                height: AppConstants.dHeight * 0.3,
                                child: MyGridView(
                                  courses: courses,
                                ),
                              ),
                              Container(
                                color: Colors.blueGrey,
                                padding: const EdgeInsets.all(4),
                                height: AppConstants.dHeight * 0.3,
                                child: MyGridView(courses: courses),
                              ),
                              Container(
                                color: Colors.green,
                                padding: const EdgeInsets.all(4),
                                height: AppConstants.dHeight * 0.3,
                                child: MyGridView(courses: courses),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : isCoursesLoading
                      ? const SliverToBoxAdapter(
                          child: CircularProgressIndicator(
                          color: Colors.red,
                        ))
                      : SliverToBoxAdapter(
                          child: Center(
                              child: TextButton(
                          child: const Text(
                            "Refresh",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            _fetchAllCourses();
                          },
                        )))
            ],
          ),
        );

        // return Container(
        //   color: Colors.amber,
        // );
      },
    );
  }
}

class MyGridView extends StatelessWidget {
  final List<CourseItem> courses;
  const MyGridView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 6.w, // Spacing between columns
        mainAxisSpacing: 6.w, // Spacing between rows
        childAspectRatio: 1.4, // Aspect ratio of each grid item
      ),
      itemCount: courses.length, // Number of items to display
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to Course Detail Page
            Navigator.pushNamed(context, AppRoutes.Course_Detail_Page,
                arguments: {
                  "courseId": courses[index].courseId,
                  "title": courses[index].title,
                  "price": courses[index].price,
                  "desc": courses[index].description,
                  "": courses[index].thumbnailUrl
                });
          },
          child: courseGrid(
              course: courses[index]), // Replace with your custom widget
        );
      },
    );
  }
}
