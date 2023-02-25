import 'package:flutter/material.dart';
import 'package:survey_core/src/domain/entities/question_types/choice_question_data.dart';
import 'package:survey_core/src/domain/entities/question_types/input_question_data.dart';
import 'package:survey_core/src/domain/entities/question_types/intro_question_data.dart';
import 'package:survey_core/src/domain/entities/question_types/slider_question_data.dart';
import 'package:survey_core/src/domain/entities/survey_data.dart';
import 'package:survey_core/src/domain/entities/themes/common_theme.dart';
import 'package:survey_core/src/domain/entities/themes/text_field_theme_data.dart';
import 'package:survey_core/src/domain/entities/validator/input_validator.dart';
import 'package:survey_core/src/presentation/utils/colors.dart';

abstract class MockedQuestions {
  static const choice1 = ChoiceQuestionData(
    isMultipleChoice: true,
    options: ['option 1', 'option 2', 'option 3'],
    id: 0,
    title: 'title',
    subtitle: 'subtitle',
    typeQuestion: 'Choice',
    isSkip: true,
  );

  static const choice2 = ChoiceQuestionData(
    isMultipleChoice: false,
    options: ['option 1', 'option 2'],
    id: 1,
    title: 'Another title',
    subtitle: 'Another subtitle',
    typeQuestion: 'Choice',
    isSkip: false,
    info: 'info',
    content: 'content',
  );

  final input1 = InputQuestionData(
    validator: DefaultValidator(),
    value: 0,
    id: 0,
    title: 'title',
    subtitle: 'subtitle',
    typeQuestion: 'Input',
    isSkip: false,
  );

  final input2 = InputQuestionData(
    validator: NumberValidator(),
    value: 1,
    id: 1,
    title: 'Another title',
    subtitle: 'Another subtitle',
    typeQuestion: 'Input',
    isSkip: true,
    info: 'info',
    hintText: 'hint',
  );

  static const intro1 = IntroQuestionData(
    mainButtonTitle: 'Next',
    id: 0,
    title: 'title',
    subtitle: 'subtitle',
    typeQuestion: 'Intro',
    isSkip: false,
  );

  static const intro2 = IntroQuestionData(
    mainButtonTitle: 'Next',
    id: 1,
    title: 'Another title',
    subtitle: 'Another subtitle',
    typeQuestion: 'Intro',
    isSkip: true,
    info: 'info',
    secondaryButtonTitle: 'secondary button',
    content: 'content',
  );

  static const slider1 = SliderQuestionData(
    minValue: 0,
    maxValue: 10,
    initialValue: 1,
    id: 0,
    title: 'title',
    subtitle: 'subtitle',
    typeQuestion: 'Slider',
    isSkip: false,
  );

  static const slider2 = SliderQuestionData(
    minValue: 10,
    maxValue: 100,
    initialValue: 50,
    id: 1,
    title: 'Another title',
    subtitle: 'Another subtitle',
    typeQuestion: 'Slider',
    isSkip: true,
    info: 'info',
  );
}

abstract class MockedSurveyData {
  static final data1 = SurveyData(
    questions: [
      MockedQuestions.intro1,
      MockedQuestions.choice1,
      MockedQuestions.choice2,
    ],
    commonTheme: CommonTheme(
      textFieldThemeData: const TextFieldThemeData(
        thumbTheme: ThumbTheme(
          color: AppColors.black,
          radius: 10,
        ),
        thickness: 2.0,
        activeColor: AppColors.switchBackgroundActive,
        inactiveColor: AppColors.switchBackgroundInactive,
      ),
      sliderThemeData: const SliderThemeData(),
    ),
  );

  static final data2 = SurveyData(
    questions: [
      MockedQuestions.intro2,
      MockedQuestions.choice1,
      MockedQuestions.choice2,
      MockedQuestions.slider1,
    ],
    commonTheme: CommonTheme(
      textFieldThemeData: const TextFieldThemeData(
        thumbTheme: ThumbTheme(
          color: AppColors.textGrey,
          radius: 4,
        ),
        thickness: 2.0,
        activeColor: AppColors.switchBackgroundActive,
        inactiveColor: AppColors.switchBackgroundInactive,
      ),
      sliderThemeData: const SliderThemeData(),
    ),
  );
}
