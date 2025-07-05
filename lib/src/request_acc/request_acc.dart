abstract class RequestAcc {
  const RequestAcc();

  String toCurlCommand();

  Map<String, dynamic> toJson();
}
