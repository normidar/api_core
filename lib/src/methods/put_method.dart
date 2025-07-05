import 'dart:async';

import 'package:api_core/api_core.dart';
import 'package:http/http.dart' as http;

class PutMethod {
  static Future<ResponseAcc> put({
    required PostRequestAcc requestAcc,
  }) async {
    // タイムアウト付きのクライアントを作成
    final client = http.Client();
    try {
      // JSONリクエストを送信
      return await MethodUtils.sendPost(
        method: 'PUT',
        requestAcc: requestAcc,
        client: client,
      ).timeout(
        const Duration(seconds: MethodUtils.requestTimeout),
        onTimeout: () => throw TimeoutException(
          'Request timeout',
        ),
      );
    } finally {
      client.close();
    }
  }
}
