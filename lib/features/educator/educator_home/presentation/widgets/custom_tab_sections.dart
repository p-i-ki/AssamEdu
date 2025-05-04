import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/bloc/educator_home_screen_bloc.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/custom_grid_view.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/local_course_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CstmTabSections extends StatelessWidget {
  const CstmTabSections({
    super.key,
    required this.tabController,
    this.courses,
  });

  final TabController tabController;
  final List<Course>? courses;

  @override
  Widget build(BuildContext context) {
    debugPrint("--- Inside Buil method of CustomTabSection ---");
    return SizedBox(
      height: AppConstants.dHeight * 0.5,
      width: AppConstants.dWidth,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppConstants.dRadius)),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 400,
            child: TabBarView(controller: tabController, children: [
              // Launched
              courses != null
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(4),
                      height: AppConstants.dHeight * 0.3,
                      child: CstmGridView(
                        courses: courses!,
                      ))
                  : Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(4),
                      height: AppConstants.dHeight * 0.3,
                      child: Center(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<EducatorHomeScreenBloc>()
                                  .add(GetCoursesEvent());
                            },
                            child: const Text(
                              "Refresh",
                              style: TextStyle(color: Colors.grey),
                            )),
                      )),
              // Draft
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(4),
                  height: AppConstants.dHeight * 0.3,
                  child: const LocalCoursesTab()),
            ]),
          ),
        ),
      ),
    );
  }
}
