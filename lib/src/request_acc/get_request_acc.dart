import 'package:api_http/api_http.dart';
import 'package:meta/meta.dart';

@immutable
class GetRequestAcc extends RequestAcc {
  const GetRequestAcc({
    required this.url,
    RestHeaders? headers,
    this.queryParameters,
  }) : _headers = headers;

  factory GetRequestAcc.fromJson(Map<String, dynamic> json) => GetRequestAcc(
        url: json['url'] as String,
        headers: RestHeaders.fromJson(json['headers'] as Map<String, String>),
        queryParameters: json['queryParameters'] as Map<String, String>?,
      );

  final String url;

  final RestHeaders? _headers;

  final Map<String, String>? queryParameters;

  @override
  int get hashCode => Object.hashAll([url, headers, queryParameters]);

  RestHeaders? get headers {
    if (_headers == null) return null;
    return _headers;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GetRequestAcc &&
          other.url == url &&
          other.headers == headers &&
          (other.queryParameters ?? {}) == (queryParameters ?? {}));

  GetRequestAcc copyWith({
    RestHeaders? headers,
    Map<String, String>? queryParameters,
  }) =>
      GetRequestAcc(
        url: url,
        headers: headers ?? this.headers,
        queryParameters: queryParameters ?? this.queryParameters,
      );

  @override
  String toCurlCommand() {
    final queries = queryParameters?.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
    final finalUrl = queries != null ? '$url?$queries' : url;

    final headerStrings = <String>[];

    // Add custom headers
    if (headers != null) {
      headerStrings.addAll(
        headers!.headers.entries.map((e) => '-H "${e.key}: ${e.value}"'),
      );
    }

    final command = [
      'curl "$finalUrl"',
      ...headerStrings,
      '-X GET',
    ];

    return command.join(' \\\n  ');
  }

  @override
  Map<String, dynamic> toJson() => {
        'url': url,
        'headers': headers?.toJson(),
        'queryParameters': queryParameters,
      };

  @override
  String toString() => 'GetRequestAcc(url: $url, headers: $headers,'
      ' queryParameters: $queryParameters)';
}
