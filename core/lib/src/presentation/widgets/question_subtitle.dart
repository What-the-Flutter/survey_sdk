import 'package:survey_core/src/presentation/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class QuestionSubtitle extends StatelessWidget {
  final String content;

  const QuestionSubtitle({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: AppFonts.sizeS,
        fontFamily: AppFonts.karlaFamily,
        fontWeight: AppFonts.weightRegular,
        color: Colors.black,
      ),
    );
  }
}
