import 'package:deals/core/database/database_services.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/utils/enums.dart';
import 'package:hive/hive.dart';

class HiveStorageServices extends DatabaseServices {
  static const String _boxName = 'dealsBox';

  @override
  Future<void> saveDeals(List<DealEntity> deals, DealTypes dealType) async {
    final box = await Hive.openBox<DealEntity>('$dealType-$_boxName');
    await box.clear();
    await box.addAll(deals);
  }

  @override
  Future<List<DealEntity>> fetchDeals(DealTypes dealType) async {
    final box = await Hive.openBox<DealEntity>('$dealType-$_boxName');
    return box.values.toList();
  }

  @override
  Future<void> clearDeals(DealTypes dealType) async {
    final box = await Hive.openBox<DealEntity>('$dealType-$_boxName');
    await box.clear();
  }
}
