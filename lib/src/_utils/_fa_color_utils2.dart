import 'package:flutter/material.dart';

import '../../flutter_artist_core.dart';

class FaColorUtils {
  // ===========================================================================
  // RESOLVERS (EXTENSION POINT - USER CAN OVERRIDE)
  // ===========================================================================

  static FaColorResolver infoLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  static FaColorResolver infoTextResolver =
      (context) => Theme.of(
        context,
      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.82);

  static FaColorResolver primaryContentResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  static FaColorResolver technicalHighlightResolver =
      (context) => Theme.of(context).colorScheme.tertiary;

  static FaColorResolver sourceCodeResolver =
      (context) => Theme.of(context).colorScheme.secondary;

  static FaColorResolver primaryHighlightResolver =
      (context) => Theme.of(context).colorScheme.primary;

  static FaColorResolver alertErrorResolver =
      (context) => Theme.of(context).colorScheme.error;

  static FaColorResolver surfaceContainerResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainer;

  static FaColorResolver dataLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  static FaColorResolver dataValueResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  static FaColorResolver sectionHeaderResolver =
      (context) =>
          Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9);

  static FaColorResolver selectedRowBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.12);

  static FaColorResolver selectedRowTextResolver =
      (context) => Theme.of(context).colorScheme.primary;

  static FaColorResolver dividerColorResolver =
      (context) => Theme.of(context).dividerColor;

  static FaColorResolver dateValueResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.75);

  static FaColorResolver indicatorColorResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);

  static FaColorResolver highlightBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.14);

  static FaColorResolver onHighlightTextResolver =
      (context) => Theme.of(context).colorScheme.onPrimary;
}

extension FaColorUtilsAPI on FaColorUtils {
  static Color infoLabel(BuildContext context) =>
      FaColorUtils.infoLabelResolver(context); // OLD: infoLabelResolver

  static Color infoText(BuildContext context) =>
      FaColorUtils.infoTextResolver(context); // OLD: infoTextResolver

  static Color primaryContent(BuildContext context) =>
      FaColorUtils.primaryContentResolver(
        context,
      ); // OLD: primaryContentResolver

  static Color technicalHighlight(BuildContext context) =>
      FaColorUtils.technicalHighlightResolver(context);

  static Color sourceCode(BuildContext context) =>
      FaColorUtils.sourceCodeResolver(context);

  static Color primaryHighlight(BuildContext context) =>
      FaColorUtils.primaryHighlightResolver(context);

  static Color alertError(BuildContext context) =>
      FaColorUtils.alertErrorResolver(context);

  static Color surfaceContainer(BuildContext context) =>
      FaColorUtils.surfaceContainerResolver(context);

  static Color dataLabel(BuildContext context) =>
      FaColorUtils.dataLabelResolver(context);

  static Color dataValue(BuildContext context) =>
      FaColorUtils.dataValueResolver(context);

  static Color sectionHeader(BuildContext context) =>
      FaColorUtils.sectionHeaderResolver(context);

  static Color selectedRowBackground(BuildContext context) =>
      FaColorUtils.selectedRowBackgroundResolver(context);

  static Color selectedRowText(BuildContext context) =>
      FaColorUtils.selectedRowTextResolver(context);

  static Color dividerColor(BuildContext context) =>
      FaColorUtils.dividerColorResolver(context);

  static Color dateValue(BuildContext context) =>
      FaColorUtils.dateValueResolver(context);

  static Color indicatorColor(BuildContext context) =>
      FaColorUtils.indicatorColorResolver(context);

  static Color highlightBackground(BuildContext context) =>
      FaColorUtils.highlightBackgroundResolver(context);

  static Color onHighlightText(BuildContext context) =>
      FaColorUtils.onHighlightTextResolver(context);
}
