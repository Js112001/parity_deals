import 'package:deals/app.dart';
import 'package:deals/core/di/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}
