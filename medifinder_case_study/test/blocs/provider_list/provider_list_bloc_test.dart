import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/models/provider_page_result.dart';
import 'package:medifinder_case_study/repos/provider_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(ProviderType.doctor);
  });

  group('ProviderListBloc', () {
    late MockProviderRepository mockRepository;

    const mockProvider = ProviderModel(
      id: '1',
      name: 'Test',
      type: ProviderType.doctor,
      specialty: 'Cardio',
      country: 'TR',
      city: 'IST',
      rating: 5.0,
      reviewCount: 10,
    );

    const mockPage = ProviderPageResult(
      items: [mockProvider],
      totalCount: 42,
      offset: 0,
      limit: 12,
    );

    setUp(() {
      mockRepository = MockProviderRepository();
      when(() => mockRepository.ensureCatalogLoaded()).thenAnswer((_) async {});
      when(() => mockRepository.getTotalCounts(filter: any(named: 'filter')))
          .thenReturn({ProviderType.doctor: 42, ProviderType.clinic: 10, ProviderType.hospital: 8});
    });

    blocTest<ProviderListBloc, ProviderListState>(
      'emits [loading, success] when ProviderListFetched is added and succeeds',
      build: () {
        when(
          () => mockRepository.getProviderPage(
            type: ProviderType.doctor,
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => mockPage);
        return ProviderListBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const ProviderListFetched()),
      expect: () => [
        isA<ProviderListState>()
            .having((s) => s.status, 'status', ProviderListStatus.loading),
        isA<ProviderListState>()
            .having((s) => s.status, 'status', ProviderListStatus.success)
            .having(
              (s) => s.providersForType(ProviderType.doctor).length,
              'doctorCount',
              1,
            )
            .having(
              (s) => s.totalCountForType(ProviderType.doctor),
              'doctorTotal',
              42,
            ),
      ],
      verify: (_) {
        verify(() => mockRepository.ensureCatalogLoaded()).called(1);
        verify(
          () => mockRepository.getProviderPage(type: ProviderType.doctor),
        ).called(1);
      },
    );

    blocTest<ProviderListBloc, ProviderListState>(
      'emits [loading, failure] when ProviderListFetched throws exception',
      build: () {
        when(() => mockRepository.ensureCatalogLoaded())
            .thenThrow(Exception('Failed'));
        return ProviderListBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const ProviderListFetched()),
      expect: () => [
        isA<ProviderListState>()
            .having((s) => s.status, 'status', ProviderListStatus.loading),
        isA<ProviderListState>()
            .having((s) => s.status, 'status', ProviderListStatus.failure)
            .having((s) => s.errorMessage, 'error', contains('Failed')),
      ],
    );

    blocTest<ProviderListBloc, ProviderListState>(
      'emits refreshed pages with updated filter on ProviderListSearched',
      build: () {
        when(
          () => mockRepository.getProviderPage(
            type: any(named: 'type'),
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => const ProviderPageResult(
              items: [],
              totalCount: 0,
              offset: 0,
              limit: 12,
            ));
        return ProviderListBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const ProviderListSearched('Query')),
      expect: () => [
        isA<ProviderListState>().having((s) => s.isRefreshing, 'refresh', true),
        isA<ProviderListState>()
            .having((s) => s.filter.searchQuery, 'query', 'Query')
            .having((s) => s.isRefreshing, 'refresh', false),
      ],
    );

    blocTest<ProviderListBloc, ProviderListState>(
      'appends items on ProviderListLoadMore',
      build: () {
        when(
          () => mockRepository.getProviderPage(
            type: ProviderType.doctor,
            filter: any(named: 'filter'),
            offset: 1,
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (_) async => const ProviderPageResult(
            items: [mockProvider],
            totalCount: 42,
            offset: 1,
            limit: 12,
          ),
        );
        return ProviderListBloc(repository: mockRepository)
          ..emit(
            ProviderListState(
              status: ProviderListStatus.success,
              tabProviders: {
                ProviderType.doctor: const [
                  ProviderModel(
                    id: '0',
                    name: 'Existing',
                    type: ProviderType.doctor,
                    specialty: 'Cardio',
                    country: 'TR',
                    city: 'IST',
                    rating: 4,
                    reviewCount: 1,
                  ),
                ],
              },
              tabOffsets: {ProviderType.doctor: 1},
              tabTotalCounts: {ProviderType.doctor: 42},
              tabHasReachedMax: {ProviderType.doctor: false},
            ),
          );
      },
      act: (bloc) => bloc.add(const ProviderListLoadMore(ProviderType.doctor)),
      expect: () => [
        isA<ProviderListState>().having((s) => s.isLoadingMore, 'loading', true),
        isA<ProviderListState>()
            .having(
              (s) => s.providersForType(ProviderType.doctor).length,
              'count',
              2,
            )
            .having((s) => s.isLoadingMore, 'loading', false),
      ],
    );
  });
}
