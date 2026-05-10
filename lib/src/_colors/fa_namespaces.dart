part of '_fa_color_sys.dart';

class _FaBarNamespace {
  final BuildContext context;

  _FaBarNamespace(this.context);

  Color get primary => FaBarResolvers.primary(context);

  Color get secondary => FaBarResolvers.secondary(context);
}

class _FaActionNamespace {
  final BuildContext context;

  _FaActionNamespace(this.context);

  _FaActionFillSubNamespace get fill => _FaActionFillSubNamespace(context);

  _FaActionInkSubNamespace get ink => _FaActionInkSubNamespace(context);

  _FaActionStoreSubNamespace get stroke => _FaActionStoreSubNamespace(context);

  Color get hover => FaActionStateResolvers.hover(context);

  Color get pressed => FaActionStateResolvers.pressed(context);

  Color get selected => FaActionStateResolvers.selected(context);
}

class _FaActionFillSubNamespace {
  final BuildContext context;

  _FaActionFillSubNamespace(this.context);

  Color get primary => FaActionSurfaceResolvers.primary(context);

  Color get secondary => FaActionSurfaceResolvers.secondary(context);

  Color get ghost => FaActionSurfaceResolvers.ghost(context);

  Color get selected => FaActionSurfaceResolvers.selected(context);

  Color get highlight => FaActionSurfaceResolvers.highlight(context);

  Color get muted => FaActionSurfaceResolvers.muted(context);

  Color get success => FaActionSurfaceResolvers.success(context);

  Color get warning => FaActionSurfaceResolvers.warning(context);

  Color get danger => FaActionSurfaceResolvers.danger(context);

  Color get info => FaActionSurfaceResolvers.info(context);
}

class _FaActionInkSubNamespace {
  final BuildContext context;

  _FaActionInkSubNamespace(this.context);

  // --- DIRECT: Returns a BOLD color (Primary/Secondary/...) ---
  Color get primary => FaActionTextResolvers.primary(context);

  Color get secondary => FaActionTextResolvers.secondary(context);

  Color get highlight => FaActionTextResolvers.highlight(context);

  Color get muted => FaActionTextResolvers.muted(context);

  Color get selected => FaActionTextResolvers.selected(context);

  // --- CORRESPONDENT: Returns the CONTRAST color (Usually WHITE/LIGHT)
  Color get onPrimaryFill => FaActionTextResolvers.onPrimary(context);

  Color get onSecondaryFill => FaActionTextResolvers.onSecondary(context);

  Color get onHighlightFill => FaActionTextResolvers.onHighlight(context);

  Color get onMutedFill => FaActionTextResolvers.onMuted(context);

  Color get onGhostFill => FaActionTextResolvers.onGhost(context);

  Color get onSelectedFill => FaActionTextResolvers.onSelected(context);

  // Surface Alias (Bold color - Used for individual icons/text on the Bar/Surface)
  Color get success => FaActionSurfaceResolvers.success(context);

  Color get warning => FaActionSurfaceResolvers.warning(context);

  Color get danger => FaActionSurfaceResolvers.danger(context);

  Color get info => FaActionSurfaceResolvers.info(context);

  // Contrast Color (Used to place ON TOP of buttons with corresponding backgrounds)
  Color get onSuccessFill => FaActionTextResolvers.onSuccess(context);

  Color get onWarningFill => FaActionTextResolvers.onWarning(context);

  Color get onDangerFill => FaActionTextResolvers.onDanger(context);

  Color get onInfoFill => FaActionTextResolvers.onInfo(context);

  // Giữ lại ghost như cũ vì bản chất nó là textPrimary
  Color get ghost => FaActionTextResolvers.ghost(context);
}

class _FaActionStoreSubNamespace {
  final BuildContext context;

  _FaActionStoreSubNamespace(this.context);

  Color get primary => FaActionStrokeResolvers.primary(context);

  Color get secondary => FaActionStrokeResolvers.secondary(context);

  Color get subtle => FaActionStrokeResolvers.subtle(context);

  // Color get primary => FaActionSurfaceResolvers.primary(context);
  // Color get secondary => FaActionSurfaceResolvers.secondary(context);
}

