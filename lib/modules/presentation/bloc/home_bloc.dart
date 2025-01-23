import 'package:bloc/bloc.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:deals/utils/custom_logger.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DealsRepository _dealsRepository;

  HomeBloc(this._dealsRepository) : super(InitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<GetTopDealsEvent>(_onGetTopDealsEvent);
    on<GetFeaturedDealsEvent>(_onGetFeaturedDealsEvent);
    on<GetPopularDealsEvent>(_onGetPopularDealsEvent);
  }

  void _onInitialEvent(InitialEvent event, Emitter<HomeState> emit) {
    emit(InitialState());
  }

  void _onGetTopDealsEvent(
      GetTopDealsEvent event, Emitter<HomeState> emit) async {
    final result = await _dealsRepository.getTopDeals();
    _emitResultState(result: result, emit: emit);
  }

  void _onGetFeaturedDealsEvent(
      GetFeaturedDealsEvent event, Emitter<HomeState> emit) async {
    emit(SuccessState(deals: [], isPaginated: true));
    final result = await _dealsRepository.getFeaturedDeals(page: event.page);

    _emitResultState(result: result, emit: emit);
  }

  void _onGetPopularDealsEvent(
      GetPopularDealsEvent event, Emitter<HomeState> emit) async {
    final result = await _dealsRepository.getPopularDeals(page: event.page);
    _emitResultState(result: result, emit: emit);
  }

  void _emitResultState(
      {required List<DealEntity> result, required Emitter<HomeState> emit}) {
    CustomLogger.i('[Result]: $result');
    if (result.first.id == null) {
      emit(ErrorState(
          statusCode: result.first.statusCode!,
          message: result.first.message!));
    } else {
      CustomLogger.i('[id]: ${result.first.id}');
      emit(SuccessState(deals: result, isPaginated: false));
    }
  }
}
