import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:survey_core/src/entities/api_object.dart';
import 'package:survey_core/src/entities/themes/theme_extension_composable.dart';

@immutable
class SurveySliderTheme extends ThemeExtension<SurveySliderTheme> with ApiObject {
  final ThumbTheme thumbTheme;
  final double thickness;
  final Color activeColor;
  final Color inactiveColor;

  const SurveySliderTheme({
    required this.thumbTheme,
    required this.thickness,
    required this.activeColor,
    required this.inactiveColor,
  });

  const SurveySliderTheme.common()
      : this(
          thumbTheme: const ThumbTheme.common(),
          thickness: 8.0,
          activeColor: Colors.black,
          inactiveColor: const Color(0xFFCCCCCC),
        );

  SurveySliderTheme.fromJson(Map<String, dynamic> json)
      : thumbTheme = ThumbTheme.fromJson(json['thumb']),
        thickness = json['thickness'],
        activeColor = Color(json['activeColor']),
        inactiveColor = Color(json['inactiveColor']);

  @override
  Map<String, dynamic> toJson() => {
        'thickness': thickness,
        'activeColor': activeColor.value,
        'inactiveColor': inactiveColor.value,
        'thumb': thumbTheme.toJson(),
      };

  @override
  ThemeExtension<SurveySliderTheme> copyWith({
    ThumbTheme? thumbTheme,
    double? thickness,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return SurveySliderTheme(
      thumbTheme: thumbTheme ?? this.thumbTheme,
      thickness: thickness ?? this.thickness,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  @override
  ThemeExtension<SurveySliderTheme> lerp(covariant ThemeExtension<SurveySliderTheme>? other, double t) {
    if (other is! SurveySliderTheme) {
      return this;
    }
    return SurveySliderTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      thickness: lerpDouble(thickness, other.thickness, t)!,
      thumbTheme: thumbTheme.lerp(other.thumbTheme, t),
    );
  }
}

@immutable
class ThumbTheme with ApiObject implements ThemeExtensionComposable<ThumbTheme> {
  final Color color;
  final double radius;

  const ThumbTheme({
    required this.color,
    required this.radius,
  });

  const ThumbTheme.common()
      : this(
          color: Colors.black,
          radius: 16.0,
        );

  ThumbTheme.fromJson(Map<String, dynamic> json)
      : color = Color(json['color']),
        radius = json['radius'];

  @override
  Map<String, dynamic> toJson() => {
        'color': color.value,
        'radius': radius,
      };

  @override
  ThumbTheme copyWith({
    Color? color,
    double? radius,
  }) {
    return ThumbTheme(color: color ?? this.color, radius: radius ?? this.radius);
  }

  @override
  ThumbTheme lerp(covariant ThumbTheme other, double t) {
    return ThumbTheme(
      color: Color.lerp(color, other.color, t)!,
      radius: lerpDouble(radius, other.radius, t)!,
    );
  }
}
