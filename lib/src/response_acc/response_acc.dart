import 'dart:convert';

import 'package:api_core/api_core.dart';
import 'package:http/http.dart' as http;

class ResponseAcc {
  ResponseAcc({
    required this.statusCode,
    required this.body,
    required this.headers,
  });

  final String statusCode;

  /// The body of the response.
  ///
  /// JsonResponseBody or HtmlResponseBody or FileResponseBody or
  /// ListJsonResponseBody or FileResponseBody or null.
  final ResponseBody? body;

  final RestHeaders headers;

  @override
  String toString() {
    return 'ResponseAcc(statusCode: $statusCode, '
        'body: $body, headers: $headers)';
  }

  static Future<ResponseAcc> fromStreamedResponse(
    http.StreamedResponse response,
  ) async {
    final bytes = await response.stream.toBytes();
    final headers = RestHeaders.fromJson(response.headers);
    final bodyInstance = switch (headers.contentType) {
      ContentType.json => _getInsFromJson(utf8.decode(bytes)),
      ContentType.html => HtmlResponseBody(utf8.decode(bytes)),
      ContentType.binary || ContentType.image => FileResponseBody(
          bytes,
          fileName: _extractFileName(headers.headers),
        ),
      ContentType.text => TextResponseBody(utf8.decode(bytes)),
      _ => null,
    };

    return ResponseAcc(
      statusCode: response.statusCode.toString(),
      body: bodyInstance,
      headers: RestHeaders.fromJson(response.headers),
    );
  }

  static String? _extractFileName(Map<String, String> headers) {
    final contentDisposition =
        headers['content-disposition'] ?? headers['Content-Disposition'];

    if (contentDisposition == null) return null;

    final regex = RegExp('filename="([^"]*)"');
    final match = regex.firstMatch(contentDisposition);
    return match?.group(1);
  }

  static ResponseBody _getInsFromJson(String json) {
    final data = jsonDecode(json);

    if (data is Map<String, dynamic>) {
      return MapJsonResponseBody(data);
    } else if (data is List<dynamic>) {
      return ListJsonResponseBody(data);
    } else {
      throw Exception('Invalid JSON: $json');
    }
  }
}
