import 'package:deals/modules/domain/entities/deal_entity.dart';

abstract class DealsRepository {
  Future<List<DealEntity>> getTopDeals({int page = 1});

  Future<List<DealEntity>> getFeaturedDeals({int page = 1});

  Future<List<DealEntity>> getPopularDeals({int page = 1});
}
