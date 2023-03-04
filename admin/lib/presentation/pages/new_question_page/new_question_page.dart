import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/utils/app_fonts.dart';
import 'package:survey_admin/presentation/utils/colors.dart';
import 'package:survey_admin/presentation/utils/constants/constants.dart';
import 'package:survey_admin/presentation/utils/constants/image_constants.dart';
import 'package:survey_admin/presentation/utils/theme_extension.dart';
import 'package:survey_admin/presentation/widgets/vector_image.dart';
import 'package:survey_core/survey_core.dart';

// TODO(dev): check localization
const _title = 'New screen';
const _tabs = [
  'Intro',
  'Choice',
  'Slider',
  'Custom input',
];
final Map<String, QuestionData> _dataMap = {
  'Intro': const IntroQuestionData.common(),
  'Choice': const ChoiceQuestionData.common(),
  'Slider': const SliderQuestionData.common(),
  'Custom input': const InputQuestionData.common(),
};
const _optionsInTabs = {
  'Intro': ['Title', 'Image intro'],
  'Choice': ['Radio button', 'Check box'],
  'Slider': ['Slider'],
  'Custom input': ['Single-line input', 'Multi-line input'],
};

const Map<String, String> _optionsAssets = {
  'Title': AppAssets.introImage,
  'Image intro': AppAssets.imageIntroImage,
  'Radio button': AppAssets.radioButtonImage,
  'Slider': AppAssets.sliderImage,
  'Check box': AppAssets.checkBoxImage,
  'Single-line input': AppAssets.singleLineInputImage,
  'Multi-line input': AppAssets.multiLineInputImage,
};

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({super.key});

  @override
  State<NewQuestionPage> createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  String _selectedTab = _tabs[0];
  String? _selectedOption;

  Widget _questionTab(String tabTitle) {
    return _TabButton(
      title: tabTitle,
      onTap: () {
        setState(
          () => _selectedTab = tabTitle,
        );
      },
      isSelected: _selectedTab == tabTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimensions.appbarSize),
          child: AppBar(
            toolbarHeight: AppDimensions.appbarSize,
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparentW,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _tabs.map(_questionTab).toList(),
              ),
              _QuestionOptionsListView(
                options: _optionsInTabs[_selectedTab] ?? [],
                selectedOption: _selectedOption ?? '',
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          _AddButton(
            onPressed: () {
              Navigator.pop(context, _dataMap[_selectedTab]);
            },
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.only(right: AppDimensions.marginL),
        child: const Align(
          alignment: Alignment.centerRight,
          child: VectorImage(assetName: AppAssets.closeIcon),
        ),
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
        _title,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: AppDimensions.sizeM),
        child: Text(
          title,
          style: isSelected
              ? context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: AppFonts.weightSemiBold,
                )
              : context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: AppFonts.weightRegular,
                ),
        ),
      ),
    );
  }
}

class _QuestionOptionsListView extends StatelessWidget {
  final List<String> options;
  final String selectedOption;

  const _QuestionOptionsListView({
    required this.options,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _AssetTextOption(
            assetName: _optionsAssets[options[index]] ?? '',
            titleText: options[index],
          );
        },
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
        width: 150,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(AppDimensions.circularRadiusXS),
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
