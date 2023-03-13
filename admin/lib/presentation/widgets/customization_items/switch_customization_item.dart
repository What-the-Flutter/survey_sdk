import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/utils/colors.dart';
import 'package:survey_admin/presentation/utils/constants/app_durations.dart';
import 'package:survey_admin/presentation/utils/theme_extension.dart';

class SwitchCustomizationItem extends StatelessWidget {
  final String title;
  final bool? initialValue;
  final void Function(bool isToggled)? onChanged;

  const SwitchCustomizationItem({
    required this.title,
    this.initialValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleSmall,
        ),
        _CustomSwitch(
          initialValue: initialValue ?? false,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final void Function(bool isToggled)? onChanged;

  const _CustomSwitch({
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<_CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch> {
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isToggled = !_isToggled;
        });
        widget.onChanged?.call(_isToggled);
      },
      child: AnimatedContainer(
        height: 18,
        width: 34,
        decoration: BoxDecoration(
          color: _isToggled
              ? AppColors.switchBackgroundActive
              : AppColors.switchBackgroundInactive,
          borderRadius: BorderRadius.circular(9),
        ),
        duration: AppDurations.customizationItemAnimation,
        child: AnimatedAlign(
          alignment: _isToggled ? Alignment.centerRight : Alignment.centerLeft,
          duration: AppDurations.customizationItemAnimation,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 14,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
