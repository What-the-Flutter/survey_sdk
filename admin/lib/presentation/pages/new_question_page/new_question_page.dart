import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_admin/presentation/app/di/injector.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/pages/builder/builder_cubit.dart';
import 'package:survey_admin/presentation/pages/builder/builder_state.dart';
import 'package:survey_admin/presentation/pages/new_question_page/new_question_tabs.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/builder_page/editor_bar.dart';
import 'package:survey_admin/presentation/widgets/vector_image.dart';
import 'package:survey_client/survey_client.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({super.key});

  @override
  State<NewQuestionPage> createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  NewQuestionTabs _selectedTab = NewQuestionTabs.intro;
  String? _selectedOption;

  final BuilderCubit _cubit = i.get<BuilderCubit>();

  Widget _questionTab(NewQuestionTabs tab) {
    return _TabButton(
      title: tab.name(context),
      onTap: () {
        setState(
          () => _selectedTab = tab,
        );
      },
      isSelected: _selectedTab == tab,
    );
  }

  QuestionData _selectCommon(BuilderState state, NewQuestionTabs tab) {
    switch (tab) {
      case NewQuestionTabs.intro:
        return state.surveyData.commonTheme.intro;
      case NewQuestionTabs.choice:
        return state.surveyData.commonTheme.choice;
      case NewQuestionTabs.slider:
        return state.surveyData.commonTheme.slider;
      case NewQuestionTabs.customInput:
        return state.surveyData.commonTheme.input;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuilderCubit>(
      create: (context) => _cubit,
      child: BlocBuilder<BuilderCubit, BuilderState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(AppDimensions.appbarHeight),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: const _AppBarTitle(),
                actions: const [
                  _BackButton(),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.margin2XS,
                horizontal: AppDimensions.marginM,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: NewQuestionTabs.values.map(_questionTab).toList(),
                  ),
                  _QuestionOptionsListView(
                    options: _selectedTab.options,
                    selectedOption: _selectedOption ?? '',
                  ),
                  EditorBar(
                    onChange: _cubit.updateCommon,
                    editableQuestion: _selectCommon(state, _selectedTab),
                  ),
                ],
              ),
            ),
            persistentFooterButtons: [
              _AddButton(
                onPressed: () {
                  Navigator.pop(context, _selectedTab.data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: const Padding(
        padding: EdgeInsets.only(right: AppDimensions.marginL),
        child: VectorImage(assetName: AppAssets.closeIcon),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        context.localization.newScreen,
        style: context.theme.textTheme.labelLarge?.copyWith(
          fontWeight: AppFonts.weightRegular,
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _TabButton({
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final titleMedium = context.theme.textTheme.titleMedium;
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        width: AppDimensions.surveyContentBarWidth,
        child: ListTile(
          title: Text(
            title,
            style: isSelected
                ? titleMedium?.copyWith(
                    fontWeight: AppFonts.weightSemiBold,
                  )
                : titleMedium?.copyWith(
                    fontWeight: AppFonts.weightRegular,
                  ),
          ),
        ),
      ),
    );
  }
}

class _QuestionOptionsListView extends StatelessWidget {
  final List<NewQuestionOptions> options;
  final String selectedOption;

  const _QuestionOptionsListView({
    required this.options,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            for (final option in options)
              _AssetTextOption(
                assetName: option.asset,
                titleText: option.name(context),
              ),
          ],
        ),
      ),
    );
  }
}

class _AssetTextOption extends StatelessWidget {
  final String assetName;
  final String titleText;

  const _AssetTextOption({
    required this.assetName,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin4XL),
      padding: const EdgeInsets.all(AppDimensions.marginXS),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VectorImage(assetName: assetName),
          const SizedBox(height: AppDimensions.marginXL),
          Text(
            titleText,
            style: context.theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppDimensions.addButtonWidth,
        height: AppDimensions.addButtonHeight,
        decoration: const BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.circularRadiusXS),
          ),
        ),
        child: Center(
          child: Text(
            'ADD',
            style: context.theme.textTheme.labelLarge?.copyWith(
              fontFamily: AppFonts.karla,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
