part of '_fa_color_sys.dart';

typedef FaColorResolver = Color Function(BuildContext context);

// --- Button & Action Resolvers ---
class FaActionSurfaceResolvers {
  static FaColorResolver primary = (c) => c.faGraph.btnPrimaryBase;
  static FaColorResolver secondary = (c) => c.faGraph.btnSecondaryBase;
  static FaColorResolver ghost = (c) => c.faGraph.btnGhostBase;
  static FaColorResolver selected = (c) => c.faGraph.btnSelectedSurface;
  static FaColorResolver highlight = (c) => c.faGraph.btnHighlightSurface;
  static FaColorResolver muted = (c) => c.faGraph.btnMutedSurface;

  static FaColorResolver success = (c) => c.faGraph.success;
  static FaColorResolver warning = (c) => c.faGraph.warning;
  static FaColorResolver danger = (c) => c.faGraph.danger;
  static FaColorResolver info = (c) => c.faGraph.info;
}

class FaActionTextResolvers {
  static FaColorResolver primary = (c) => c.faGraph.btnPrimaryBase;
  static FaColorResolver secondary = (c) => c.faGraph.btnSecondaryBase;
  static FaColorResolver highlight = (c) => c.faGraph.btnHighlightSurface;
  static FaColorResolver muted = (c) => c.faGraph.btnMutedSurface;
  static FaColorResolver ghost = (c) => c.faGraph.inkPrimary;
  static FaColorResolver selected = (c) => c.faGraph.btnSelectedSurface;

  // --- CORRESPONDING COLOR (Used to write ON the corresponding Action surface)
  static FaColorResolver onPrimary = (c) => c.faGraph.textOnPrimary;
  static FaColorResolver onSecondary = (c) => c.faGraph.textOnSecondary;
  static FaColorResolver onHighlight = (c) => c.faGraph.textOnHighlight;
  static FaColorResolver onMuted = (c) => c.faGraph.textMuted;
  static FaColorResolver onSelected = (c) => c.faGraph.textSelected;

  // Other status colors retain the "On" logic.
  static FaColorResolver onSuccess = (c) => c.faGraph.textOnSuccess;
  static FaColorResolver onWarning = (c) => c.faGraph.textOnWarning;
  static FaColorResolver onDanger = (c) => c.faGraph.textOnDanger;
  static FaColorResolver onInfo = (c) => c.faGraph.textOnInfo;
  static FaColorResolver onGhost = (c) => c.faGraph.inkPrimary;
}

// --- Bar Resolvers (Special Surface) ---
class FaBarResolvers {
  // OLD name: primary 
  static FaColorResolver primary = (c) => c.faGraph.barPrimary;
  static FaColorResolver secondary = (c) => c.faGraph.barSecondary;

  // faColors.bar.subtle
  // faColors.bar.standard
  // faColors.bar.strong
}

class FaTextResolvers {
  static FaColorResolver primary = (c) => c.faGraph.inkPrimary;
  static FaColorResolver secondary = (c) => c.faGraph.textSecondary;
  static FaColorResolver muted = (c) => c.faGraph.textMuted;
  static FaColorResolver label = (c) => c.faGraph.textLabel;
}

class FaSurfaceResolvers {
  static FaColorResolver ground = (c) => c.faGraph.surfaceGround;
  static FaColorResolver subtle = (c) => c.faGraph.surfaceSubtle;
  static FaColorResolver muted = (c) => c.faGraph.surfaceMuted;
  static FaColorResolver standard = (c) => c.faGraph.surfaceStandard;
  static FaColorResolver emphasized = (c) => c.faGraph.surfaceEmphasized;
  static FaColorResolver strong = (c) => c.faGraph.surfaceStrong;
}

class FaStrokeResolvers {
  static FaColorResolver subtle = (c) => c.faGraph.surfaceSubtle.darker(0.2);
  static FaColorResolver standard =
      (c) => c.faGraph.surfaceStandard.darker(0.2);
  static FaColorResolver strong = (c) => c.faGraph.surfaceStrong.darker(0.2);
}

class FaDividerResolvers {
  static FaColorResolver subtle = (c) => c.faGraph.dividerSubtle;
  static FaColorResolver strong = (c) => c.faGraph.dividerStrong;
}

class FaTableResolvers {
  static FaColorResolver rowNormal = (c) => c.faGraph.tableRowNormal;
  static FaColorResolver rowSelected = (c) => c.faGraph.tableRowSelected;
  static FaColorResolver rowHover = (c) => c.faGraph.tableRowHover;
  static FaColorResolver rowPressed = (c) => c.faGraph.tableRowPressed;
  static FaColorResolver rowCurrent = (c) => c.faGraph.tableRowCurrent;

  static FaColorResolver inkNormal = (c) => c.faGraph.selectionInkNormal;
  static FaColorResolver inkSelected = (c) => c.faGraph.selectionInkSelected;
  static FaColorResolver inkCurrent = (c) => c.faGraph.selectionInkCurrent;

  // Border
  static FaColorResolver borderSelected =
      (c) => c.faGraph.selectionBorderSelected;
}

class FaActionStrokeResolvers {
  static FaColorResolver primary = (c) => c.faGraph.btnPrimaryBase;
  static FaColorResolver secondary = (c) => c.faGraph.btnSecondaryBase;
  static FaColorResolver subtle =
      (c) => c.faGraph.btnSecondaryBase; // TODO: Xem lai
}

class FaActionStateResolvers {
  static FaColorResolver hover = (c) => c.faGraph.btnPrimaryHover;
  static FaColorResolver pressed = (c) => c.faGraph.btnPrimaryPressed;
  static FaColorResolver selected = (c) => c.faGraph.btnPrimarySelected;
}

// --- Input Resolvers ---
class FaInputResolvers {
  static FaColorResolver background = (c) => c.faGraph.inputFill;
  static FaColorResolver border = (c) => c.faGraph.inputBorder;
  static FaColorResolver borderFocused = (c) => c.faGraph.inputBorderFocused;
}

// --- Special & Misc ---
class FaSpecialResolvers {
  static FaColorResolver highlight = (c) => c.faGraph.technicalHighlight;

  static FaColorResolver sourceCode = (c) => c.faGraph.technicalHighlight;
}

class FaNavResolvers {
  static FaColorResolver active = (c) => c.faGraph.navItemActive;
  static FaColorResolver inactive = (c) => c.faGraph.navItemInactive;
}

class FaStatusResolvers {
  static FaColorResolver success = (c) => c.faGraph.success;
  static FaColorResolver warning = (c) => c.faGraph.warning;
  static FaColorResolver danger = (c) => c.faGraph.danger;
  static FaColorResolver info = (c) => c.faGraph.info;
}
