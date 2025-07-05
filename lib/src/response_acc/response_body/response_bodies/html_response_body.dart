part of '../response_body.dart';

class HtmlResponseBody extends ResponseBody {
  const HtmlResponseBody(this.html);

  final String html;

  @override
  String toString() => html;
}
