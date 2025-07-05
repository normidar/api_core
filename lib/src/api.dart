import 'package:api_core/api_core.dart';

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
