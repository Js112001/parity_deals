import 'package:deals/core/database/database_services.dart';
import 'package:deals/core/network/network_service.dart';
import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:deals/modules/data/services/deals_service_provider.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:deals/utils/enums.dart';

class DealsRepoImpl extends DealsRepository {
  final DealsServiceProvider _dealsServiceProvider;
  final DatabaseServices _databaseServices;
  final NetworkService _networkService;

  DealsRepoImpl(
    this._dealsServiceProvider,
    this._databaseServices,
    this._networkService,
  );

  @override
  Future<List<DealEntity>> getFeaturedDeals({int page = 1}) async {
    if (await _networkService.isConnected()) {
      final response = await _dealsServiceProvider.getFeaturedDeals(page: page);
      final deals = _formatResponse(response: response);
      _databaseServices.saveDeals(deals, DealTypes.featured);
      return deals;
    } else {
      if (page == 1) {
        return await _databaseServices.fetchDeals(DealTypes.featured);
      } else {
        return [];
      }
    }
  }

  @override
  Future<List<DealEntity>> getPopularDeals({int page = 1}) async {
    if (await _networkService.isConnected()) {
      final response = await _dealsServiceProvider.getPopularDeals(page: page);
      final deals = _formatResponse(response: response);
      _databaseServices.saveDeals(deals, DealTypes.popular);
      return deals;
    } else {
      if (page == 1) {
        return await _databaseServices.fetchDeals(DealTypes.popular);
      } else {
        return [];
      }
    }
  }

  @override
  Future<List<DealEntity>> getTopDeals({int page = 1}) async {
    if (await _networkService.isConnected()) {
      final response = await _dealsServiceProvider.getTopDeals(page: page);
      final deals = _formatResponse(response: response);
      _databaseServices.saveDeals(deals, DealTypes.top);
      return deals;
    } else {
      if (page == 1) {
        return await _databaseServices.fetchDeals(DealTypes.top);
      } else {
        return [];
      }
    }
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
