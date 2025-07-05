import 'dart:async';

import 'package:api_http/api_http.dart';
import 'package:http/http.dart' as http;

class HeadMethod {
  static Future<bool> head({
    required GetRequestAcc requestAcc,
  }) async {
    // タイムアウト付きのクライアントを作成
    final client = http.Client();
    try {
      // JSONリクエストを送信
      return await MethodUtils.sendHead(
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
