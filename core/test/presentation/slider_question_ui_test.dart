import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_core/src/domain/entities/question_answer.dart';
import 'package:survey_core/src/domain/entities/question_types/slider_question_data.dart';
import 'package:survey_core/src/domain/entities/themes/slider_question_theme.dart';
import 'package:survey_core/src/presentation/slider_question/slider_question_page.dart';
import 'package:survey_core/src/presentation/widgets/question_bottom_button.dart';

import 'widget/app_tester.dart';

void main() {
  group(
    'Slider question widget test',
    () {
      final completerOnSendButtonTap = Completer<void>();
      const title = 'Slider';
      const subTitle = '';

      final sliderQuestionPage = AppTester(
        child: SliderQuestionPage(
          data: const SliderQuestionData.common().copyWith(
            theme: const SliderQuestionTheme.common(),
          ),
          onSend: ({required int index, required QuestionAnswer answer}) {
            completerOnSendButtonTap.complete();
          },
        ),
      );

      testWidgets(
        'All content widget test',
        (widgetTester) async {
          await widgetTester.pumpWidget(sliderQuestionPage);
          await widgetTester.pumpAndSettle();
          expect(find.text(title), findsOneWidget);
          expect(find.text(subTitle), findsNothing);
          expect(find.byType(QuestionBottomButton), findsOneWidget);
          expect(find.byType(Slider), findsOneWidget);
        },
      );
      testWidgets(
        'Button test',
        (widgetTester) async {
          await widgetTester.pumpWidget(sliderQuestionPage);
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.byType(QuestionBottomButton));
          expect(completerOnSendButtonTap.isCompleted, isTrue);
        },
      );
      testWidgets(
        'Slider test',
        (widgetTester) async {
          await widgetTester.pumpWidget(sliderQuestionPage);
          await widgetTester.drag(find.byType(Slider), const Offset(50, 0));
          await widgetTester.pumpAndSettle();
          expect(find.byType(Slider), findsOneWidget);
        },
      );
      testWidgets(
        'Move slider to 2.5 value',
        (widgetTester) async {
          final completer = Completer<void>();
          const dragValue = 0.5;
          final sliderQuestionPage = AppTester(
            child: SliderQuestionPage(
              data: const SliderQuestionData.common().copyWith(
                minValue: 0,
                theme: const SliderQuestionTheme.common(),
              ),
              onSend: ({required int index, required QuestionAnswer answer}) {
                expect(
                  (answer as QuestionAnswer<double>).answer,
                  dragValue * 5,
                );
                completer.complete();
              },
            ),
          );
          await widgetTester.pumpWidget(sliderQuestionPage);
          final slider = find.byType(Slider);
          final zeroPoint = widgetTester.getTopLeft(slider);
          await widgetTester.drag(
            slider,
            Offset(zeroPoint.dx - 200, zeroPoint.dy),
            touchSlopY: 0,
          );
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.text('NEXT'));
        },
      );
    },
  );
}
