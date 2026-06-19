import 'dart:ui';

@Deprecated("No longer use")
class ColorUtils {
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  static Color fromHex16ColorCode({
    required String hexColorCode,
    required Color defaultColor,
  }) {
    try {
      final hexCode = hexColorCode.replaceAll('#', '');
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }
}
