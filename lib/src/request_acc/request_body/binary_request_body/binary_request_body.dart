part of '../request_body.dart';

class BinaryRequestBody extends RequestBody {
  const BinaryRequestBody(this.binary);

  factory BinaryRequestBody.fromFile(File file) =>
      BinaryRequestBody(file.readAsBytesSync());

  factory BinaryRequestBody.fromJson(Map<String, dynamic> json) =>
      BinaryRequestBody(base64Decode(json['binary'] as String));

  final Uint8List binary;

  @override
  String contentType() => theContentType;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'binary',
        'binary': base64Encode(binary),
      };

  static Future<BinaryRequestBody> fromFileAsync(File file) async =>
      BinaryRequestBody(await file.readAsBytes());

  static const String theContentType = 'application/octet-stream';

  @override
  Map<String, String> get styleHeaders => {
        'Content-Type': theContentType,
        'Content-Length': '${binary.length}',
      };
}
