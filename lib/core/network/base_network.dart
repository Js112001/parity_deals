
import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:deals/utils/custom_logger.dart';
import 'package:dio/dio.dart';

class BaseNetwork {
  final Dio _dio;

  BaseNetwork(this._dio);

  Future<StoreApiResponseModel?> get({required String url}) async {
    CustomLogger.i('[url]: $url');
    var headers = {'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'};
    try {
      var response = await _dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return StoreApiResponseModel.fromJson(response.data);
      } else {
        return StoreApiResponseModel.fromJson({
          "statusCode": response.statusCode,
          "message": response.statusMessage
        });
      }
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badCertificate:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Bad Certificate Error',
          });
        case DioExceptionType.connectionTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Connection Timeout Error',
          });
        case DioExceptionType.sendTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Send Timeout Error',
          });
        case DioExceptionType.receiveTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Receive Timeout Error',
          });
        case DioExceptionType.badResponse:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Bad Response Error',
          });
        case DioExceptionType.cancel:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Request Cancel Error',
          });
        case DioExceptionType.connectionError:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Connection Error',
          });
        case DioExceptionType.unknown:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? 500,
            "message": error.message ?? 'Unknown Error',
          });
      }
    } catch (e) {
      return StoreApiResponseModel.fromJson({
        "statusCode": 500,
        "message": "Internal Error",
      });
    }
  }
}
