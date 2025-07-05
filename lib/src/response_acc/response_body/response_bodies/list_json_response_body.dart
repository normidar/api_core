part of '../response_body.dart';

class ListJsonResponseBody extends ResponseBody {
  const ListJsonResponseBody(this.data);

  factory ListJsonResponseBody.fromString(String jsonString) {
    final data = jsonDecode(jsonString) as List<dynamic>;
    return ListJsonResponseBody(data);
  }

  final List<dynamic> data;
}
