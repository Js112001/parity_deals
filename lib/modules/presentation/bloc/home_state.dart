part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends HomeState {
  final List<DealEntity> deals;
  final bool isPaginated;

  SuccessState({required this.deals, this.isPaginated = false});

  @override
  List<Object?> get props => [deals, isPaginated];
}

class ErrorState extends HomeState {
  final int statusCode;
  final String message;

  ErrorState({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}
