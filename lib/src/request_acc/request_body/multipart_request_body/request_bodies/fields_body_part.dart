part of '../body_part.dart';

class FieldsBodyPart extends BodyPart {
  const FieldsBodyPart(this.json);

  factory FieldsBodyPart.fromJson(Map<String, dynamic> json) =>
      FieldsBodyPart((json['json'] as Map).cast<String, String>());

  final Map<String, String> json;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'json',
        'json': json,
      };
}
