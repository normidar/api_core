part of '../response_body.dart';

class MapJsonResponseBody extends ResponseBody {
  const MapJsonResponseBody(this.data);

  final Map<String, dynamic> data;

  @override
  String toString() {
    return jsonEncode(data);
  }
}
