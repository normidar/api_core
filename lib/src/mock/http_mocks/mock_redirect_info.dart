import 'dart:io';

class MockRedirectInfo implements RedirectInfo {
  MockRedirectInfo({
    required this.statusCode,
    required this.method,
    required this.location,
  });

  factory MockRedirectInfo.fromJson(Map<String, dynamic> json) =>
      MockRedirectInfo(
        statusCode: json['statusCode'] as int,
        method: json['method'] as String,
        location: Uri.parse(json['location'] as String),
      );

  factory MockRedirectInfo.makeMock(RedirectInfo redirectInfo) =>
      MockRedirectInfo(
        statusCode: redirectInfo.statusCode,
        method: redirectInfo.method,
        location: redirectInfo.location,
      );

  @override
  final int statusCode;

  @override
  final String method;

  @override
  final Uri location;

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'method': method,
        'location': location.toString(),
      };
}
