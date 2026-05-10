// import 'package:flutter/material.dart';
// import 'package:flutter_eval/flutter_eval.dart';
// import 'package:flutter_artist_core/flutter_artist_core.dart';
//
// import 'package:flutter_eval/flutter_eval.dart';
// import 'package:flutter_artist_core/flutter_artist_core.dart';

// Widget executeDynamicCode({
//   required BuildContext context,
//   required String code,
// }) {
//   // Tạo đoạn code hoàn chỉnh bọc ngoài snippet của ông giáo
//   final fullCode = '''
// import 'package:flutter/material.dart';
// import 'package:flutter_artist/flutter_artist.dart';
//
// Widget build(BuildContext context) {
//   return $code;
// }
// ''';
//
//   return EvalWidget(
//     packages: {
//       'example': {
//         'main.dart': fullCode,
//       }
//     },
//     // Đăng ký các Bridge để Eval hiểu được "context.colors"
//     library: 'package:example/main.dart',
//     function: 'build',
//     args: [context],
//     // Đây là nơi "phép thuật" xảy ra
//     builders: {
//       'package:flutter_artist/flutter_artist.dart': {
//         // Chúng ta ánh xạ FaColors vào môi trường Eval
//         'FaColors': (id, target, args) => FaColorsBridge(context),
//       }
//     }, assetPath: '',
//   );
// }
