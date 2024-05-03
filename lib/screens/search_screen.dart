import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_viewer/controllers/progress_controller.dart';
import 'package:qiita_viewer/models/article.dart';
import 'package:qiita_viewer/widgets/articles_container.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Article> articles = []; // 検索結果を格納する変数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          // 検索ボックス
          Padding(
            // ← Paddingで囲む
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                // ← TextStyleを渡す
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                // ← InputDecorationを渡す
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                ref.read(progressController.notifier).excuteWithProgress(
                  () async {
                    // 検索結果を取得
                    final results = await searchQiita(value);
                    // 状態を更新
                    setState(
                      () {
                        articles = results;
                      },
                    );
                  },
                );
              },
            ),
          ),

          Expanded(
            child: ListView(
              children: articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(),
            ),
          ),
          // 検索結果一覧
        ],
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
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
