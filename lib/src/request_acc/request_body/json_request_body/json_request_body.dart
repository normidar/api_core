part of '../request_body.dart';

class JsonRequestBody extends RequestBody {
  const JsonRequestBody(this.json);

  factory JsonRequestBody.fromJson(Map<String, dynamic> json) =>
      JsonRequestBody((json['json'] as Map).cast<String, String>());

  final Map<String, dynamic> json;

  @override
  Map<String, String> get styleHeaders => {
        'Content-Type': theContentType,
      };

  @override
  String contentType() => theContentType;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'json',
        'json': json,
      };

  static const String theContentType = 'application/json';
}
