import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/utils/colors.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/customization_panel.dart';

class QuestionSettingsTabBar extends StatefulWidget {
  final List<CustomizationPanel> tabs;

  const QuestionSettingsTabBar({
    super.key,
    required this.tabs,
  });

  @override
  State<QuestionSettingsTabBar> createState() => _QuestionSettingsTabBarState();
}

class _QuestionSettingsTabBarState extends State<QuestionSettingsTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.customizationTabBarInactiveText,
            indicatorColor: AppColors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              for (var tab in widget.tabs) Tab(text: tab.title),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs,
            ),
          ),
        ],
      ),
    );
  }
}
