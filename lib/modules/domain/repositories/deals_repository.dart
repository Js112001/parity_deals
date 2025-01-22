import 'package:deals/modules/domain/entities/deal_entity.dart';

abstract class DealsRepository {
  Future<void> getTopDeals();
  Future<List<DealEntity>> getFeaturedDeals();
  Future<void> getPopularDeals();
}