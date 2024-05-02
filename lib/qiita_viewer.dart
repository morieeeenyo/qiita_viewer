import 'package:flutter/material.dart';

class QiitaView extends StatelessWidget {
  const QiitaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("記事一覧"),
        ),
        body: Center(
            child: TextButton(
                onPressed: () => {
                      Navigator.of(context).pop()
                      // 下記の書き方でも可
                      // Navigator.pushNamed(context, "/test2")
                    },
                child: const Text("戻る", style: TextStyle(fontSize: 25)))));
  }
}
