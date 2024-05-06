import 'package:flutter_test/flutter_test.dart';
import 'package:qiita_viewer/models/user.dart';

void main() {
  group("User", () {
    test("fromJson関数でjsonをUser型に変換できること", () {
      final json = {
        'id': 'user_id',
        'profile_image_url': 'https://example.com/image.png',
      };
      final article = User.fromJson(json);
      expect(article.id, 'user_id');
      expect(article.profileImageUrl, 'https://example.com/image.png');
    });
  });
}
