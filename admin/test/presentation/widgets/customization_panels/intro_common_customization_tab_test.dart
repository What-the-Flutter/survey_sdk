import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_admin/presentation/widgets/customization_items/color_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/radius_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/intro/intro_common_customization_tab.dart';
import 'package:survey_core/survey_core.dart';

import '../app_tester.dart';

void main() {
  group(
    'Intro common customization panel',
    () {
      const redColorCode = 'FFF44336';
      const textSizeString = '20';
      const textSize = 20;
      const textSizeStringWithLetters = '1LLL';
      const textSizeWithLetters = 1;
      const textSizeStringMoreThan2 = '233';
      const redColor = Color(0xfff44336);
      const radius = 10;

      var data = const IntroQuestionData.common();

      final introCommonCustomPanel = AppTester(
        child: IntroCommonCustomizationTab(
          title: 'title',
          onChange: (QuestionData<dynamic> newData) {
            data = newData as IntroQuestionData;
          },
          editable: data,
        ),
      );

      testWidgets(
        'load widget',
        (tester) async {
          await tester.pumpWidget(introCommonCustomPanel);
          expect(find.byType(ColorCustomizationItem), findsNWidgets(5));
          expect(find.byType(RadiusCustomizationItem), findsOneWidget);
        },
      );
      testWidgets(
        'pick colors test',
        (tester) async {
          await tester.pumpWidget(introCommonCustomPanel);
          await tester.pumpAndSettle();
          final colorTextFields = find.byType(ColorCustomizationItem);
          for (var i = 0; i < colorTextFields.evaluate().length; i++) {
            await tester.enterText(
              colorTextFields.at(i),
              redColorCode,
            );
            await tester.testTextInput.receiveAction(TextInputAction.done);
          }
          await tester.pump();
          expect(find.text(redColorCode), findsNWidgets(5));
          expect(data.theme?.fill, redColor);
          expect(data.theme?.titleColor, redColor);
          expect(data.theme?.subtitleColor, redColor);
          expect(data.theme?.buttonFill, redColor);
          expect(data.theme?.buttonTextColor, redColor);
        },
      );
      testWidgets(
        'pick text width and radius test',
        (tester) async {
          await tester.pumpWidget(introCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.titleSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.subtitleSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.buttonTextSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(radius, textSize);

          expect(find.text(textSizeString), findsNWidgets(4));
        },
      );
      testWidgets(
        'pick text width and radius with letters',
        (tester) async {
          await tester.pumpWidget(introCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            textSizeStringWithLetters,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.titleSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            textSizeStringWithLetters,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.subtitleSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            textSizeStringWithLetters,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.theme?.buttonTextSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            textSizeStringWithLetters,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(radius, textSizeWithLetters);

          expect(find.text(textSizeStringWithLetters), findsNothing);
        },
      );
      testWidgets(
        'pick text width and radius with more than 2 digits',
        (tester) async {
          await tester.pumpWidget(introCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          expect(find.text(textSizeStringMoreThan2), findsNothing);
        },
      );
    },
  );
}
