import 'package:bloc/bloc.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DealsRepository _dealsRepository;

  HomeBloc(this._dealsRepository) : super(InitialState()) {
    on<GetTopDealsEvent>(_onGetTopDealsEvent);
    on<GetFeaturedDealsEvent>(_onGetFeaturedDealsEvent);
    on<GetPopularDealsEvent>(_onGetPopularDealsEvent);
  }

  void _onGetTopDealsEvent(
      GetTopDealsEvent event, Emitter<HomeState> emit) async {
    final result = await _dealsRepository.getTopDeals();
  }

  void _onGetFeaturedDealsEvent(
      GetFeaturedDealsEvent event, Emitter<HomeState> emit) async {
    final result = await _dealsRepository.getFeaturedDeals();

    Logger().i('[Result]: $result');
    if (result.first.id == null) {
      emit(ErrorState(
          statusCode: result.first.statusCode!,
          message: result.first.message!));
    } else {
      emit(SuccessState(deals: result));
    }
  }

  void _onGetPopularDealsEvent(
      GetPopularDealsEvent event, Emitter<HomeState> emit) async {
    final result = await _dealsRepository.getPopularDeals();
  }
}
