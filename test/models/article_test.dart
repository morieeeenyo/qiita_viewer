import 'package:flutter_test/flutter_test.dart';
import 'package:qiita_viewer/models/article.dart';

void main() {
  group("Article", () {
    test("fromJson関数でjsonをArticle型に変換できること", () {
      final json = {
        'title': 'タイトル',
        'user': {
          'id': 'user_id',
          'name': 'ユーザー名',
          'profile_image_url': 'https://example.com/image.png',
        },
        'url': 'https://example.com/article',
        'created_at': '2021-01-01T00:00:00Z',
        'likes_count': 10,
        'tags': [
          {'name': 'タグ1'},
          {'name': 'タグ2'},
        ],
      };
      final article = Article.fromJson(json);
      expect(article.title, 'タイトル');
      expect(article.user.id, 'user_id');
      expect(article.user.profileImageUrl, 'https://example.com/image.png');
      expect(article.url, 'https://example.com/article');
      expect(article.createdAt, DateTime.parse('2021-01-01T00:00:00Z'));
      expect(article.likesCount, 10);
      expect(article.tags, ['タグ1', 'タグ2']);
    });
  });
}
