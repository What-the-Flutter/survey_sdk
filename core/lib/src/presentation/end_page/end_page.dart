import 'package:flutter/material.dart';
import 'package:survey_sdk/src/domain/entities/question_types/info_question_data.dart';
import 'package:survey_sdk/src/domain/entities/themes/info_question_theme.dart';
import 'package:survey_sdk/src/presentation/utils/utils.dart';
import 'package:survey_sdk/src/presentation/widgets/info_data_view.dart';

/// The question page for displaying info content.
///
/// The [EndPage] widget is used to display information content to
/// the user. It can contain a title, subtitle, and buttons for navigation.
class EndPage extends StatefulWidget {
  /// Contains the content for a page.
  final InfoQuestionData data;

  const EndPage({
    required this.data,
    super.key,
  });

  @override
  State<EndPage> createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    final theme =
        widget.data.theme ?? Theme.of(context).extension<InfoQuestionTheme>()!;
    return Scaffold(
      backgroundColor: theme.fill,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: SurveyDimensions.margin2XL,
                right: SurveyDimensions.margin2XL,
                top: SurveyDimensions.margin3XL,
                bottom: SurveyDimensions.marginXL,
              ),
              child: InfoDataView(data: widget.data),
            ),
          ),
        ],
      ),
    );
  }
}
