import 'package:flutter/material.dart';

/// Function signature for color calculation based on context.
typedef FaColorResolver = Color Function(BuildContext context);

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
class FaColorUtils {
  // ===========================================================================
  // RESOLVERS: Dynamic Overriding Mechanism
  // Allows users to reassign these functions to customize the theme behavior.
  // ===========================================================================

  /// Resolver cho màu nền chính của các màn hình hoặc container lớn (Scaffold background).
  static FaColorResolver backgroundResolver =
      (context) => Theme.of(context).colorScheme.surface;

  /// Resolver cho các thành phần UI mang tính chất bổ trợ cao (như nút mũi tên, thanh trượt).
  static FaColorResolver surfaceContainerHighestResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainerHighest;

  /// Resolver cho trạng thái cảnh báo (Warning)
  /// Sử dụng tertiary hoặc custom logic thích ứng với Brightness
  static FaColorResolver alertWarningResolver = (context) {
    // Ưu tiên lấy màu tertiary của hệ thống,
    // hoặc tự định nghĩa màu dựa trên Brightness nếu muốn kiểm soát tuyệt đối
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFFFB74D) : const Color(0xFFF57C00);
  };

  /// Resolver cho trạng thái thành công (Success)
  static FaColorResolver alertSuccessResolver = (context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  };


  /// Resolver for static metadata labels (e.g., "ID:", "Name:").
  static FaColorResolver infoLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Resolver for descriptive text values.

  static FaColorResolver infoTextResolver =
      (context) =>
          Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8);

  /// Resolver for main content text and primary values.
  static FaColorResolver primaryContentResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Resolver for highlighted technical metadata (e.g., <String>, [Required]).
  static FaColorResolver technicalHighlightResolver =
      (context) => Theme.of(context).colorScheme.tertiary;

  /// Resolver for code-level identifiers (e.g., API paths, variable names).
  static FaColorResolver sourceCodeResolver =
      (context) => Theme.of(context).colorScheme.secondary;

  /// Resolver for brand or primary action highlights.
  static FaColorResolver primaryHighlightResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Resolver for error messages or critical alerts.
  static FaColorResolver alertErrorResolver =
      (context) => Theme.of(context).colorScheme.error;

  /// Resolver for glass-morphic or background containers.
  static FaColorResolver surfaceContainerResolver =
      (context) => Theme.of(context).colorScheme.surfaceContainer;

  /// Resolver for data labels specifically in Detail Views.
  static FaColorResolver dataLabelResolver =
      (context) => Theme.of(context).colorScheme.onSurfaceVariant;

  /// Resolver for data values specifically in Detail Views.
  static FaColorResolver dataValueResolver =
      (context) => Theme.of(context).colorScheme.onSurface;

  /// Resolver for section or panel headers.
  static FaColorResolver sectionHeaderResolver =
      (context) =>
          Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9);

  /// Resolver for row background when selected in Lists or Tables.
  static FaColorResolver selectedRowBackgroundResolver =
      (context) =>
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.15);

  /// Resolver for text color on selected rows to ensure legibility.
  static FaColorResolver selectedRowTextResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Resolver for horizontal/vertical dividers.
  static FaColorResolver dividerColorResolver =
      (context) => Theme.of(context).dividerColor;

  /// Resolver for date and time values.
  static FaColorResolver dateValueResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.8);

  /// Resolver for icons like sort arrows or status indicators.
  static FaColorResolver indicatorColorResolver =
      (context) => Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);

  /// Resolver for background of highly emphasized notifications/highlights.
  static FaColorResolver highlightBackgroundResolver =
      (context) => Theme.of(context).colorScheme.primary;

  /// Resolver for text color appearing on top of highlight backgrounds.
  static FaColorResolver onHighlightTextResolver =
      (context) => Theme.of(context).colorScheme.onPrimary;

  // ===========================================================================
  // SEMANTIC ACCESSORS: Suggestive Method Names
  // These methods are used throughout the UI to fetch the correct color.
  // ===========================================================================

  /// Màu nền cơ bản của ứng dụng (Thường dùng cho Scaffold hoặc Container chính).
  static Color background(BuildContext context) => backgroundResolver(context);

  /// Màu nền cho các thành phần có độ ưu tiên hiển thị cao trên bề mặt (như nút đóng/mở panel).
  static Color surfaceContainerHighest(BuildContext context) =>
      surfaceContainerHighestResolver(context);

  /// Sử dụng cho các trạng thái cần lưu ý, icon "New", hoặc cảnh báo nhẹ.
  static Color alertWarning(BuildContext context) => alertWarningResolver(context);

  /// Sử dụng cho các trạng thái hoàn thành, "Done", hoặc xác nhận thành công.
  static Color alertSuccess(BuildContext context) => alertSuccessResolver(context);

  /// Used for static descriptive labels or hint text.
  /// Example: "Field Name:", "Data Type:".
  static Color infoLabel(BuildContext context) => infoLabelResolver(context);

  /// Used for descriptive text, notes, or long-form descriptions.
  static Color infoText(BuildContext context) => infoTextResolver(context);

  /// Used for primary text content and core data values.
  /// Example: "user_101", "Transaction Successful".
  static Color primaryContent(BuildContext context) =>
      primaryContentResolver(context);

  /// Used for technical metadata that needs to stand out.
  /// Example: "<String>", "<T>", "[system_generated]".
  static Color technicalHighlight(BuildContext context) =>
      technicalHighlightResolver(context);

  /// Used for source code level identifiers or technical paths.
  /// Example: API endpoints, class names, or variable identifiers.
  static Color sourceCode(BuildContext context) => sourceCodeResolver(context);

  /// Used for primary highlights, branding accents, or call-to-action colors.
  static Color primaryHighlight(BuildContext context) =>
      primaryHighlightResolver(context);

  /// Used for error states, validation failures, or critical system alerts.
  static Color alertError(BuildContext context) => alertErrorResolver(context);

  /// Background color for nested containers or blurred surface overlays.
  /// Provides a subtle separation between the content and the background.
  static Color surfaceContainer(BuildContext context) =>
      surfaceContainerResolver(context);

  /// Specific label color for data points in Detail or Summary views.
  /// Helps distinguish property names (e.g., "Code:") from their values.
  static Color dataLabel(BuildContext context) => dataLabelResolver(context);

  /// Specific value color for data points in Detail or Summary views.
  /// Optimized for high readability of business data (e.g., "USD", "Apple Inc.").
  static Color dataValue(BuildContext context) => dataValueResolver(context);

  /// Color for headers of sections, panels, or sidebars.
  /// Usually based on the secondary color for visual hierarchy.
  static Color sectionHeader(BuildContext context) =>
      sectionHeaderResolver(context);

  /// Background color for the currently selected row in a List or Table.
  /// Designed to be soft (low opacity) to avoid visual fatigue.
  static Color selectedRowBackground(BuildContext context) =>
      selectedRowBackgroundResolver(context);

  /// Text color for the selected row, ensuring high contrast against the selected background.
  static Color selectedRowText(BuildContext context) =>
      selectedRowTextResolver(context);

  /// Color for dividers and separators between UI elements.
  static Color dividerColor(BuildContext context) =>
      dividerColorResolver(context);

  /// Specialized color for DateTime or Timestamp values.
  /// Helps visually group time-related data.
  static Color dateValue(BuildContext context) => dateValueResolver(context);

  /// Color for UI indicators like sort arrows, scroll indicators, or status pips.
  static Color indicatorColor(BuildContext context) =>
      indicatorColorResolver(context);

  /// Solid background color for important highlights or emphasized banners.
  static Color highlightBackground(BuildContext context) =>
      highlightBackgroundResolver(context);

  /// Contrast color for text placed on top of [highlightBackground].
  /// Usually white or black depending on the theme brightness.
  static Color onHighlightText(BuildContext context) =>
      onHighlightTextResolver(context);
}
