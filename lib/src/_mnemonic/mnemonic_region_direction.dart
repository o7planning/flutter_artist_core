part of '_mnemonic.dart';

/// Direction for cycling keyboard focus between major view regions
/// (e.g., jumping between [FilterPanel], [BlockItemsView], and [BlockFormView]).
enum MnemonicRegionDirection {
  next(
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.backquote,
    PhysicalKeyboardKey.backquote,
    '`',
  ),
  previous(
    MnemonicModifier.mnemonicShift,
    LogicalKeyboardKey.backquote,
    PhysicalKeyboardKey.backquote,
    '`',
  );

  final MnemonicModifier modifier;
  final LogicalKeyboardKey triggerKey;
  final PhysicalKeyboardKey physicalTriggerKey;
  final String keyDisplayLabel;

  const MnemonicRegionDirection(
    this.modifier,
    this.triggerKey,
    this.physicalTriggerKey,
    this.keyDisplayLabel,
  );

  /// Returns the platform-adapted shortcut label (e.g., `"Alt + `"` on Windows, `"Ctrl + `"` on macOS).
  String get shortcutLabel => '${modifier.label} + $keyDisplayLabel';

  SingleActivator toActivator({TargetPlatform? platform}) {
    return modifier.toActivator(triggerKey, platform: platform);
  }

  /// Evaluates whether [event] and [keyboard] match this region traversal direction.
  ///
  /// Checks [physicalTriggerKey] in addition to [triggerKey] because holding `Shift`
  /// with backquote on US layouts may resolve [KeyEvent.logicalKey] to `tilde` (`~`)
  /// on certain browsers/OS combinations.
  bool matches(KeyEvent event, HardwareKeyboard keyboard) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;
    if (!modifier.isPressed(keyboard)) return false;

    return event.logicalKey == triggerKey ||
        event.physicalKey == physicalTriggerKey;
  }

  /// Returns individual keycap tokens for rendering visual key badges.
  List<String> get keyCaps {
    if (modifier == MnemonicModifier.none) {
      return [keyDisplayLabel];
    }
    return [...modifier.label.split('+').map((e) => e.trim()), keyDisplayLabel];
  }
}
