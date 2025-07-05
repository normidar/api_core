import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

part 'response_bodies/file_response_body.dart';
part 'response_bodies/html_response_body.dart';
part 'response_bodies/list_json_response_body.dart';
part 'response_bodies/map_json_response_body.dart';
part 'response_bodies/text_response_body.dart';

sealed class ResponseBody {
  const ResponseBody();

  MapJsonResponseBody asMapJsonResponseBody() => this as MapJsonResponseBody;
}
