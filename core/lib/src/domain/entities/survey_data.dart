import 'package:survey_core/src/domain/entities/api_object.dart';
import 'package:survey_core/src/domain/entities/question_types/question_data.dart';
import 'package:survey_core/src/domain/entities/themes/common_theme.dart';

class SurveyData extends ApiObject {
  final List<QuestionData> questions;
  final CommonTheme commonTheme;

  SurveyData({
    required this.questions,
    required this.commonTheme,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'commonTheme': commonTheme.toJson(),
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }

  factory SurveyData.fromJson(Map<String, dynamic> json) {
    final questions = <QuestionData>[];
    for (final questionJson in json['questions']) {
      questions.add(QuestionData.fromType(questionJson));
    }
    return SurveyData(
      questions: questions,
      commonTheme: CommonTheme.fromJson(json['commonTheme']),
    );
  }

  SurveyData copyWith({
    List<QuestionData>? questions,
    CommonTheme? commonTheme,
  }) {
    return SurveyData(
      questions: questions ?? this.questions,
      commonTheme: commonTheme ?? this.commonTheme,
    );
  }

  List<Object?> get props => [
        ...questions,
        commonTheme,
      ];
}
