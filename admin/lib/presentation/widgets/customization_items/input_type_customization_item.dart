import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_admin/presentation/utils/app_fonts.dart';
import 'package:survey_admin/presentation/utils/asset_strings.dart';
import 'package:survey_admin/presentation/utils/constants/constants.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text.dart';

enum InputType {
  text('Text'),
  number('Number'),
  date('Date');

  const InputType(
    this.name,
  );

  final String name;
}

class InputTypeCustomizationItem extends StatefulWidget {
  const InputTypeCustomizationItem({
    super.key,
    this.initialValue = InputType.text,
    this.onChanged,
  });

  final InputType initialValue;
  final void Function(InputType inputType)? onChanged;

  @override
  State<InputTypeCustomizationItem> createState() => _InputTypeCustomizationItemState();
}

class _InputTypeCustomizationItemState extends State<InputTypeCustomizationItem>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late InputType _selectedType;
  late final AnimationController _iconAnimationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    _selectedType = widget.initialValue;
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween(begin: 0.0, end: .5).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _iconAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: AppDimensions.marginM,
            left: AppDimensions.marginM,
          ),
          child: CustomizationText('Input type'),
        ),
        _InputTypeItem(
          inputType: _selectedType,
          trailing: RotationTransition(
            turns: _animation,
            child: SvgPicture.asset(AssetStrings.arrow),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            if (_isExpanded) {
              _iconAnimationController.forward();
            } else {
              _iconAnimationController.reverse();
            }
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 100),
          child: _isExpanded
              ? Column(
                  children: InputType.values
                      .where((inputType) => inputType != _selectedType)
                      .map(
                        (inputType) => _InputTypeItem(
                          inputType: inputType,
                          onTap: () {
                            setState(() {
                              _isExpanded = false;
                              _selectedType = inputType;
                            });
                            widget.onChanged?.call(inputType);
                            if (_isExpanded) {
                              _iconAnimationController.forward();
                            } else {
                              _iconAnimationController.reverse();
                            }
                          },
                        ),
                      )
                      .toList(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _InputTypeItem extends StatelessWidget {
  const _InputTypeItem({
    required this.inputType,
    required this.onTap,
    this.trailing,
  });

  final InputType inputType;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.margin2XS,
            horizontal: AppDimensions.marginM,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inputType.name,
                style: const TextStyle(
                  fontSize: AppFonts.sizeL,
                  fontWeight: AppFonts.weightRegular,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
