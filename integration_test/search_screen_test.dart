import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qiita_viewer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("searchScreen", () {
    testWidgets('フォームにキーワードを入力して検索すると検索結果が表示されている',
        (WidgetTester tester) async {
      await app.main();

      // 描画が終わるまで待つ
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);

      await tester.enterText(searchField, 'flutter');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });
  });
}
