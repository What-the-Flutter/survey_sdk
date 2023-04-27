import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/utils/constants/app_dimensions.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_items_container.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_multiline_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/customization_tab.dart';
import 'package:survey_client/survey_client.dart';

class InputContentCustomizationTab extends CustomizationTab {
  final void Function(QuestionData data) onChange;
  final InputQuestionData editable;

  const InputContentCustomizationTab({
    required this.onChange,
    required super.title,
    required this.editable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomizationItemsContainer(
          title: context.localization.title,
          shouldShowTopDivider: true,
          children: [
            CustomizationMultilineTextField(
              value: editable.title,
              maxHeight: AppDimensions.maxTextFieldHeight,
              onChanged: (title) => onChange(
                editable.copyWith(title: title),
              ),
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.subtitle,
          children: [
            CustomizationMultilineTextField(
              value: editable.subtitle,
              maxHeight: AppDimensions.maxTextFieldHeight,
              onChanged: (subtitle) => onChange(
                editable.copyWith(subtitle: subtitle),
              ),
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.hint,
          children: [
            CustomizationMultilineTextField(
              value: editable.hintText ?? '',
              maxHeight: AppDimensions.maxTextFieldHeight,
              onChanged: (hint) => onChange(
                editable.copyWith(hintText: hint),
              ),
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.button,
          children: [
            CustomizationMultilineTextField(
              value: editable.buttonText,
              maxHeight: AppDimensions.maxTextFieldHeight,
              onChanged: (text) => onChange(
                editable.copyWith(buttonText: text),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
