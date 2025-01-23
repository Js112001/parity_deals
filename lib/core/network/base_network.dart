import 'dart:io';

import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:deals/utils/custom_logger.dart';
import 'package:deals/utils/strings.dart';
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

      if (response.statusCode == HttpStatus.ok) {
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
            "statusCode": error.response?.statusCode ?? HttpStatus.badGateway,
            "message": error.message ?? StringConstants.badCertificateMessage,
          });
        case DioExceptionType.connectionTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ??
                HttpStatus.networkConnectTimeoutError,
            "message":
                error.message ?? StringConstants.connectionTimeoutMessage,
          });
        case DioExceptionType.sendTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode":
                error.response?.statusCode ?? HttpStatus.requestTimeout,
            "message": error.message ?? StringConstants.sendTimeoutMessage,
          });
        case DioExceptionType.receiveTimeout:
          return StoreApiResponseModel.fromJson({
            "statusCode":
                error.response?.statusCode ?? HttpStatus.requestTimeout,
            "message": error.message ?? StringConstants.receiveTimeoutMessage,
          });
        case DioExceptionType.badResponse:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ?? HttpStatus.badRequest,
            "message": error.message ?? StringConstants.badResponseMessage,
          });
        case DioExceptionType.cancel:
          return StoreApiResponseModel.fromJson({
            "statusCode":
                error.response?.statusCode ?? HttpStatus.internalServerError,
            "message": error.message ?? StringConstants.cancelRequestMessage,
          });
        case DioExceptionType.connectionError:
          return StoreApiResponseModel.fromJson({
            "statusCode": error.response?.statusCode ??
                HttpStatus.connectionClosedWithoutResponse,
            "message": error.message ?? StringConstants.connectionErrorMessage,
          });
        case DioExceptionType.unknown:
          return StoreApiResponseModel.fromJson({
            "statusCode":
                error.response?.statusCode ?? HttpStatus.internalServerError,
            "message": error.message ?? StringConstants.unknownErrorMessage,
          });
      }
    } catch (e) {
      return StoreApiResponseModel.fromJson({
        "statusCode": HttpStatus.internalServerError,
        "message": "Internal Error",
      });
    }
  }
}
