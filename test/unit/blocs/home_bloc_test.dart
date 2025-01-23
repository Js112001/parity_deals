import 'package:bloc_test/bloc_test.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/domain/repositories/deals_repository.dart';
import 'package:deals/modules/presentation/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockDealsRepository extends Mock implements DealsRepository {}

void main() {
  late MockDealsRepository mockDealsRepository;
  late HomeBloc homeBloc;

  setUp(() {
    mockDealsRepository = MockDealsRepository();
    homeBloc = HomeBloc(mockDealsRepository);
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc Tests', () {
    test('Initial state is InitialState', () {
      expect(homeBloc.state, equals(InitialState()));
    });

    blocTest<HomeBloc, HomeState>(
      'emits [InitialState] when InitialEvent is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [InitialState()],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [SuccessState] with top deals on GetTopDealsEvent',
      build: () {
        when(() => mockDealsRepository.getTopDeals())
            .thenAnswer((_) async => [DealEntity(id: 1)]);
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetTopDealsEvent(1)),
      expect: () => [
        isA<SuccessState>().having((state) => state.deals, 'deals', isNotEmpty),
      ],
      verify: (_) {
        verify(() => mockDealsRepository.getTopDeals()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [ErrorState] when GetFeaturedDealsEvent fails',
      build: () {
        when(() => mockDealsRepository.getFeaturedDeals(page: 1))
            .thenAnswer((_) async => [
          DealEntity(
              id: null, statusCode: 400, message: 'Bad Request')
        ]);
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetFeaturedDealsEvent(1)),
      expect: () => [
        SuccessState(deals: [], isPaginated: true),
        isA<ErrorState>()
            .having((state) => state.statusCode, 'statusCode', 400)
            .having((state) => state.message, 'message', 'Bad Request'),
      ],
      verify: (_) {
        verify(() => mockDealsRepository.getFeaturedDeals(page: 1)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [SuccessState] with popular deals on GetPopularDealsEvent',
      build: () {
        when(() => mockDealsRepository.getPopularDeals(page: 2))
            .thenAnswer((_) async => [DealEntity(id: 2)]);
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetPopularDealsEvent(2)),
      expect: () => [
        isA<SuccessState>().having((state) => state.deals, 'deals', isNotEmpty),
      ],
      verify: (_) {
        verify(() => mockDealsRepository.getPopularDeals(page: 2)).called(1);
      },
    );
  });
}
