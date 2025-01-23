import 'package:deals/app.dart';
import 'package:deals/core/di/injection_container.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/entities/store_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DealEntityAdapter());
  Hive.registerAdapter(StoreEntityAdapter());
  await dotenv.load();
  await initializeDependencies();
  runApp(const App());
}
