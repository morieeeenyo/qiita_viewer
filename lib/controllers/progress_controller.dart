import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressController = NotifierProvider<ProgressController, bool>(
  ProgressController.new,
);

class ProgressController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<T> excuteWithProgress<T>(Future<T> Function() f) async {
    try {
      state = true; // ステータスを「処理中」に
      return await f();
    } finally {
      state = false; // ステータスを「処理していない」に
    }
  }
}
