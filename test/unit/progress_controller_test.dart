import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiita_viewer/controllers/progress_controller.dart';

void main() {
  // テスト対象のクラスを宣言
  late ProgressController target;
  // テスト対象のクラスを初期化
  setUp(() {
    // ProviderContainerを作成
    final container = ProviderContainer();
    // ProviderContainerにCalcControllerを登録
    target = container.read(progressController.notifier);
  });

  group("ProgressController", () {
    test("stateの初期値がfalseであること", () {
      expect(target.state, false);
    });

    test("excuteWithProgressを実行すると実行中はstateがtrueになり、実行後はfalseになること", () async {
      await target.excuteWithProgress(() async {
        expect(target.state, true);
        return 0;
      });
      expect(target.state, false);
    });
  });
}
