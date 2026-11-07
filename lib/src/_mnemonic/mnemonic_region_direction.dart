part of '_mnemonic.dart';

/// Direction for cycling keyboard focus between major view regions
/// (e.g., jumping between [BlockItemsView], [BlockFormView], and [FilterPanel]).
enum MnemonicRegionDirection {
  next(MnemonicModifier.control, LogicalKeyboardKey.tab, 'Ctrl + Tab'),
  previous(
    MnemonicModifier.controlShift,
    LogicalKeyboardKey.tab,
    'Ctrl + Shift + Tab',
  );

  final MnemonicModifier modifier;
  final LogicalKeyboardKey triggerKey;
  final String label;

  const MnemonicRegionDirection(this.modifier, this.triggerKey, this.label);

  SingleActivator toActivator({TargetPlatform? platform}) {
    return modifier.toActivator(triggerKey, platform: platform);
  }
}
