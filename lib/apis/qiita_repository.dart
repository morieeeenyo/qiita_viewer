import 'dart:convert';

import 'package:qiita_viewer/models/article.dart';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mockito/annotations.dart';
@GenerateNiceMocks([MockSpec<QiitaRepository>()])

class QiitaRepository {
  Future<List<Article>> searchArticles(String keyword) async {
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });

    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
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
