import 'package:flutter/material.dart';

import '../../flutter_artist_core.dart';

class FaColorUtils {
  // ===========================================================================
  // RESOLVERS: Dynamic Overriding Mechanism
  // NOTE: Kept for backward compatibility. Do not remove in v1 migration.
  // ===========================================================================

  static FaColorResolver surfaceContainerHighestResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainerHighest;

  /// Static labels, hints, metadata
  /// NOTE: Previously mapped to onSurfaceVariant directly.
  static FaColorResolver infoLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Descriptive text values
  /// NOTE: opacity tuning is intentional (UI readability adjustment layer)
  static FaColorResolver infoTextResolver =
      (context) => Theme.of(
        context,
      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.85);

  /// Primary content text
  static FaColorResolver primaryContentResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Technical highlights (tags, brackets, metadata markers)
  /// NOTE: previously conceptually "tertiary usage"
  static FaColorResolver technicalHighlightResolver =
      (context) => Theme.of(context).colorScheme.tertiary;

  /// Code identifiers (API, variables, class names)
  static FaColorResolver sourceCodeResolver =
      (context) => Theme.of(context).colorScheme.secondary;

  /// Primary accent / brand highlight
  static FaColorResolver primaryHighlightResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Error / alert states
  static FaColorResolver alertErrorResolver =
      (context) => Theme.of(context).colorScheme.error;

  /// Container background (glass / nested UI)
  /// NOTE: still Material-based surfaceContainer
  static FaColorResolver surfaceContainerResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainer;

  /// Data labels in detail views
  static FaColorResolver dataLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Data values in detail views
  static FaColorResolver dataValueResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Section headers
  /// NOTE: kept semantic emphasis, not strictly Material rule
  static FaColorResolver sectionHeaderResolver =
      (context) =>
          Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9);

  /// Selected row background
  static FaColorResolver selectedRowBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.12);

  /// Selected row text
  static FaColorResolver selectedRowTextResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Divider color
  static FaColorResolver dividerColorResolver =
      (context) => Theme.of(context).dividerColor;

  /// Date/time values
  static FaColorResolver dateValueResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.8);

  /// UI indicators (status, sort arrows)
  static FaColorResolver indicatorColorResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);

  /// Highlight background
  static FaColorResolver highlightBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.15);

  /// Text on highlight background
  static FaColorResolver onHighlightTextResolver =
      (context) => Theme.of(context).colorScheme.onPrimary;

  // ===========================================================================
  // SEMANTIC ACCESSORS (UNCHANGED PUBLIC API)
  // ===========================================================================

  static Color infoLabel(BuildContext context) => infoLabelResolver(context);

  static Color infoText(BuildContext context) => infoTextResolver(context);

  static Color primaryContent(BuildContext context) =>
      primaryContentResolver(context);

  static Color technicalHighlight(BuildContext context) =>
      technicalHighlightResolver(context);

  static Color sourceCode(BuildContext context) => sourceCodeResolver(context);

  static Color primaryHighlight(BuildContext context) =>
      primaryHighlightResolver(context);

  static Color alertError(BuildContext context) => alertErrorResolver(context);

  static Color surfaceContainer(BuildContext context) =>
      surfaceContainerResolver(context);

  static Color dataLabel(BuildContext context) => dataLabelResolver(context);

  static Color dataValue(BuildContext context) => dataValueResolver(context);

  static Color sectionHeader(BuildContext context) =>
      sectionHeaderResolver(context);

  static Color selectedRowBackground(BuildContext context) =>
      selectedRowBackgroundResolver(context);

  static Color selectedRowText(BuildContext context) =>
      selectedRowTextResolver(context);

  static Color dividerColor(BuildContext context) =>
      dividerColorResolver(context);

  static Color dateValue(BuildContext context) => dateValueResolver(context);

  static Color indicatorColor(BuildContext context) =>
      indicatorColorResolver(context);

  static Color highlightBackground(BuildContext context) =>
      highlightBackgroundResolver(context);

  static Color onHighlightText(BuildContext context) =>
      onHighlightTextResolver(context);
}
