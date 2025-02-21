import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/resuable_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseCategoryTabs extends StatelessWidget {
  const CourseCategoryTabs({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: HexColor('D4D4D4'),
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppConstants.dRadius - 5)),
      ),
      child: TabBar(
        controller: tabController,

        padding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: HexColor('050C9C'),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppConstants.dRadius)),
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
              width: AppConstants.dWidth * 0.2, // Adjust width for all tabs
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
              width: AppConstants.dWidth * 0.2, // Adjust width for all tabs
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
              width: AppConstants.dWidth * 0.2, // Adjust width for all tabs
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
              width: AppConstants.dWidth * 0.2, // Adjust width for all tabs
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
              width: AppConstants.dWidth * 0.2, // Adjust width for all tabs
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
    );
  }
}
