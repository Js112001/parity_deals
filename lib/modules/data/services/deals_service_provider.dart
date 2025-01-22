import 'dart:convert';

import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

abstract class DealsServiceProvider {
  Future<void> getTopDeals();

  Future<StoreApiResponseModel?> getFeaturedDeals();

  Future<void> getPopularDeals();
}

class DealsServiceProviderImpl extends DealsServiceProvider {
  final Dio _dio;

  DealsServiceProviderImpl(this._dio);

  @override
  Future<StoreApiResponseModel?> getFeaturedDeals() async {
    var headers = {'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'};
    try {
      var response = await _dio.request(
        'http://stagingauth.desidime.com/v4/home/new?per_page=10&page=1&fields=id, created_at,created_at_in_millis,image_medium,comments_count,store{name}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(json.encode(response.data));
        return StoreApiResponseModel.fromJson(response.data);
      } else {
        Logger().i(json.encode(response.statusMessage));
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

  @override
  Future<void> getPopularDeals() {
    // TODO: implement getPopularDeals
    throw UnimplementedError();
  }

  @override
  Future<void> getTopDeals() {
    // TODO: implement getTopDeals
    throw UnimplementedError();
  }
}
