import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiita_viewer/widgets/loading.dart';

void main() {
  group("Loading", () {
    testWidgets("CircularProgressIndicatorが表示されていること",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Loading(),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
