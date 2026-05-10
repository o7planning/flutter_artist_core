part of '_fa_color_sys.dart';

/// ===========================================================================
/// 1. COLOR TRANSFORM (The Engine)
/// ===========================================================================
class FaColorTransform {
  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  static Color blend(Color fg, Color bg, double amount) {
    return Color.lerp(bg, fg, amount.clamp(0.0, 1.0))!;
  }

  /// Set absolute HSL lightness.
  static Color withLightness(Color color, double lightness) {
    final hsl = HSLColor.fromColor(color);

    return hsl
        .withLightness(lightness.clamp(0.0, 1.0))
        .toColor()
        .withValues(alpha: color.a);
  }

  // ===========================================================================
  // TINT / SHADE
  // ===========================================================================

  /// Blend color toward [surface].
  ///
  /// Commonly used for:
  /// - hover states
  /// - selected rows
  /// - Material surface tinting
  static Color tint({
    required Color base,
    required Color surface,
    required double amount,
    double alpha = 1.0,
  }) {
    final currentAlpha = base.a;

    final opaqueBase = base.withValues(alpha: 1.0);

    final result = Color.lerp(surface, opaqueBase, amount.clamp(0.0, 1.0))!;

    return result.withValues(alpha: currentAlpha * alpha);
  }

  /// Blend color toward black.
  static Color shade(Color color, [double amount = 0.1]) {
    return tint(base: color, surface: Colors.black, amount: amount);
  }

  // ===========================================================================
  // TONE
  // ===========================================================================

  /// Adjust saturation while preserving hue/lightness.
  ///
  /// amount:
  /// 0.0 = grayscale
  /// 1.0 = original saturation
  static Color tone(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);

    return hsl
        .withSaturation(amount.clamp(0.0, 1.0))
        .toColor()
        .withValues(alpha: color.a);
  }
}
