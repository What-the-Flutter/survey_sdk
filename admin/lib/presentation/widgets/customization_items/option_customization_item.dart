import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';

class OptionCustomizationItem extends StatefulWidget {
  final List<String> options;
  final ValueChanged<List<String>> onChanged;
  final ValueChanged<int> onRuleValueChanged;
  final int ruleValue;

  const OptionCustomizationItem({
    required this.options,
    required this.onChanged,
    required this.onRuleValueChanged,
    required this.ruleValue,
    super.key,
  });

  @override
  State<OptionCustomizationItem> createState() =>
      _OptionCustomizationItemState();
}

class _OptionCustomizationItemState extends State<OptionCustomizationItem> {
  final TextEditingController _controller = TextEditingController();
  List<String> _options = [];

  @override
  void initState() {
    super.initState();

    _options = widget.options;
  }

  void _onEditingComplete() {
    if (_controller.text.isNotEmpty) {
      setState(() => _options = [..._options, _controller.text]);
    }

    _controller.clear();
    widget.onChanged(_options);
  }

  void _delete(String option) {
    if (widget.ruleValue == _options.length) {
      widget.onRuleValueChanged(0);
    }
    final options = List.of(_options)..remove(option);
    setState(() => _options = options);
    widget.onChanged(options);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._options.map(
          (option) => _Option(
            option: option,
            delete: () => _delete(option),
          ),
        ),
        const SizedBox(height: AppDimensions.sizeS),
        Row(
          children: [
            const Icon(
              Icons.fiber_manual_record,
              size: AppDimensions.sizeS,
              color: AppColors.textLightGrey,
            ),
            const SizedBox(width: AppDimensions.margin2XS),
            Expanded(
              child: CustomizationTextField(
                controller: _controller,
                onEditingComplete: _onEditingComplete,
                decoration: InputDecoration.collapsed(
                  hintText: context.localization.typeNewOptionHere,
                  hintStyle: const TextStyle(
                    color: AppColors.textHintGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  final String option;
  final VoidCallback delete;

  const _Option({
    required this.option,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.fiber_manual_record,
          size: AppDimensions.sizeS,
        ),
        const SizedBox(width: AppDimensions.margin2XS),
        Expanded(
          child: Text(
            option,
            style: context.theme.textTheme.bodyLarge,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.close,
            size: AppDimensions.sizeM,
          ),
          onPressed: delete,
        ),
      ],
    );
  }
}
