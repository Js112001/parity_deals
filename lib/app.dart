import 'package:deals/core/di/injection_container.dart';
import 'package:deals/modules/presentation/bloc/home_bloc.dart';
import 'package:deals/modules/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => sl(),
          ),
        ],
        child: const HomeView(
          title: 'Flutter Demo Home Page',
          tabs: ['Top', 'Popular', 'Featured'],
        ),
      ),
    );
  }
}
