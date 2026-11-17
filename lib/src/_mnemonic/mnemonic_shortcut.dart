part of '_mnemonic.dart';

/// Standardized semantic commands triggered via keyboard shortcuts across
/// [Block], [Scalar], [FilterModel], [Task], and [Prozess] views.
enum MnemonicShortcut {
  // --- Global Navigation ---
  back(
    MnemonicShortcutGroup.globalNavigation,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyB,
    'B',
    'Navigate Back / Close',
  ),

  // --- Block & Form Operations ---
  create(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyC,
    'C',
    'Create New Item',
  ),
  edit(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyE,
    'E',
    'Edit Current Item',
  ),
  delete(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyD,
    'D',
    'Delete Current Item',
  ),
  save(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyS,
    'S',
    'Save Form Changes',
  ),
  reset(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyU,
    'U',
    'Reset Form Changes',
  ),
  refresh(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyR,
    'R',
    'Refresh Current Item / Stage',
  ),
  query(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyQ,
    'Q',
    'Re-Query Data',
  ),

  // --- Data Grid & Pagination Navigation ---
  previousItem(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.none,
    LogicalKeyboardKey.pageUp,
    'PgUp',
    'Select Previous Item',
  ),
  nextItem(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.none,
    LogicalKeyboardKey.pageDown,
    'PgDn',
    'Select Next Item',
  ),
  previousPage(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.alt,
    LogicalKeyboardKey.pageUp,
    'PgUp',
    'Previous Page',
  ),
  nextPage(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.alt,
    LogicalKeyboardKey.pageDown,
    'PgDn',
    'Next Page',
  ),
  firstPage(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.none,
    LogicalKeyboardKey.home,
    'Home',
    'First Page / Top',
  ),
  loadMore(
    MnemonicShortcutGroup.fieldAndItemNavigation,
    MnemonicModifier.none,
    LogicalKeyboardKey.end,
    'End',
    'Load More Items',
  ),

  // --- Task / Prozess Operations ---
  submit(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyS,
    'S',
    'Submit Task / Viewing Stage',
  ),
  restart(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyR,
    'R',
    'Restart Task / Viewing Stage',
  ),
  restartAll(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonicShift,
    LogicalKeyboardKey.keyR,
    'R',
    'Restart Entire Prozess',
  ),
  moveToNextStage(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyN,
    'N',
    'Move to Next Stage',
  ),
  moveToPreviousStage(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyP,
    'P',
    'Move to Previous Stage',
  ),
  cancel(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.keyX,
    'X',
    'Cancel Prozess',
  ),

  // --- Developer & Diagnostic Tools ---
  debugFilterModel(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.digit1,
    '1',
    'Inspect Filter Model',
  ),
  debugFilterCriteria(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.digit2,
    '2',
    'Inspect Filter Criteria',
  ),
  debugFormModel(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.digit3,
    '3',
    'Inspect Form Model',
  ),
  debugInspector(
    MnemonicShortcutGroup.actions,
    MnemonicModifier.mnemonic,
    LogicalKeyboardKey.digit3,
    '3',
    'Inspect Prozess Context',
  );

  final MnemonicShortcutGroup group;
  final MnemonicModifier modifier;
  final LogicalKeyboardKey triggerKey;
  final String keyDisplayLabel;
  final String actionLabel;

  const MnemonicShortcut(
    this.group,
    this.modifier,
    this.triggerKey,
    this.keyDisplayLabel,
    this.actionLabel,
  );

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

  /// Returns the platform-adapted shortcut label (e.g., `"Alt + S"`, `"Ctrl + S"`, or `"PgDn"`).
  String get shortcutLabel {
    if (modifier == MnemonicModifier.none) {
      return keyDisplayLabel;
    }
    return '${modifier.label} + $keyDisplayLabel';
  }

  /// Returns individual keycap tokens for rendering visual key badges (e.g., `['Alt', 'S']` or `['PgDn']`).
  List<String> get keyCaps {
    if (modifier == MnemonicModifier.none) {
      return [keyDisplayLabel];
    }
    return [...modifier.label.split('+').map((e) => e.trim()), keyDisplayLabel];
  }

  /// Formats a base tooltip with the shortcut suffix, e.g., `"Save (Alt + S)"`.
  String formatTooltip(String baseTooltip) => '$baseTooltip ($shortcutLabel)';

  /// Converts this enum command into a [MnemonicShortcutDescriptor].
  MnemonicShortcutDescriptor toDescriptor({String? customActionLabel}) {
    return MnemonicShortcutDescriptor(
      group: group,
      actionLabel: customActionLabel ?? actionLabel,
      keyCaps: keyCaps,
    );
  }

  bool matches(KeyEvent event, HardwareKeyboard keyboard) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;
    if (!modifier.isPressed(keyboard)) return false;

    if (event.logicalKey == triggerKey) return true;

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
