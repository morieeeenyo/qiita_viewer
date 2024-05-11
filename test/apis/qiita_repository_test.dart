import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_viewer/apis/qiita_repository.dart';
import 'package:qiita_viewer/models/article.dart';

import '../../generated/mocks/apis/qiita_client.mocks.dart';

void main() async {
  group("QiitaRepository", () {
    late QiitaRepository qiitaRepository;
    late MockQiitaClient mockQiitaClient;

    setUp(() {
      mockQiitaClient = MockQiitaClient();
      qiitaRepository = QiitaRepository();
      QiitaRepository.client = mockQiitaClient; // モックを設定
    });

    test('API通信が成功し、Articleが取得できること', () async {
      const keyword = 'flutter';
      final responsePayload = jsonEncode([
        {
          'title': 'Test Article 1',
          'user': {
            'id': 'user1',
            'profile_image_url': 'https://example.com/image.png'
          },
          'created_at': '2021-01-01T00:00:00Z',
          'tags': [
            {'name': 'Flutter'},
            {'name': 'Dart'}
          ],
          'likes_count': 10,
          'url': 'https://example.com/article/1'
        },
        {
          'title': 'Test Article 2',
          'user': {
            'id': 'user1',
            'profile_image_url': 'https://example.com/image.png'
          },
          'created_at': '2021-01-02T00:00:00Z',
          'tags': [
            {'name': 'Flutter'},
            {'name': 'Dart'}
          ],
          'likes_count': 20,
          'url': 'https://example.com/article/2'
        }
      ]);

      when(mockQiitaClient.get('items', {'query': keyword}))
          .thenAnswer((_) async => http.Response(responsePayload, 200));

      final articles = await qiitaRepository.searchArticles(keyword);

      expect(articles, isA<List<Article>>());
      expect(articles.length, 2);
      expect(articles[0].title, 'Test Article 1');
      expect(articles[1].title, 'Test Article 2');
    });

    test('API通信のstatusが200以外の場合、空のリストが返ること', () async {
      const keyword = 'flutter';

      when(mockQiitaClient.get('items', {'query': keyword}))
          .thenAnswer((_) async => http.Response('Error', 400));

      final articles = await qiitaRepository.searchArticles(keyword);

      expect(articles, isEmpty);
    });
  });
}
