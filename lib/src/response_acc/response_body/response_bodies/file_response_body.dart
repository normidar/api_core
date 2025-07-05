part of '../response_body.dart';

class FileResponseBody extends ResponseBody {
  const FileResponseBody(this.bytes, {this.fileName});
  final Uint8List bytes;

  final String? fileName;

  /// 指定されたディレクトリに自動生成されたファイル名でファイルを保存します。
  ///
  /// [directory] - 保存先のディレクトリパス
  /// [prefix] - ファイル名の接頭辞（オプション）
  ///
  /// 戻り値：保存されたファイルのパス
  Future<String> saveToDirectory(
    String directory, {
    String prefix = '',
  }) async {
    final dir = Directory(directory);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }

    final filename =
        fileName ?? '$prefix${DateTime.now().millisecondsSinceEpoch}';
    final path = '$directory/$filename';

    return saveToFile(path);
  }

  /// 指定されたパスにファイルを保存します。
  ///
  /// [path] - 保存先のパス。ディレクトリパスの場合は、fileName（存在する場合）をファイル名として使用します。<br>
  /// [overwrite] - trueの場合、既存のファイルを上書きします。falseの場合、ファイルが存在していればエラーをスローします。
  ///
  /// 戻り値：保存されたファイルのパス
  Future<String> saveToFile(String path, {bool overwrite = false}) async {
    final targetPath = await _resolveTargetPath(path);
    final file = File(targetPath);

    if (file.existsSync() && !overwrite) {
      throw FileSystemException('ファイルが既に存在します', targetPath);
    }

    await file.writeAsBytes(bytes);
    return targetPath;
  }

  @override
  String toString() =>
      'FileResponseBody(bytes: ${bytes.length} bytes, fileName: $fileName)';

  Future<String> _resolveTargetPath(String path) async {
    final fileInfo = FileSystemEntity.typeSync(path);

    if (fileInfo == FileSystemEntityType.directory) {
      if (fileName == null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        return '$path/file_$timestamp';
      }
      return '$path/$fileName';
    }

    return path;
  }
}
