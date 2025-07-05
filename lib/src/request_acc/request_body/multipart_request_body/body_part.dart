import 'dart:io' show File;

part 'request_bodies/fields_body_part.dart';
part 'request_bodies/file_body_part.dart';

sealed class BodyPart {
  const BodyPart();

  Map<String, dynamic> toJson();

  static BodyPart fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'json':
        return FieldsBodyPart.fromJson(json);
      case 'file':
        return FileBodyPart.fromJson(json);
      default:
        throw ArgumentError('Invalid request body type: ${json['type']}');
    }
  }
}
