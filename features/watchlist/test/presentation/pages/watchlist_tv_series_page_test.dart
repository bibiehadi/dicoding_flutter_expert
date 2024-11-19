import 'package:core/core.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_series_page.dart';
import 'package:watchlist/presentation/widgets/watchlist_card.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvSeriesCubit extends MockCubit<WatchlistTvSeriesState>
    implements WatchlistTvSeriesCubit {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

void main() {
  late MockWatchlistTvSeriesCubit mockWatchlistTvSeriesCubit;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistTvSeriesState());
  });

  setUp(() {
    mockWatchlistTvSeriesCubit = MockWatchlistTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesCubit>(
      create: (context) => mockWatchlistTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('WatchlistPage should display progress when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesLoading(),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('WatchlistPage should display list when data is loaded',
      (WidgetTester tester) async {
    final watchlistTvSeries = <WatchlistTable>[
      testWatchlistTable,
    ];

    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => watchlistTvSeries);

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesSuccess(watchlistTvSeries),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.byType(WatchlistCard), findsOneWidget);
  });

  testWidgets('WatchlistPage should display message when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesFailed(message: 'No watchlist TvSeries found'),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.text('No watchlist TvSeries found'), findsOneWidget);
  });

  testWidgets('WatchlistPage should display message when error is occurred',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesFailed(message: 'Error occurred'),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
