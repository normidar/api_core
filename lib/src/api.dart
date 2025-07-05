import 'package:api_http/api_http.dart';

class Api {
  static Future<ResponseAcc> delete({
    required PostRequestAcc requestAcc,
  }) async =>
      DeleteMethod.delete(
        requestAcc: requestAcc,
      );

  static Future<ResponseAcc> get({
    required GetRequestAcc requestAcc,
  }) async =>
      GetMethod.get(
        requestAcc: requestAcc,
      );

  static Future<ResponseAcc> post({
    required PostRequestAcc requestAcc,
  }) async =>
      PostMethod.post(
        requestAcc: requestAcc,
      );

  static Future<ResponseAcc> put({
    required PostRequestAcc requestAcc,
  }) async =>
      PutMethod.put(
        requestAcc: requestAcc,
      );
}
