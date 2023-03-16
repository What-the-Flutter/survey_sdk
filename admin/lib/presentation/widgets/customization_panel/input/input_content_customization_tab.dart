import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/localizations.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_items_container.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_multiline_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/customization_tab.dart';

class InputContentCustomizationTab extends CustomizationTab {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onSubtitleChanged;
  final ValueChanged<String> onHintTextChanged;
  final ValueChanged<String> onButtonTextChanged;

  const InputContentCustomizationTab({
    required super.title,
    required this.onTitleChanged,
    required this.onSubtitleChanged,
    required this.onHintTextChanged,
    required this.onButtonTextChanged,
    super.key,
  });

  static const double _maxInputTextHeight = 100;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomizationItemsContainer(
          title: context.localization.title,
          isTopDividerShown: true,
          children: [
            CustomizationMultilineTextField(
              maxHeight: _maxInputTextHeight,
              onChanged: onTitleChanged,
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.subtitle,
          children: [
            CustomizationMultilineTextField(
              maxHeight: _maxInputTextHeight,
              onChanged: onSubtitleChanged,
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.hint,
          children: [
            CustomizationMultilineTextField(
              maxHeight: _maxInputTextHeight,
              onChanged: onHintTextChanged,
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.button,
          children: [
            CustomizationMultilineTextField(
              maxHeight: _maxInputTextHeight,
              onChanged: onButtonTextChanged,
            ),
          ],
        ),
      ],
    );
  }
}
