import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiita_viewer/models/article.dart';
import 'package:qiita_viewer/models/user.dart';
import 'package:qiita_viewer/widgets/articles_container.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group("ArticleContainer", () {
    final article = Article(
      title: 'テスト',
      user: User(
        id: 'qii-taro',
        profileImageUrl: 'https://example.com/image.png',
      ),
      createdAt: DateTime.now(),
      tags: ['Flutter', 'dart'],
      url: 'https://example.com/article/1',
    );

    testWidgets("articleが表示されていること", (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
          home: ArticleContainer(
            article: article,
          ),
        ));
        expect(find.text('テスト'), findsOneWidget);
      });
    });

    // testWidgets(
    //     "Widgetをタップするとurlに遷移すること",
    //     (WidgetTester tester) => mockNetworkImagesFor(() async {
    //           await tester.pumpWidget(MaterialApp(
    //             home: ArticleContainer(
    //               article: article,
    //             ),
    //           ));
    //           await tester.tap(find.byType(GestureDetector));
    //           await tester.pumpAndSettle();
    //           expect(find.byType(ArticleScreen), findsOneWidget);
    //         }));
  });
}
