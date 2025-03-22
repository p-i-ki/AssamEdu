import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CstmTabBar extends StatelessWidget {
  const CstmTabBar({
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
        dividerColor: Colors.white,
        padding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: HexColor('050C9C'),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppConstants.dRadius)),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.zero,
        isScrollable:
            false, // Keep isScrollable set to false for uniform spacing
        labelStyle: appStyle(
          size: 14,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(
            text: "Launched",
          ),
          Tab(
            text: "Draft",
          ),
        ],
      ),
    );
  }
}
