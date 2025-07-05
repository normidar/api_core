import 'dart:io';
import 'dart:typed_data';

import 'package:api_core/api_core.dart';
import 'package:http/http.dart' as http;

class DeleteMockUnit {
  DeleteMockUnit({
    required this.requestAcc,
    required this.response,
  });
  factory DeleteMockUnit.fromJson(Map<String, dynamic> json) => DeleteMockUnit(
        requestAcc: PostRequestAcc.fromJson(
          json['requestAcc'] as Map<String, dynamic>,
        ),
        response: MockHttpClientResponse.fromJson(
          json['response'] as Map<String, dynamic>,
        ),
      );

  final PostRequestAcc requestAcc;

  final MockHttpClientResponse response;

  Map<String, dynamic> toJson() => {
        'requestAcc': requestAcc.toJson(),
        'response': response.toJson(),
      };

  static Future<DeleteMockUnit> makeMock({
    required PostRequestAcc requestAcc,
    required dynamic response,
  }) async {
    if (response is HttpClientResponse) {
      return DeleteMockUnit(
        requestAcc: requestAcc,
        response: await MockHttpClientResponse.makeMock(response),
      );
    } else if (response is http.Response) {
      // httpパッケージのResponseからMockHttpClientResponseを作成する処理
      final mockResponse = MockHttpClientResponse(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase ?? '',
        chunks: [Uint8List.fromList(response.bodyBytes)],
        headers: MockHttpHeaders(
          headers: _convertHttpResponseHeaders(response.headers),
        ),
      );

      return DeleteMockUnit(
        requestAcc: requestAcc,
        response: mockResponse,
      );
    } else {
      throw ArgumentError('Unsupported response type: ${response.runtimeType}');
    }
  }

  // httpパッケージのヘッダーをMockHttpHeadersで使用できる形式に変換
  static Map<String, List<String>> _convertHttpResponseHeaders(
    Map<String, String> headers,
  ) {
    final result = <String, List<String>>{};
    headers.forEach((key, value) {
      result[key.toLowerCase()] = [value];
    });
    return result;
  }
}

class GetMockUnit {
  GetMockUnit({
    required this.requestAcc,
    required this.response,
  });
  factory GetMockUnit.fromJson(Map<String, dynamic> json) => GetMockUnit(
        requestAcc:
            GetRequestAcc.fromJson(json['requestAcc'] as Map<String, dynamic>),
        response: MockHttpClientResponse.fromJson(
          json['response'] as Map<String, dynamic>,
        ),
      );

  final GetRequestAcc requestAcc;

  final MockHttpClientResponse response;

  Map<String, dynamic> toJson() => {
        'requestAcc': requestAcc.toJson(),
        'response': response.toJson(),
      };

  static Future<GetMockUnit> makeMock({
    required GetRequestAcc requestAcc,
    required dynamic response,
  }) async {
    if (response is HttpClientResponse) {
      return GetMockUnit(
        requestAcc: requestAcc,
        response: await MockHttpClientResponse.makeMock(response),
      );
    } else if (response is http.Response) {
      // httpパッケージのResponseからMockHttpClientResponseを作成する処理
      final mockResponse = MockHttpClientResponse(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase ?? '',
        chunks: [Uint8List.fromList(response.bodyBytes)],
        headers: MockHttpHeaders(
          headers: _convertHttpResponseHeaders(response.headers),
        ),
      );

      return GetMockUnit(
        requestAcc: requestAcc,
        response: mockResponse,
      );
    } else {
      throw ArgumentError('Unsupported response type: ${response.runtimeType}');
    }
  }

  // httpパッケージのヘッダーをMockHttpHeadersで使用できる形式に変換
  static Map<String, List<String>> _convertHttpResponseHeaders(
    Map<String, String> headers,
  ) {
    final result = <String, List<String>>{};
    headers.forEach((key, value) {
      result[key.toLowerCase()] = [value];
    });
    return result;
  }
}

class HeadMockUnit {
  HeadMockUnit({
    required this.requestAcc,
    required this.response,
  });
  factory HeadMockUnit.fromJson(Map<String, dynamic> json) => HeadMockUnit(
        requestAcc: GetRequestAcc.fromJson(
          json['requestAcc'] as Map<String, dynamic>,
        ),
        response: MockHttpClientResponse.fromJson(
          json['response'] as Map<String, dynamic>,
        ),
      );

  final GetRequestAcc requestAcc;

  final MockHttpClientResponse response;

  Map<String, dynamic> toJson() => {
        'requestAcc': requestAcc.toJson(),
        'response': response.toJson(),
      };

  static Future<HeadMockUnit> makeMock({
    required GetRequestAcc requestAcc,
    required dynamic response,
  }) async {
    if (response is HttpClientResponse) {
      return HeadMockUnit(
        requestAcc: requestAcc,
        response: await MockHttpClientResponse.makeMock(response),
      );
    } else if (response is http.Response) {
      // httpパッケージのResponseからMockHttpClientResponseを作成する処理
      final mockResponse = MockHttpClientResponse(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase ?? '',
        chunks: [Uint8List.fromList(response.bodyBytes)],
        headers: MockHttpHeaders(
          headers: _convertHttpResponseHeaders(response.headers),
        ),
      );

      return HeadMockUnit(
        requestAcc: requestAcc,
        response: mockResponse,
      );
    } else {
      throw ArgumentError('Unsupported response type: ${response.runtimeType}');
    }
  }

  // httpパッケージのヘッダーをMockHttpHeadersで使用できる形式に変換
  static Map<String, List<String>> _convertHttpResponseHeaders(
    Map<String, String> headers,
  ) {
    final result = <String, List<String>>{};
    headers.forEach((key, value) {
      result[key.toLowerCase()] = [value];
    });
    return result;
  }
}

class PutMockUnit {
  PutMockUnit({
    required this.requestAcc,
    required this.response,
  });
  factory PutMockUnit.fromJson(Map<String, dynamic> json) => PutMockUnit(
        requestAcc: PostRequestAcc.fromJson(
          json['requestAcc'] as Map<String, dynamic>,
        ),
        response: MockHttpClientResponse.fromJson(
          json['response'] as Map<String, dynamic>,
        ),
      );

  final PostRequestAcc requestAcc;

  final MockHttpClientResponse response;

  Map<String, dynamic> toJson() => {
        'requestAcc': requestAcc.toJson(),
        'response': response.toJson(),
      };

  static Future<PutMockUnit> makeMock({
    required PostRequestAcc requestAcc,
    required dynamic response,
  }) async {
    if (response is HttpClientResponse) {
      return PutMockUnit(
        requestAcc: requestAcc,
        response: await MockHttpClientResponse.makeMock(response),
      );
    } else if (response is http.Response) {
      // httpパッケージのResponseからMockHttpClientResponseを作成する処理
      final mockResponse = MockHttpClientResponse(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase ?? '',
        chunks: [Uint8List.fromList(response.bodyBytes)],
        headers: MockHttpHeaders(
          headers: _convertHttpResponseHeaders(response.headers),
        ),
      );

      return PutMockUnit(
        requestAcc: requestAcc,
        response: mockResponse,
      );
    } else {
      throw ArgumentError('Unsupported response type: ${response.runtimeType}');
    }
  }

  // httpパッケージのヘッダーをMockHttpHeadersで使用できる形式に変換
  static Map<String, List<String>> _convertHttpResponseHeaders(
    Map<String, String> headers,
  ) {
    final result = <String, List<String>>{};
    headers.forEach((key, value) {
      result[key.toLowerCase()] = [value];
    });
    return result;
  }
}
