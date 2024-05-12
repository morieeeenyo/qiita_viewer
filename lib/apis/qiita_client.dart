import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<QiitaClient>()])
class QiitaClient {
  static const String apiHost = 'qiita.com';
  static const String apiBasePath = '/api/v2';
  static final token = dotenv.get('QIITA_ACCESS_TOKEN');

  Future<http.Response> get(
      String path, Map<String, dynamic> queryParameters) async {
    final uri = Uri.https(apiHost, '$apiBasePath/$path', queryParameters);

    return await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });
  }
}
