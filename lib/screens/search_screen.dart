import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_viewer/apis/qiita_repository.dart';
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
                    final results = await searchQiitaArticles(value);
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

  Future<List<Article>> searchQiitaArticles(String keyword) async {
    final repository = QiitaRepository();
    return await repository.searchArticles(keyword);
  }
}
