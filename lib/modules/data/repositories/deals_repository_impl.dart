import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:deals/modules/data/services/deals_service_provider.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';

class DealsRepoImpl extends DealsRepository {
  final DealsServiceProvider _dealsServiceProvider;

  DealsRepoImpl(this._dealsServiceProvider);

  @override
  Future<List<DealEntity>> getFeaturedDeals({int page = 1}) async {
    final response = await _dealsServiceProvider.getFeaturedDeals(page: page);

    return _formatResponse(response: response);
  }

  @override
  Future<List<DealEntity>> getPopularDeals({int page = 1}) async {
    final response = await _dealsServiceProvider.getPopularDeals(page: page);

    return _formatResponse(response: response);
  }

  @override
  Future<List<DealEntity>> getTopDeals({int page = 1}) async {
    final response = await _dealsServiceProvider.getTopDeals(page: page);

    return _formatResponse(response: response);
  }

  static List<DealEntity> _formatResponse({StoreApiResponseModel? response}) {
    if (response != null) {
      if (response.deals != null && response.deals!.isEmpty) {
        return [
          DealEntity.fromJson(
              {"statusCode": response.statusCode, "message": response.message})
        ];
      }
      return response.deals
              ?.map(
                (e) => DealEntity.toEntity(e),
              )
              .toList() ??
          [
            DealEntity.fromJson({
              "statusCode": response.statusCode,
              "message": response.message
            })
          ];
    } else {
      return [
        DealEntity.fromJson(
            {"statusCode": response?.statusCode, "message": response?.message})
      ];
    }
  }
}
