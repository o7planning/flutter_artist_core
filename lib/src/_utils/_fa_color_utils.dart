import 'package:flutter/material.dart';
import 'package:flutter_artist_core/src/_utils/_fa_color_resolvers.dart';

/// FaColorUtils provides a semantic color system for the FlutterArtist library.
///
/// It decouples logical UI elements from hardcoded colors by using resolvers,
/// allowing developers to easily override the default look and feel.
///
/// Principles used here:
/// - infoLabel: Static labels, hints, or metadata keys.
/// - primaryContent: Main values, core text content.
/// - sourceCode: Technical identifiers like class names or variable names.
/// - technicalHighlight: Generic technical indicators usually wrapped in brackets.
/// FaColorUtils - Semantic Color System for FlutterArtist
///
/// IMPORTANT: LIFECYCLE MANAGEMENT
/// Most methods in this class rely on [Theme.of(context)], which depends on
/// InheritedWidgets.
///
/// ⚠️ COMMON ERROR:
/// Calling these methods inside [initState()] will throw an exception:
/// "dependOnInheritedWidgetOfExactType<_InheritedTheme>() called before initState() completed."
///
/// WHY THIS HAPPENS:
/// In Flutter, [initState()] is called before the widget is fully attached to
/// the element tree. At this stage, the [context] is not ready to look up
/// inherited widgets like [Theme].
///
/// ✅ THE SOLUTION:
/// 1. Use [didChangeDependencies()]: This method is called immediately after
///    [initState()] and whenever the theme changes. It is the safest place
///    to initialize controllers or variables that depend on colors.
/// 2. Use [build()]: Access colors directly during the build phase.
///
/// Example of correct usage:
/// ```
/// @override
/// void didChangeDependencies() {
///   super.didChangeDependencies();
///   if (!_initialized) {
///     _controller = TabbedViewController(_buildTabs()); // Safe to call FaColorUtils here
///     _initialized = true;
///   }
/// }
/// ```
/// Docs: [14893].
class FaColorUtils {
  // ===========================================================================
  // BACKGROUND & SURFACE
  // ===========================================================================

  /// Base background color for major screens (e.g., Scaffold).
  static Color background(BuildContext context) =>
      FaColorResolvers.backgroundResolver(context);

  /// Low-emphasis surface container.
  static Color surfaceContainerLow(BuildContext context) =>
      FaColorResolvers.surfaceContainerLowResolver(context);

  /// Medium-emphasis surface container.
  static Color surfaceContainerHigh(BuildContext context) =>
      FaColorResolvers.surfaceContainerHighResolver(context);

  /// High-emphasis surface container.
  static Color surfaceContainerHighest(BuildContext context) =>
      FaColorResolvers.surfaceContainerHighestResolver(context);

  /// Default container surface (nested or overlay UI).
  static Color surfaceContainer(BuildContext context) =>
      FaColorResolvers.surfaceContainerResolver(context);

  // ===========================================================================
  // CONTENT & TEXT
  // ===========================================================================

  /// Primary content color for main text and key data.
  static Color primaryContent(BuildContext context) =>
      FaColorResolvers.primaryContentResolver(context);

  /// Secondary label text (e.g., field names).
  static Color infoLabel(BuildContext context) =>
      FaColorResolvers.infoLabelResolver(context);

  /// Descriptive or long-form text.
  static Color infoText(BuildContext context) =>
      FaColorResolvers.infoTextResolver(context);

  /// Muted text with reduced emphasis.
  static Color mutedText(BuildContext context) =>
      FaColorResolvers.mutedTextResolver(context);

  /// Placeholder text for input fields.
  static Color placeholderText(BuildContext context) =>
      FaColorResolvers.placeholderTextResolver(context);

  /// Caption or secondary text.
  static Color captionText(BuildContext context) =>
      FaColorResolvers.captionTextResolver(context);

  // ===========================================================================
  // DATA & TECHNICAL
  // ===========================================================================

  /// Label for structured data (e.g., "Code:", "Type:").
  static Color dataLabel(BuildContext context) =>
      FaColorResolvers.dataLabelResolver(context);

  /// Value for structured data.
  static Color dataValue(BuildContext context) =>
      FaColorResolvers.dataValueResolver(context);

  /// Highlight for technical metadata.
  static Color technicalHighlight(BuildContext context) =>
      FaColorResolvers.technicalHighlightResolver(context);

