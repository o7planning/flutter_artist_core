part of '_fa_color_sys.dart';

/// ===========================================================================
/// COLOR GRAPH (The Logic Layer)
/// ===========================================================================

class FaColorGraph {
  final ColorScheme scheme;
  final Brightness brightness;

  FaColorGraph(this.scheme, this.brightness);

  bool get isDark => brightness == Brightness.dark;

  // ===========================================================================
  // INTERNAL STATE HELPERS
  // ===========================================================================

  Color _stateLayer(
    Color color, {
    required double lightAlpha,
    required double darkAlpha,
  }) {
    return color.withValues(alpha: isDark ? darkAlpha : lightAlpha);
  }

  Color _hover(Color color) =>
      _stateLayer(color, lightAlpha: 0.06, darkAlpha: 0.12);

  Color _pressed(Color color) =>
      _stateLayer(color, lightAlpha: 0.16, darkAlpha: 0.28);

  Color _selected(Color color) =>
      _stateLayer(color, lightAlpha: 0.14, darkAlpha: 0.24);

  // ===========================================================================
  // TEXT
  // ===========================================================================
  Color get textSelected => scheme.onSurface;

  Color get inkPrimary => scheme.onSurface;

  Color get textSecondary => scheme.onSurfaceVariant;

  /// Used for metadata / timestamps / disabled-like text.
  ///
  /// Keep readable.
  Color get textMuted =>
      scheme.onSurfaceVariant.withValues(alpha: isDark ? 0.72 : 0.78);

  Color get textLabel => scheme.onSurfaceVariant;

  Color get textHighlight => scheme.primary;

  Color get textOnHighlight => scheme.onPrimary;

  Color get textOnPrimary => scheme.onPrimary;

  Color get textOnSecondary => scheme.onSecondary;

  Color get textOnDanger => scheme.onError;

  Color get textOnInfo => scheme.onPrimary;

  // ===========================================================================
  // SURFACES
  // ===========================================================================

  /// App background (Scaffold).
  Color get surfaceGround => scheme.surface;

  Color get surfaceSubtle => scheme.surfaceContainerLowest;
  Color get surfaceMuted => scheme.surfaceContainerLow;
  Color get surfaceStandard => scheme.surfaceContainer;
  Color get surfaceEmphasized => scheme.surfaceContainerHigh;
  Color get surfaceStrong => scheme.surfaceContainerHighest;

  // ===========================================================================
  // BARS
  // ===========================================================================

  Color get barPrimary => scheme.surfaceContainer;

  Color get barSecondary => scheme.surfaceContainerLow;

  // ===========================================================================
  // BUTTONS
  // ===========================================================================

  Color get btnPrimaryBase => scheme.primary;

  Color get btnSecondaryBase => scheme.secondary;

  /// Ghost actions should not tint surfaces.
  ///
  /// Visual emphasis comes from:
  /// - text
  /// - icon
  /// - hover overlay
  Color get btnGhostBase => Colors.transparent;

  Color get btnHighlightSurface => scheme.tertiaryContainer;

  Color get btnMutedSurface => scheme.surfaceContainerLow;

  Color get btnSelectedSurface => _selected(scheme.primary);

  Color get btnPrimaryHover => _hover(scheme.primary);

  Color get btnPrimaryPressed => _pressed(scheme.primary);

  Color get btnPrimarySelected => _selected(scheme.primary);

  // ===========================================================================
  // TABLE / SELECTION
  // ===========================================================================

  /// Neutral base row.
  Color get tableRowNormal => scheme.surface;

  /// Hover should be subtle.
  Color get tableRowHover => _hover(scheme.primary);

  /// Selected should be visible immediately.
  Color get tableRowSelected => _selected(scheme.primary);

  /// Pressed should feel tactile.
  Color get tableRowPressed => _pressed(scheme.primary);

  /// Current/focused row.
  Color get tableRowCurrent => _selected(scheme.secondary);

  // Text inside rows

  Color get selectionInkNormal => inkPrimary;

  /// IMPORTANT:
  /// Because selected rows use alpha overlays,
  /// text should stay onSurface instead of onPrimary.
  Color get selectionInkSelected => inkPrimary;

  Color get selectionInkCurrent => inkPrimary;

  Color get selectionBorderSelected => scheme.primary;

  // ===========================================================================
  // SPECIAL
  // ===========================================================================

  Color get technicalHighlight => scheme.tertiary;

  Color get sourceCode => scheme.secondary;

  // ===========================================================================
  // DIVIDER / BORDER
  // ===========================================================================

  /// Light separators.
  ///
  /// Must stay visible on desktop UI.
  Color get dividerSubtle =>
      scheme.outlineVariant.withValues(alpha: isDark ? 0.90 : 0.75);

  /// Structural separators.
  Color get dividerStrong => scheme.outline;

  // ===========================================================================
  // NAVIGATION
  // ===========================================================================

  Color get navItemActive => scheme.primary;

  Color get navItemInactive => scheme.onSurfaceVariant;

  // ===========================================================================
  // INPUTS
  // ===========================================================================

  /// Inputs should use neutral surfaces.
  ///
  /// Never tint with primary.
  Color get inputFill => scheme.surfaceContainerLow;

  Color get inputBorder => scheme.outlineVariant;

  Color get inputBorderFocused => scheme.primary;

  // ===========================================================================
  // STATUS
  // ===========================================================================

  /// Semantic colors should come directly
  /// from the theme palette.
  ///
  /// Do NOT hardcode Material colors here.

  Color get info => scheme.primary;

  Color get success => scheme.tertiary;

  Color get warning => scheme.secondary;

  Color get danger => scheme.error;

  Color get textOnSuccess => scheme.onTertiary;

  Color get textOnWarning => scheme.onSecondary;

  // ===========================================================================
  // ICONS
  // ===========================================================================

  Color get iconPrimary => scheme.onSurface;

  Color get iconSecondary => scheme.onSurfaceVariant;

  Color get iconActive => scheme.primary;

  Color get iconSuccess => success;

  Color get iconWarning => warning;

  Color get iconDanger => danger;

  // ===========================================================================
  // OVERLAYS
  // ===========================================================================

  Color get hoverOverlay => _hover(scheme.primary);

  Color get pressedOverlay => _pressed(scheme.primary);

  Color get selectedOverlay => _selected(scheme.primary);
}
