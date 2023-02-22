import 'package:survey_core/src/presentation/utils/app_fonts.dart';
import 'package:survey_core/src/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class QuestionBottomButton extends StatelessWidget {
  const QuestionBottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isOutlined = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.black.withOpacity(isEnabled ? 1.0 : 0.6);
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      borderRadius: BorderRadius.circular(
        AppDimensions.circularRadiusXS,
      ),
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.white : accentColor,
          borderRadius: BorderRadius.circular(
            AppDimensions.circularRadiusXS,
          ),
          border: Border.all(color: accentColor),
        ),
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isOutlined ? accentColor : Colors.white,
              fontWeight: AppFonts.weightBold,
              fontSize: AppFonts.sizeM,
            ),
          ),
        ),
      ),
    );
  }
}
