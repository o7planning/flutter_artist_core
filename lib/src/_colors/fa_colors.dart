part of '_fa_color_sys.dart';

class _FaColors {
  final BuildContext context;

  _FaColors(this.context);

  _FaInkNamespace get ink => _FaInkNamespace(context);

  _FaActionNamespace get action => _FaActionNamespace(context);

  _FaSurfaceNamespace get surface => _FaSurfaceNamespace(context);

  _FaBarNamespace get bar => _FaBarNamespace(context);

  _FaStrokeNamespace get stroke => _FaStrokeNamespace(context);

  _FaDividerNamespace get divider => _FaDividerNamespace(context);

  _FaCommonNamespace get common => _FaCommonNamespace(context);

  _FaSpecialNamespace get special => _FaSpecialNamespace(context);

  _FaTableNamespace get table => _FaTableNamespace(context);

  _FaInputNamespace get input => _FaInputNamespace(context);

  _FaNavNamespace get nav => _FaNavNamespace(context);

  _FaSelectionNamespace get selection => _FaSelectionNamespace(context);
}
