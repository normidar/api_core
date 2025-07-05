part of '../request_body.dart';

class MultipartRequestBody extends RequestBody {
  const MultipartRequestBody(this.bodyParts);

  factory MultipartRequestBody.fromJson(Map<String, dynamic> json) =>
      MultipartRequestBody(
        (json['bodyParts'] as List)
            .map((e) => BodyPart.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  static const String theContentType = 'multipart/form-data';

  final List<BodyPart> bodyParts;

  @override
  Map<String, String> get styleHeaders => {
        'Content-Type': theContentType,
      };

  @override
  String contentType() => theContentType;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'multipart',
        'bodyParts': bodyParts.map((e) => e.toJson()).toList(),
      };
}
