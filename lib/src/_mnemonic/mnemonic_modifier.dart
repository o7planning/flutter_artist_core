part of '_mnemonic.dart';

/// Defines platform-adaptive and explicit modifier combinations for keyboard shortcuts.
///
/// ### Semantic Modifiers (Recommended):
/// - [primary] / [primaryShift]:
///   - Windows / Linux: `Ctrl` / `Ctrl + Shift`
///   - macOS / iOS: `Command (⌘)` / `⌘ + Shift`
///   *(Use carefully: avoid letters reserved by OS/Browsers like C, V, X, Z, A, N, R, W, T).*
///
/// - [mnemonic] / [mnemonicShift]:
///   - Windows / Linux: `Alt` / `Alt + Shift`
///   - macOS / iOS: `Control (⌃)` / `⌃ + Shift`
///   *(Conflict-free across all platforms: avoids Windows `Ctrl+C/V/X` AND avoids
///   macOS `Option` dead-key diacritics like `Option+U`, `Option+E`, `Option+N`).*
///
/// ### Explicit Hardware Modifiers:
/// - [control], [controlShift], [meta], [metaShift], [alt], [altShift], [controlAlt].
enum MnemonicModifier {
  none,

  /// Platform primary action modifier (`Ctrl` on Windows/Linux, `⌘` on macOS).
  primary,

  /// Platform primary modifier + `Shift` (`Ctrl + Shift` on Windows/Linux, `⌘ + Shift` on macOS).
  primaryShift,

  /// Platform-safe mnemonic modifier (`Alt` on Windows/Linux, `Control (⌃)` on macOS).
  /// Prevents dead-key character conflicts (`Option + U/E/N`) on macOS and
  /// clipboard conflicts (`Ctrl + C/V/X/Z/A`) on Windows/Linux.
  mnemonic,

  /// Platform-safe mnemonic modifier + `Shift` (`Alt + Shift` on Win/Linux, `⌃ + Shift` on macOS).
  mnemonicShift,

  /// Explicit physical `Control` key on all platforms.
  control,

  /// Explicit physical `Control + Shift` keys on all platforms.
  controlShift,

  /// Explicit physical `Meta` (`⌘` on macOS, `Win` on Windows) key.
  meta,

  /// Explicit physical `Meta + Shift` keys.
  metaShift,

  /// Explicit physical `Alt` (`Option` on macOS) key.
  alt,

  /// Explicit physical `Alt + Shift` (`Option + Shift` on macOS) keys.
  altShift,

  /// Explicit physical `Control + Alt` (`⌃ + Option` on macOS) keys.
  controlAlt;

  /// Determines whether the target [platform] uses the `Meta` (`Command ⌘`) key
  /// as its primary OS shortcut modifier.
  static bool usesMetaAsPrimary(TargetPlatform platform) {
    return platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;
  }

  /// Resolves the boolean modifier flags `(control, meta, alt, shift)` for the given [platform].
  ({bool control, bool meta, bool alt, bool shift}) _resolveFlags([
    TargetPlatform? platform,
  ]) {
    final TargetPlatform resolvedPlatform = platform ?? defaultTargetPlatform;
    final bool apple = usesMetaAsPrimary(resolvedPlatform);

    return switch (this) {
      MnemonicModifier.primary => (
        control: !apple,
        meta: apple,
        alt: false,
        shift: false,
      ),
      MnemonicModifier.primaryShift => (
        control: !apple,
        meta: apple,
        alt: false,
        shift: true,
      ),
      MnemonicModifier.mnemonic => (
        control: apple,
        meta: false,
        alt: !apple,
        shift: false,
      ),
      MnemonicModifier.mnemonicShift => (
        control: apple,
        meta: false,
        alt: !apple,
        shift: true,
      ),
      MnemonicModifier.control => (
        control: true,
        meta: false,
        alt: false,
        shift: false,
      ),
      MnemonicModifier.controlShift => (
        control: true,
        meta: false,
        alt: false,
        shift: true,
      ),
      MnemonicModifier.meta => (
        control: false,
        meta: true,
        alt: false,
        shift: false,
      ),
      MnemonicModifier.metaShift => (
        control: false,
        meta: true,
        alt: false,
        shift: true,
      ),
      MnemonicModifier.alt => (
        control: false,
        meta: false,
        alt: true,
        shift: false,
      ),
      MnemonicModifier.altShift => (
        control: false,
        meta: false,
        alt: true,
        shift: true,
      ),
      MnemonicModifier.controlAlt => (
        control: true,
        meta: false,
        alt: true,
        shift: false,
      ),
      MnemonicModifier.none => (
        control: false,
        meta: false,
        alt: false,
        shift: false,
      ),
    };
  }

  /// Converts this modifier and a [LogicalKeyboardKey] into a Flutter [SingleActivator].
  SingleActivator toActivator(
    LogicalKeyboardKey key, {
    TargetPlatform? platform,
    bool includeRepeats = false,
  }) {
    final flags = _resolveFlags(platform);
    return SingleActivator(
      key,
      control: flags.control,
      meta: flags.meta,
      alt: flags.alt,
      shift: flags.shift,
      includeRepeats: includeRepeats,
    );
  }

  /// Checks whether the current hardware keyboard state matches this exact modifier combination.
  bool isPressed(HardwareKeyboard keyboard, {TargetPlatform? platform}) {
    final flags = _resolveFlags(platform);
    return keyboard.isControlPressed == flags.control &&
        keyboard.isMetaPressed == flags.meta &&
        keyboard.isAltPressed == flags.alt &&
        keyboard.isShiftPressed == flags.shift;
  }

  /// Returns the platform-aware human-readable label for UI tooltips.
  String get label {
    final bool apple = usesMetaAsPrimary(defaultTargetPlatform);

    switch (this) {
      case MnemonicModifier.primary:
        return apple ? '⌘' : 'Ctrl';
      case MnemonicModifier.primaryShift:
        return apple ? '⌘ + Shift' : 'Ctrl + Shift';
      case MnemonicModifier.mnemonic:
        return apple ? 'Ctrl' : 'Alt';
      case MnemonicModifier.mnemonicShift:
        return apple ? 'Ctrl + Shift' : 'Alt + Shift';
      case MnemonicModifier.control:
        return 'Ctrl';
      case MnemonicModifier.controlShift:
        return 'Ctrl + Shift';
      case MnemonicModifier.meta:
        return apple ? '⌘' : 'Meta';
      case MnemonicModifier.metaShift:
        return apple ? '⌘ + Shift' : 'Meta + Shift';
      case MnemonicModifier.alt:
        return apple ? 'Option' : 'Alt';
      case MnemonicModifier.altShift:
        return apple ? 'Option + Shift' : 'Alt + Shift';
      case MnemonicModifier.controlAlt:
        return apple ? 'Ctrl + Option' : 'Ctrl + Alt';
      case MnemonicModifier.none:
        return '';
    }
  }
}
