import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/user_profile_photo.dart';
import 'package:assam_edu/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:assam_edu/features/home/presentation/widgets/course_grid.dart';
import 'package:assam_edu/features/home/presentation/widgets/course_select_menu.dart';
import 'package:assam_edu/features/home/presentation/widgets/course_slider.dart';
import 'package:assam_edu/features/home/presentation/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void didChangeDependencies() {
    context.read<HomePageBloc>().add(const HomePageDotsChange(index: 0));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitial) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Container(
                color: Colors.white,
                //padding: const EdgeInsets.only(top: 40),
                //margin: EdgeInsets.only(top: 30.h),
                height: 100.h,
                child: AppBar(
                  automaticallyImplyLeading: false,
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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 13.w),
                          height: 30.h,
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
                                      borderRadius:
                                          BorderRadius.circular(2.w))),
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
                              // trailing: <Widget>[
                              //   Tooltip(
                              //     message: 'Change brightness mode',
                              //     child: IconButton(
                              //       isSelected: isDark,
                              //       onPressed: () {
                              //         setState(() {
                              //           isDark = !isDark;
                              //         });
                              //       },
                              //       icon: const Icon(Icons.wb_sunny_outlined),
                              //       selectedIcon: const Icon(Icons.brightness_2_outlined),
                              //     ),
                              //   )
                              // ],
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
                SliverToBoxAdapter(child: slidersView(context, state)),
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: menuView()),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                SliverPadding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          //how many childs(containers) to show,else it will show infinite childs by default
                          childCount: 6, (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.Course_Detail_Page);
                              // Navigator.of(context).pushNamed(
                              //     AppRoutes.COURSE_DETAIL,
                              //     arguments: <String, int>{
                              //       "id": state.courseItem.elementAt(index).id!
                              //     });
                            },
                            child: courseGrid());
                      }),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //no of childs(containers) to show along cross axis..
                          crossAxisCount: 2,
                          crossAxisSpacing: 6.w,
                          mainAxisSpacing: 6.w,
                          childAspectRatio: 1.4)),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
