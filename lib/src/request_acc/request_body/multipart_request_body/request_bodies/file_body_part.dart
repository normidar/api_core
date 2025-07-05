part of '../body_part.dart';

class FileBodyPart extends BodyPart {
  const FileBodyPart({
    required this.file,
    required this.fieldName,
    this.fileName,
  });

  factory FileBodyPart.fromJson(Map<String, dynamic> json) => FileBodyPart(
        file: File(json['file'] as String),
        fieldName: json['fieldName'] as String,
        fileName: json['fileName'] as String?,
      );

  final String fieldName;

  final File file;

  final String? fileName;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'file',
        'file': file.path,
        'fieldName': fieldName,
        'fileName': fileName,
      };
}
