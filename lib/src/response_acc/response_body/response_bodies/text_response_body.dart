part of '../response_body.dart';

class TextResponseBody extends ResponseBody {
  const TextResponseBody(this.text);

  final String text;

  @override
  String toString() => text;
}
