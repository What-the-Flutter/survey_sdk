import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/localizations.dart';
import 'package:survey_admin/presentation/utils/constants/constants.dart';
import 'package:survey_admin/presentation/widgets/customization_items/create_text_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_items_container.dart';
import 'package:survey_admin/presentation/widgets/customization_items/divisions_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_items/min_max_customization_item.dart';

class ContentCustomizationPanel extends StatelessWidget {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onSubtitleChanged;
  final void Function(int? min, int? max) onMinMaxChanged;
  final ValueChanged<int?> onDivisionsChanged;

  const ContentCustomizationPanel({
    super.key,
    required this.onDivisionsChanged,
    required this.onMinMaxChanged,
    required this.onSubtitleChanged,
    required this.onTitleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomizationItemsContainer(
          title: context.localization.title,
          children: [
            CreateTextCustomizationItem(
              maxHeight: AppDimensions.sizeL,
              onChanged: onTitleChanged,
            )
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.subtitle,
          children: [
            CreateTextCustomizationItem(
              maxHeight: AppDimensions.sizeL,
              onChanged: onSubtitleChanged,
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.value,
          children: [
            MinMaxCustomizationItem(
              onChanged: onMinMaxChanged,
            ),
          ],
        ),
        CustomizationItemsContainer(
          title: context.localization.divisions,
          children: [
            DivisionsCustomizationItem(
              onChanged: onDivisionsChanged,
            ),
          ],
        ),
      ],
    );
  }
}
