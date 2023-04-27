import 'package:flutter/material.dart';
import 'package:survey_core/src/domain/entities/question_answer.dart';
import 'package:survey_core/src/domain/entities/question_types/slider_question_data.dart';
import 'package:survey_core/src/domain/entities/themes/slider_question_theme.dart';
import 'package:survey_core/src/presentation/utils/utils.dart';
import 'package:survey_core/src/presentation/widgets/question_bottom_button.dart';
import 'package:survey_core/src/presentation/widgets/question_content.dart';
import 'package:survey_core/src/presentation/widgets/question_title.dart';

/// The question page with a question, question description, button to submit
/// the answer and slider to select a value from a range
class SliderQuestionPage extends StatefulWidget {
  /// Contains the content for a page as minimum and maximum values of the
  /// slider, the initial value of the slider, and other properties
  final SliderQuestionData data;

  /// Callback that is called after pressing bottom button
  final OnSendCallback onSend;

  final VoidCallback? onSecondaryButtonTap;

  const SliderQuestionPage({
    required this.data,
    required this.onSend,
    this.onSecondaryButtonTap,
    super.key,
  });

  @override
  State<SliderQuestionPage> createState() => _SliderQuestionPageState();
}

class _SliderQuestionPageState extends State<SliderQuestionPage> {
  late double _answer;

  @override
  void initState() {
    super.initState();
    _answer = widget.data.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.data.theme ??
        Theme.of(context).extension<SliderQuestionTheme>()!;
    return Scaffold(
      backgroundColor: theme.fill,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.margin2XL,
                right: AppDimensions.margin2XL,
                top: AppDimensions.margin3XL,
                bottom: AppDimensions.marginXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.data.title.isNotEmpty)
                    QuestionTitle(
                      title: widget.data.title,
                      textSize: theme.titleSize,
                      textColor: theme.titleColor,
                    ),
                  if (widget.data.subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.marginS,
                      ),
                      child: QuestionContent(
                        content: widget.data.subtitle,
                        textSize: theme.subtitleSize,
                        textColor: theme.subtitleColor,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimensions.marginM),
                    child: _QuestionSlider(
                      minValue: widget.data.minValue,
                      maxValue: widget.data.maxValue,
                      initialValue: widget.data.initialValue,
                      onChanged: (value) => setState(() => _answer = value),
                      theme: theme,
                      divisions: widget.data.divisions,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (widget.data.isSkip)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: QuestionBottomButton(
                              text: widget.data.secondaryButtonText,
                              radius: theme.buttonRadius,
                              onPressed: widget.onSecondaryButtonTap ?? () {},
                            ),
                          ),
                        ),
                      Flexible(
                        child: QuestionBottomButton(
                          text: widget.data.primaryButtonText,
                          onPressed: () {
                            widget.onSend.call(
                              index: widget.data.index,
                              answer: QuestionAnswer<double>(_answer),
                            );
                          },
                          radius: theme.buttonRadius,
                          color: theme.buttonFill,
                          textColor: theme.buttonTextColor,
                          textSize: theme.buttonTextSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionSlider extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final int divisions;
  final ValueChanged<double> onChanged;
  final SliderQuestionTheme theme;

  const _QuestionSlider({
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.divisions,
    required this.theme,
    required this.initialValue,
  });

  @override
  State<_QuestionSlider> createState() => _QuestionSliderState();
}

class _QuestionSliderState extends State<_QuestionSlider> {
  late double _value;
  late final bool _onlyInt;

  @override
  void initState() {
    _value = widget.initialValue.toDouble();
    _onlyInt = widget.initialValue.ceilToDouble() ==
        widget.initialValue.floorToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.theme.textTheme.bodyMedium?.copyWith(
      fontFamily: AppFonts.inter,
    );
    _value = _value >= widget.minValue.toDouble() &&
            _value <= widget.maxValue.toDouble()
        ? _value
        : widget.initialValue.toDouble();
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: widget.theme.activeColor,
        inactiveTrackColor: widget.theme.inactiveColor,
        thumbColor: widget.theme.thumbColor,
        trackHeight: widget.theme.thickness,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: widget.theme.thumbRadius,
        ),
      ),
      child: Column(
        children: [
          Slider(
            divisions: widget.divisions,
            value: _value,
            onChanged: (newValue) => setState(() {
              _value = _onlyInt ? newValue.roundToDouble() : newValue;
              widget.onChanged(newValue);
            }),
            min: widget.minValue.toDouble(),
            max: widget.maxValue.toDouble(),
          ),
          const SizedBox(height: AppDimensions.margin2XS),
          Row(
            children: [
              Text(
                widget.minValue.toString(),
                style: textStyle,
              ),
              const Spacer(),
              Text(
                widget.maxValue.toString(),
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
