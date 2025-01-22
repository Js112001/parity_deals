part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class GetTopDealsEvent extends HomeEvent {
  final int page;

  GetTopDealsEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class GetFeaturedDealsEvent extends HomeEvent {
  final int page;

  GetFeaturedDealsEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class GetPopularDealsEvent extends HomeEvent {
  final int page;

  GetPopularDealsEvent(this.page);

  @override
  List<Object?> get props => [page];
}

