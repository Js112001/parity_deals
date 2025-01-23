import 'package:deals/core/network/base_network.dart';
import 'package:deals/modules/data/repositories/deals_repository_impl.dart';
import 'package:deals/modules/data/services/deals_service_provider.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:deals/modules/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // dio
  sl.registerSingleton<Dio>(Dio());

  // base network
  sl.registerSingleton<BaseNetwork>(BaseNetwork(sl()));

  // dependencies
  sl.registerSingleton<DealsServiceProvider>(DealsServiceProviderImpl(sl()));
  sl.registerSingleton<DealsRepository>(DealsRepoImpl(sl()));

  // bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()),);
}