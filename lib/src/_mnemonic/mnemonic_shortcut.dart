part of '_mnemonic.dart';

/// Standardized semantic commands triggered via keyboard shortcuts across
/// [Block], [Scalar], [FilterModel], [Task], and [Prozess] views.
enum MnemonicShortcut {
  // --- Block & Form Operations ---
  back(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyB, 'B'),
  create(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyC, 'C'),
  edit(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyE, 'E'),
  delete(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyD, 'D'),
  save(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyS, 'S'),
  reset(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyU, 'U'),
  refresh(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyR, 'R'),
  query(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyQ, 'Q'),

  // --- Data Grid & Pagination Navigation ---
  // --- Data Grid & Pagination Navigation ---
  // 1. Lật bản ghi (Next/Prev Item) - Dùng trơn
  previousItem(MnemonicModifier.none, LogicalKeyboardKey.pageUp, 'PgUp'),
  nextItem(MnemonicModifier.none, LogicalKeyboardKey.pageDown, 'PgDn'),

  // 2. Lật trang / Tải thêm (Load More) - Dùng ALT thay vì MNEMONIC để né Ctrl của Mac
  // Trên Mac: Option + Fn + Up / Down (hoặc Option + PageUp/PageDown)
  // Trên Win: Alt + Page Up / Down
  previousPage(MnemonicModifier.alt, LogicalKeyboardKey.pageUp, 'PgUp'),
  nextPage(MnemonicModifier.alt, LogicalKeyboardKey.pageDown, 'PgDn'),

  // 3. Nhảy về đầu/cuối danh sách
  firstPage(MnemonicModifier.none, LogicalKeyboardKey.home, 'Home'),
  loadMore(MnemonicModifier.none, LogicalKeyboardKey.end, 'End'),

  // --- Task / Prozess Operations ---
  submit(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyS, 'S'),
  restart(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyR, 'R'),
  restartAll(MnemonicModifier.mnemonicShift, LogicalKeyboardKey.keyR, 'R'),
  moveToNextStage(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyN, 'N'),
  moveToPreviousStage(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyP, 'P'),
  cancel(MnemonicModifier.mnemonic, LogicalKeyboardKey.keyX, 'X'),

  // --- Developer & Diagnostic Tools ---
  debugFilter(MnemonicModifier.mnemonic, LogicalKeyboardKey.digit1, '1'),
  debugForm(MnemonicModifier.mnemonic, LogicalKeyboardKey.digit2, '2'),
  debugInspector(MnemonicModifier.mnemonic, LogicalKeyboardKey.digit3, '3');

  final MnemonicModifier modifier;
  final LogicalKeyboardKey triggerKey;
  final String keyDisplayLabel;

  const MnemonicShortcut(this.modifier, this.triggerKey, this.keyDisplayLabel);

  /// Builds a Flutter [SingleActivator] for this command on the given [platform].
  SingleActivator toActivator({
    TargetPlatform? platform,
    bool includeRepeats = false,
  }) {
    return modifier.toActivator(
      triggerKey,
      platform: platform,
      includeRepeats: includeRepeats,
    );
  }

  /// Returns the platform-adapted shortcut label (e.g., `"Alt + S"` on Windows, `"Ctrl + S"` on macOS).
  String get shortcutLabel => '${modifier.label} + $keyDisplayLabel';

  /// Formats a base tooltip with the shortcut suffix, e.g., `"Save (Alt + S)"`.
  String formatTooltip(String baseTooltip) => '$baseTooltip ($shortcutLabel)';

  // /// Evaluates whether the given [event] and [keyboard] state match this command.
  // bool matches(KeyEvent event, HardwareKeyboard keyboard) {
  //   if (event is! KeyDownEvent) return false;
  //   if (!modifier.isPressed(keyboard)) return false;
  //
  //   // Match either by logicalKey or by physical key equivalent to remain
  //   // resilient against IME / keyboard layout remapping.
  //   if (event.logicalKey == triggerKey) return true;
  //
  //   final String? physicalName = event.physicalKey.debugName;
  //   if (physicalName != null) {
  //     if (physicalName == 'Key $keyDisplayLabel' ||
  //         physicalName == 'Digit $keyDisplayLabel') {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Trong mnemonic_shortcut.dart
  bool matches(KeyEvent event, HardwareKeyboard keyboard) {
    // CHO PHÉP CẢ GÕ VÀ GIỮ PHÍM (KeyRepeatEvent)
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;

    // Kiểm tra modifier (Ctrl / Alt)
    if (!modifier.isPressed(keyboard)) return false;

    // Khớp Logical Key (Bắt hoàn hảo Arrow, PageUp, Home, End...)
    if (event.logicalKey == triggerKey) return true;

    // Fallback chống trôi phím vật lý (cho các phím chữ/số A-Z)
    final String? physicalName = event.physicalKey.debugName;
    if (physicalName != null) {
      if (physicalName == 'Key $keyDisplayLabel' ||
          physicalName == 'Digit $keyDisplayLabel') {
        return true;
      }
    }
    return false;
  }
}
