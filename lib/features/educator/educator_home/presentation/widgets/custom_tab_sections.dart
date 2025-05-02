import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/custom_grid_view.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/local_course_data.dart';

import 'package:flutter/material.dart';

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
            height: 200,
            child: TabBarView(
                controller: tabController,
                children: courses == null
                    ? [
                        // Launched
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(4),
                            height: AppConstants.dHeight * 0.3,
                            child: const Center(
                              child: Text("Refresh"),
                            )),
                        // Draft
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(4),
                            height: AppConstants.dHeight * 0.3,
                            child: const LocalCoursesTab()),
                      ]
                    : [
                        // Launched
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(4),
                          height: AppConstants.dHeight * 0.3,
                          child: CstmGridView(
                            courses: courses!,
                          ),
                        ),
                        // Draft
                        Container(
                            color: Colors.blue,
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
