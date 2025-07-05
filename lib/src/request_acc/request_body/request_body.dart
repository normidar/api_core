import 'dart:convert' show base64Decode, base64Encode;
import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:api_core/api_core.dart';

part 'binary_request_body/binary_request_body.dart';
part 'json_request_body/json_request_body.dart';
part 'multipart_request_body/multipart_request_body.dart';

sealed class RequestBody {
  const RequestBody();

  factory RequestBody.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'json':
        return JsonRequestBody.fromJson(json);
      case 'multipart':
        return MultipartRequestBody.fromJson(json);
      case 'binary':
        return BinaryRequestBody.fromJson(json);
      default:
        throw ArgumentError('Invalid request body type: ${json['type']}');
    }
  }

  Map<String, String> get styleHeaders;

  String contentType();

  Map<String, dynamic> toJson();
}