class _FaInkNamespace {
  final BuildContext context;

  _FaInkNamespace(this.context);

  Color get technical => FaSpecialResolvers.sourceCode(context);

  Color get primary => FaTextResolvers.primary(context);

  Color get secondary => FaTextResolvers.secondary(context);

  Color get muted => FaTextResolvers.muted(context);

  Color get label => FaTextResolvers.label(context);

  // Status Text (Dùng cho chữ trên bề mặt lớn)
  Color get success => FaStatusResolvers.success(context);

  Color get warning => FaStatusResolvers.warning(context);

  Color get danger => FaStatusResolvers.danger(context);

  Color get info => FaStatusResolvers.info(context);
}

class _FaSurfaceNamespace {
  final BuildContext context;

  _FaSurfaceNamespace(this.context);

  // Scaffold.
  Color get ground => FaSurfaceResolvers.ground(context);
  Color get subtle => FaSurfaceResolvers.subtle(context);
  // OLD name: low
  Color get muted => FaSurfaceResolvers.muted(context);
  // Container, Card.
  Color get standard => FaSurfaceResolvers.standard(context);
  // OLD name: high
  Color get emphasized => FaSurfaceResolvers.emphasized(context);
  Color get strong => FaSurfaceResolvers.strong(context);
}


class _FaStrokeNamespace {
  final BuildContext context;

  _FaStrokeNamespace(this.context);

  Color get subtle => FaStrokeResolvers.subtle(context);
  Color get standard => FaStrokeResolvers.standard(context);
  Color get strong => FaStrokeResolvers.strong(context);
}

class _FaTableNamespace {
  final BuildContext context;

  _FaTableNamespace(this.context);

  Color get rowSelected => FaTableResolvers.rowSelected(context);

  Color get rowHover => FaTableResolvers.rowHover(context);

  Color get rowPressed => FaTableResolvers.rowPressed(context);

  Color get rowCurrent => FaTableResolvers.rowCurrent(context);

  Color get inkNormal => FaTableResolvers.inkNormal(context);

  Color get inkSelected => FaTableResolvers.inkSelected(context);

  Color get inkCurrent => FaTableResolvers.inkCurrent(context);

  // Border
  Color get borderSelected => FaTableResolvers.borderSelected(context);
}

class _FaSelectionNamespace {
  final BuildContext context;

  _FaSelectionNamespace(this.context);

  Color get rowNormal => FaTableResolvers.rowNormal(context);

  Color get rowSelected => FaTableResolvers.rowSelected(context);

  Color get rowHover => FaTableResolvers.rowHover(context);

  Color get rowPressed => FaTableResolvers.rowPressed(context);

  Color get rowCurrent => FaTableResolvers.rowCurrent(context);

  Color get inkNormal => FaTableResolvers.inkNormal(context);

  Color get inkSelected => FaTableResolvers.inkSelected(context);

  Color get inkCurrent => FaTableResolvers.inkCurrent(context);

  // Border
  Color get borderSelected => FaTableResolvers.borderSelected(context);
}

class _FaInputNamespace {
  final BuildContext context;

  _FaInputNamespace(this.context);

  Color get background => FaInputResolvers.background(context);

  Color get border => FaInputResolvers.border(context);

  Color get focused => FaInputResolvers.borderFocused(context);
}

class _FaNavNamespace {
  final BuildContext context;

  _FaNavNamespace(this.context);

  Color get active => FaNavResolvers.active(context);

  Color get inactive => FaNavResolvers.inactive(context);
}

class _FaDividerNamespace {
  final BuildContext context;

  _FaDividerNamespace(this.context);

  Color get subtle => FaDividerResolvers.subtle(context);

  Color get strong => FaDividerResolvers.strong(context);
}

class _FaSpecialNamespace {
  final BuildContext context;

  _FaSpecialNamespace(this.context);

  Color get highlight => FaSpecialResolvers.highlight(context);

  Color get sourceCode => FaSpecialResolvers.sourceCode(context);
}

class _FaCommonNamespace {
  final BuildContext context;

  _FaCommonNamespace(this.context);

  Color get white => Colors.white;

  Color get black => Colors.black;

  Color get transparent => Colors.transparent;
}
