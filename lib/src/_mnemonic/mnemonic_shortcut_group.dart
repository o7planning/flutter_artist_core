part of '_mnemonic.dart';

/// Semantic grouping of keyboard shortcuts used for organizing documentation,
/// tooltips, and shortcut help dialogs across the FlutterArtist ecosystem.
enum MnemonicShortcutGroup {
  /// Domain commands (CRUD, form submission, stage transitions, debug inspectors).
  actions('Actions & Commands'),

  /// Record, pagination, and field-level traversal within the active view.
  fieldAndItemNavigation('Field & Item Navigation'),

  /// Screen-level custom buttons wrapped with [ControlMnemonic].
  customControls('Screen Controls'),

  /// Application-wide navigation (region cycling, help dialog, back navigation).
  globalNavigation('Global & Region Navigation');

  final String title;

  const MnemonicShortcutGroup(this.title);
}

/// Immutable UI-agnostic descriptor for a keyboard shortcut entry.
///
/// Shared between `flutter_artist_core`, `flutter_artist`, and `flutter_artist_commons_ui`
/// so any UI layer can render shortcut cheat sheets consistently.
class MnemonicShortcutDescriptor {
  final MnemonicShortcutGroup group;
  final String actionLabel;
  final List<String> keyCaps;

  const MnemonicShortcutDescriptor({
    required this.group,
    required this.actionLabel,
    required this.keyCaps,
  });
}
