// import 'package:flutter/material.dart';
// import '../../flutter_artist_core.dart';
// // IMPORTANT: Do not remove the "deferred" keyword.
// import 'eval_internal_impl.dart' deferred as impl;

// class FaCodeBridge {
//   FaCodeBridge._();
//
//   static Future<Widget> render({
//     required BuildContext context,
//     required String code,
//   }) async {
//     try {
//       // Chỉ tải bộ máy Eval khi người dùng vào Tab Demo
//       await impl.loadLibrary();
//
//       return impl.executeDynamicCode(
//         context: context,
//         code: code,
//       );
//     } catch (e) {
//       return Center(child: Text("Bridge Error: $e"));
//     }
//   }
// }