  /// Color for source code identifiers.
  static Color sourceCode(BuildContext context) =>
      FaColorResolvers.sourceCodeResolver(context);

  // ===========================================================================
  // BRAND & HIGHLIGHT
  // ===========================================================================

  // TODO: Rename in Docs.
  // OLD: primaryHighlight -->  primaryAction
  /// Primary brand or action highlight.
  static Color primaryAction(BuildContext context) =>
      FaColorResolvers.primaryHighlightResolver(context);

  // TODO: Rename in Docs.
  // OLD: highlightBackground --> highlight
  /// Background for emphasized highlights.
  static Color highlight(BuildContext context) =>
      FaColorResolvers.highlightResolver(context);

  // TODO: Rename in Docs.
  // OLD: onHighlightText --> onHighlight
  /// Text color on highlight backgrounds.
  static Color onHighlight(BuildContext context) =>
      FaColorResolvers.onHighlightResolver(context);

  // ===========================================================================
  // STATUS & ALERTS
  // ===========================================================================

  /// Error or critical alert color.
  static Color alertError(BuildContext context) =>
      FaColorResolvers.alertErrorResolver(context);

  /// Warning state color.
  static Color alertWarning(BuildContext context) =>
      FaColorResolvers.alertWarningResolver(context);

  /// Success state color.
  static Color alertSuccess(BuildContext context) =>
      FaColorResolvers.alertSuccessResolver(context);

  /// Informational state color.
  static Color alertInfo(BuildContext context) =>
      FaColorResolvers.alertInfoResolver(context);

  /// Neutral state color.
  static Color alertNeutral(BuildContext context) =>
      FaColorResolvers.alertNeutralResolver(context);

  // ===========================================================================
  // INTERACTION STATES
  // ===========================================================================

  /// Hover state overlay for interactive elements.
  static Color interactiveHover(BuildContext context) =>
      FaColorResolvers.interactiveHoverResolver(context);

  /// Pressed state overlay.
  static Color interactivePressed(BuildContext context) =>
      FaColorResolvers.interactivePressedResolver(context);

  /// Focus ring or outline color.
  static Color focusRing(BuildContext context) =>
      FaColorResolvers.focusRingResolver(context);

  /// Disabled content (text/icon).
  static Color disabledContent(BuildContext context) =>
      FaColorResolvers.disabledContentResolver(context);

  /// Disabled background.
  static Color disabledBackground(BuildContext context) =>
      FaColorResolvers.disabledBackgroundResolver(context);

  // ===========================================================================
  // SELECTION & FEEDBACK
  // ===========================================================================

  /// Background color for selected items (e.g., table rows).
  static Color selectedRowBackground(BuildContext context) =>
      FaColorResolvers.selectedRowBackgroundResolver(context);

  /// Text color for selected items.
  static Color selectedRowText(BuildContext context) =>
      FaColorResolvers.selectedRowTextResolver(context);

  // ===========================================================================
  // STRUCTURE & DIVIDER
  // ===========================================================================

  /// Divider and separator color.
  static Color dividerColor(BuildContext context) =>
      FaColorResolvers.dividerColorResolver(context);

  /// Subtle border color.
  static Color borderSubtle(BuildContext context) =>
      FaColorResolvers.borderSubtleResolver(context);

  /// Default border color.
  static Color borderDefault(BuildContext context) =>
      FaColorResolvers.borderDefaultResolver(context);

  /// Strong border color.
  static Color borderStrong(BuildContext context) =>
      FaColorResolvers.borderStrongResolver(context);

  // ===========================================================================
  // NAVIGATION
  // ===========================================================================

  /// Default navigation item color.
  static Color navItem(BuildContext context) =>
      FaColorResolvers.navItemResolver(context);

  /// Active navigation item color.
  static Color navItemActive(BuildContext context) =>
      FaColorResolvers.navItemActiveResolver(context);

  /// Hover state for navigation items.
  static Color navItemHover(BuildContext context) =>
      FaColorResolvers.navItemHoverResolver(context);

  // ===========================================================================
  // SPECIALIZED
  // ===========================================================================

  /// Section or panel header color.
  static Color sectionHeader(BuildContext context) =>
      FaColorResolvers.sectionHeaderResolver(context);

  /// Date/time value color.
  static Color dateValue(BuildContext context) =>
      FaColorResolvers.dateValueResolver(context);

  /// UI indicator color (icons, arrows, etc.).
  static Color indicatorColor(BuildContext context) =>
      FaColorResolvers.indicatorColorResolver(context);
}
