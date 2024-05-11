import 'dart:convert';

import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:qiita_viewer/apis/qiita_client.dart';
import 'package:qiita_viewer/models/article.dart';

import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<QiitaRepository>()])
class QiitaRepository {
  static var client = QiitaClient();
  Future<List<Article>> searchArticles(String keyword) async {
    final http.Response res = await client.get("items", {
      'query': keyword,
    });

    if (res.statusCode == 200) {
      // レスポンスをモデルクラスへ変換
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
