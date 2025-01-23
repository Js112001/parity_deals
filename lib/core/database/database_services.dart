import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/utils/enums.dart';

abstract class DatabaseServices {
  Future<void> saveDeals(List<DealEntity> deals, DealTypes dealType);
  Future<List<DealEntity>> fetchDeals(DealTypes dealType);
  Future<void> clearDeals(DealTypes dealType);
}