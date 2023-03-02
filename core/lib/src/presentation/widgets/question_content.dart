import 'package:flutter/material.dart';
import 'package:survey_core/src/presentation/utils/app_text_styles.dart';

class QuestionContent extends StatelessWidget {
  const QuestionContent({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: AppTextStyles.karlaSBlack,
    );
  }
}
