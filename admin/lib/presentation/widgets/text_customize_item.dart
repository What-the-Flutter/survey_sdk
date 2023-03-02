import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:survey_admin/presentation/utils/constants/constants.dart';
import 'package:survey_admin/presentation/widgets/color_picker_dialog.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_item_container.dart';
import 'package:survey_admin/presentation/widgets/hex_color_field.dart';
import 'package:survey_admin/presentation/widgets/text_width_field.dart';

// TODO(dev): do we need this widget?
class TextCustomizeItem extends StatefulWidget {
  final String title;
  final int initialTextWidth;
  final Color initialColor;
  final ValueChanged<Color> onColorPicked;
  final ValueChanged<int> onTextWidthPicked;

  const TextCustomizeItem({
    required this.title,
    required this.initialTextWidth,
    required this.initialColor,
    required this.onColorPicked,
    required this.onTextWidthPicked,
    Key? key,
  }) : super(key: key);

  @override
  State<TextCustomizeItem> createState() => _TextCustomizeItemState();
}

class _TextCustomizeItemState extends State<TextCustomizeItem> {
  late final TextEditingController _colorTextController;
  late final TextEditingController _textWidthTextController;
  final stickyKey = GlobalKey();

  @override
  void initState() {
    _colorTextController = TextEditingController(
      text: widget.initialColor.value.toRadixString(16).padLeft(6, '0').toUpperCase(),
    );
    _textWidthTextController = TextEditingController(text: widget.initialTextWidth.toString());
    super.initState();
  }

  @override
  void dispose() {
    _colorTextController.dispose();
    _textWidthTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.marginM),
      child: Column(
        children: [
          CustomizationItemContainer(
            text: widget.title,
            isFontBold: true,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => pickColor(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorFromHex(
                      _colorTextController.value.text,
                      enableAlpha: true,
                    )!,
                  ),
                  width: AppDimensions.sizeM,
                  height: AppDimensions.sizeM,
                ),
              ),
              HexColorField(
                colorTextController: _colorTextController,
                onColorPicked: (color) {
                  setState(
                    () => widget.onColorPicked(color),
                  );
                },
              ),
              const SizedBox(width: AppDimensions.sizeM),
              TextWidthField(
                textWidthTextController: _textWidthTextController,
                onTextWidthPicked: (textWidth) => widget.onTextWidthPicked(textWidth),
              )
            ],
          ),
        ],
      ),
    );
  }

  void pickColor(BuildContext context) {
    final overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: Offset.zero.dx,
          child: ColorPickerDialog(
            onColorPicked: (color) {
              setState(() {
                widget.onColorPicked(color);
              });
            },
            colorTextController: _colorTextController,
            onClose: overlayEntry!.remove,
          ),
        );
      },
    );
    overlayState.insert(overlayEntry);
  }
}
