import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_common_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_content_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/question_settings_tab_bar.dart';
import 'package:survey_core/survey_core.dart';

class InputCustomizationPanel extends StatelessWidget {
  final OnChangeCallback onChange;
  final InputQuestionData editable;

  const InputCustomizationPanel({
    required this.onChange,
    required this.editable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuestionSettingsTabBar(
      tabs: [
        InputCommonCustomizationTab(
          onChange: onChange,
          title: context.localization.common,
          editable: editable,
        ),
        InputCustomizationTab(
          onChange: onChange,
          title: context.localization.input,
          editable: editable,
        ),
        InputContentCustomizationTab(
          onChange: onChange,
          title: context.localization.content,
          editable: editable,
        ),
      ],
    );
  }
}
