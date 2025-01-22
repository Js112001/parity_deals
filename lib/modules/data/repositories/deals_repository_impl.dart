import 'package:deals/modules/data/services/deals_service_provider.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:logger/logger.dart';

class DealsRepoImpl extends DealsRepository {
  final DealsServiceProvider _dealsServiceProvider;

  DealsRepoImpl(this._dealsServiceProvider);

  @override
  Future<List<DealEntity>> getFeaturedDeals() async {
    final response = await _dealsServiceProvider.getFeaturedDeals();

    Logger().i('[Response]: ${response?.deals}');
    if (response != null) {
      if (response.deals != null && response.deals!.isEmpty) {
        return  [
          DealEntity.fromJson({
            "statusCode": response.statusCode,
            "message": response.message
          })
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

  @override
  Future<void> getPopularDeals() async {
    await _dealsServiceProvider.getPopularDeals();
  }

  @override
  Future<void> getTopDeals() async {
    await _dealsServiceProvider.getTopDeals();
  }
}
