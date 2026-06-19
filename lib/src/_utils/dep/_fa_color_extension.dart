import 'package:flutter/material.dart';

import '_fa_color_transform.dart';

@Deprecated("No longer use")
extension FaColorExtension on Color {
  // ===========================================================================
  // LIGHTNESS
  // ===========================================================================

  Color lighter([double amount = 0.1]) =>
      FaColorTransform.lighten(this, amount);

  Color darker([double amount = 0.1]) => FaColorTransform.darken(this, amount);

  Color withLightnessValue(double lightness) =>
      FaColorTransform.withLightness(this, lightness);

  // ===========================================================================
  // TINT / SHADE
  // ===========================================================================

  Color tint(Color surface, [double amount = 0.1]) =>
      FaColorTransform.tint(base: this, surface: surface, amount: amount);

  Color shade([double amount = 0.1]) => FaColorTransform.shade(this, amount);

  // ===========================================================================
  // TONE
  // ===========================================================================

  Color tone(double amount) => FaColorTransform.tone(this, amount);
}
