import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/custom_grid_view.dart';

import 'package:flutter/material.dart';

class CstmTabSections extends StatelessWidget {
  const CstmTabSections({
    super.key,
    required this.tabController,
    required this.courses,
  });

  final TabController tabController;
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.dHeight * 0.5,
      width: AppConstants.dWidth,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppConstants.dRadius)),
        child: TabBarView(
          controller: tabController,
          children: [
            // Launched
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: CstmGridView(
                courses: courses,
              ),
            ),
            // Draft
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: CstmGridView(
                courses: courses,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
