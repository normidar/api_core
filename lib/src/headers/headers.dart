import 'dart:collection';

import 'package:meta/meta.dart';

typedef HeadersPipe = RestHeaders Function(RestHeaders headers);

enum ContentType {
  json,
  html,
  binary,
  text,
  multipart,
  image,
  other;

  static ContentType fromString(String contentType) {
    if (contentType.contains('application/json')) return ContentType.json;
    if (contentType.contains('text/html')) return ContentType.html;
    if (contentType.contains('application/octet-stream')) {
      return ContentType.binary;
    }
    if (contentType.contains('text/plain')) return ContentType.text;
    if (contentType.contains('multipart/form-data')) {
      return ContentType.multipart;
    }
    if (contentType.contains('image/')) {
      return ContentType.image;
    }
    return ContentType.other;
  }
}

/// REST APIのヘッダーを管理するクラス
@immutable
class RestHeaders {
  const RestHeaders(
    Map<String, String> headers,
  ) : _headers = headers;

  RestHeaders.empty() : _headers = <String, String>{};

  factory RestHeaders.fromJson(Map<String, String> json) => RestHeaders(json);

  final Map<String, String> _headers;

  ContentType? get contentType {
    final contentType = _headers['Content-Type'] ?? _headers['content-type'];
    if (contentType == null) return null;
    return ContentType.fromString(contentType);
  }

  @override
  int get hashCode => headers.entries.fold(
        0,
        (hash, entry) => hash ^ entry.key.hashCode ^ entry.value.hashCode,
      );

  UnmodifiableMapView<String, String> get headers =>
      UnmodifiableMapView(_headers);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RestHeaders) return false;

    final Map<String, String> thisMap = headers;
    final Map<String, String> otherMap = other.headers;

    if (thisMap.length != otherMap.length) return false;

    for (final entry in thisMap.entries) {
      if (!otherMap.containsKey(entry.key) ||
          otherMap[entry.key] != entry.value) {
        return false;
      }
    }

    return true;
  }

  /// ヘッダーの値を取得するための[]演算子
  String? operator [](String key) => _headers[key];

  RestHeaders addBeNew(String key, String value) => RestHeaders(
        {..._headers, key: value},
      );

  RestHeaders copyWith({Map<String, String>? headers}) => RestHeaders(
        headers ?? this.headers,
      );

  RestHeaders copyWithContentType(String contentType) =>
      copyWith(headers: {..._headers, 'Content-Type': contentType});

  Map<String, String> toJson() => _headers;

  @override
  String toString() => headers.toString();
}
