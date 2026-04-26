import 'package:flutter/material.dart';

typedef FaColorResolver = Color Function(BuildContext context);

class FaColorResolvers {
  // ===========================================================================
  // BACKGROUND & SURFACE
  // ===========================================================================

  /// Base background color for major screens or large containers
  /// (e.g., Scaffold background).
  static FaColorResolver backgroundResolver =
      (context) => Theme.of(context).colorScheme.surface;

  /// Low-emphasis surface container.
  /// Typically used for large sections that need subtle separation.
  static FaColorResolver surfaceContainerLowResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainerLow;

  /// Medium-emphasis surface container.
  /// Useful for secondary panels or grouped content.
  static FaColorResolver surfaceContainerHighResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainerHigh;

  /// High-emphasis surface container.
  /// Used for floating UI elements or high-priority overlays.
  static FaColorResolver surfaceContainerHighestResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainerHighest;

  /// Default container surface (glass, overlay, nested UI layers).
  static FaColorResolver surfaceContainerResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainer;

  // ===========================================================================
  // CONTENT & TEXT
  // ===========================================================================

  /// Primary content color for main text and key data.
  static FaColorResolver primaryContentResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Secondary informational label text.
  /// Example: "Field Name:", "Type:".
  static FaColorResolver infoLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Descriptive or long-form text.
  static FaColorResolver infoTextResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8);

  /// Muted text with reduced emphasis.
  static FaColorResolver mutedTextResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7);

  /// Placeholder text for input fields.
  static FaColorResolver placeholderTextResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

  /// Caption or secondary supporting text.
  static FaColorResolver captionTextResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

  // ===========================================================================
  // DATA & TECHNICAL
  // ===========================================================================

  /// Data label in detail or summary views.
  static FaColorResolver dataLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Data value in detail or summary views.
  static FaColorResolver dataValueResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Highlight for technical metadata (e.g., generics, annotations).
  static FaColorResolver technicalHighlightResolver =
      (context) => Theme.of(context).colorScheme.tertiary;

  /// Source code identifiers (API paths, variable names, etc.).
  static FaColorResolver sourceCodeResolver =
      (context) => Theme.of(context).colorScheme.secondary;

  // ===========================================================================
  // BRAND & HIGHLIGHT
  // ===========================================================================

  /// Primary brand or action highlight color.
  static FaColorResolver primaryHighlightResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Strong background highlight (e.g., banners, important notices).
  static FaColorResolver highlightBackgroundResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Text color displayed on top of highlight backgrounds.
  static FaColorResolver onHighlightTextResolver =
      (context) => Theme.of(context).colorScheme.onPrimary;

  // ===========================================================================
  // STATUS & ALERTS
  // ===========================================================================

  /// Error or critical alert color.
  static FaColorResolver alertErrorResolver =
      (context) => Theme.of(context).colorScheme.error;

  /// Warning state color (adaptive to brightness).
  static FaColorResolver alertWarningResolver = (context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFFFB74D) : const Color(0xFFF57C00);
  };

  /// Success state color (adaptive to brightness).
  static FaColorResolver alertSuccessResolver = (context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  };

  /// Informational state color.
  static FaColorResolver alertInfoResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Neutral state color.
  static FaColorResolver alertNeutralResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  // ===========================================================================
  // INTERACTION STATES
  // ===========================================================================

  /// Hover state overlay for interactive elements.
  static FaColorResolver interactiveHoverResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.08);

  /// Pressed state overlay for interactive elements.
  static FaColorResolver interactivePressedResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.12);

  /// Focus ring or outline color.
  static FaColorResolver focusRingResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Disabled content (text/icon).
  static FaColorResolver disabledContentResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38);

  /// Disabled background.
  static FaColorResolver disabledBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12);

  // ===========================================================================
  // SELECTION & FEEDBACK
  // ===========================================================================

  /// Background color for selected rows/items.
  static FaColorResolver selectedRowBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.15);

  /// Text color for selected rows/items.
  static FaColorResolver selectedRowTextResolver =
      (context) => Theme.of(context).colorScheme.primary;

  // ===========================================================================
  // STRUCTURE & DIVIDER
  // ===========================================================================

  /// Divider and separator color.
  static FaColorResolver dividerColorResolver =
      (context) => Theme.of(context).dividerColor;

  /// Subtle border color.
  static FaColorResolver borderSubtleResolver =
      (context) =>
          Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5);

  /// Default border color.
  static FaColorResolver borderDefaultResolver =
      (context) => Theme.of(context).colorScheme.outline;

  /// Strong border color.
  static FaColorResolver borderStrongResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  // ===========================================================================
  // NAVIGATION
  // ===========================================================================

  /// Default navigation item color.
  static FaColorResolver navItemResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Active navigation item color.
  static FaColorResolver navItemActiveResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Hover state for navigation items.
  static FaColorResolver navItemHoverResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.08);

  // ===========================================================================
  // SPECIALIZED
  // ===========================================================================

  /// Section or panel header color.
  static FaColorResolver sectionHeaderResolver =
      (context) =>
          Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9);

  /// Date/time value color.
  static FaColorResolver dateValueResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.8);

  /// UI indicators (icons, sort arrows, etc.).
  static FaColorResolver indicatorColorResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);
}
