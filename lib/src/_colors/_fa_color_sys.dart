import 'package:flutter/material.dart';

part 'fa_color_graph.dart';
part 'fa_color_resolvers.dart';
part 'fa_color_transform.dart';
part 'fa_colors.dart';
part 'fa_namespaces.dart';

/// ===========================================================================
/// EXTENSIONS
/// ===========================================================================

extension FaColorsContextX on BuildContext {
  FaColorGraph get faGraph =>
      FaColorGraph(Theme.of(this).colorScheme, Theme.of(this).brightness);

  _FaColors get faColors => _FaColors(this);
}

extension FaColorTransformExtension on Color {
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
