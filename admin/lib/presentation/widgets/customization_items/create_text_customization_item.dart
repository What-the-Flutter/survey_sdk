import 'package:flutter/material.dart';
import 'package:survey_sdk/presentation/utils/app_fonts.dart';
import 'package:survey_sdk/presentation/utils/colors.dart';
import 'package:survey_sdk/presentation/utils/constants/constants.dart';

class CreateTextCustomizationItem extends StatelessWidget {
  final String title;
  final void Function(String? divisions) onChanged;

  const CreateTextCustomizationItem({
    Key? key,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.marginM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppFonts.sizeL,
              fontWeight: AppFonts.weightSemiBold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter text',
              ),
              maxLines: 10,
              style: const TextStyle(
                fontSize: AppFonts.sizeL,
                fontWeight: AppFonts.weightRegular,
                color: AppColors.black,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  onChanged(null);
                } else {
                  onChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
