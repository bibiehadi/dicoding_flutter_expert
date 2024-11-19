import 'package:core/core.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

class MockWatchlistTvSeriesCubit extends MockCubit<WatchlistTvSeriesState>
    implements WatchlistTvSeriesCubit {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

class MockWatchlistMoviesCubit extends MockCubit<WatchlistMoviesState>
    implements WatchlistMoviesCubit {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

void main() {
  late MockWatchlistMoviesCubit mockWatchlistMoviesCubit;
  late MockWatchlistTvSeriesCubit mockWatchlistTvSeriesCubit;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMoviesState());
    registerFallbackValue(FakeWatchlistTvSeriesState());
  });

  setUp(() {
    mockWatchlistMoviesCubit = MockWatchlistMoviesCubit();
    mockWatchlistTvSeriesCubit = MockWatchlistTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMoviesCubit>(
          create: (context) => mockWatchlistMoviesCubit,
        ),
        BlocProvider<WatchlistTvSeriesCubit>(
          create: (context) => mockWatchlistTvSeriesCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('WatchlistPage should display progress when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);
    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesLoading(),
    );

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesLoading(),
    );

    const watchlistPage = WatchlistPage();

    await tester.pumpWidget(makeTestableWidget(watchlistPage));

    expect(find.byKey(const Key('watchlist_movies_loading')), findsOneWidget);
    expect(
        find.byKey(const Key('watchlist_tv_series_loading')), findsOneWidget);
  });

  testWidgets('WatchlistPage should display watchlist movies and tv series',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);
    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesSuccess(const <WatchlistTable>[]),
    );

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesSuccess(const <WatchlistTable>[]),
    );

    const watchlistPage = WatchlistPage();

    await tester.pumpWidget(makeTestableWidget(watchlistPage));

    expect(find.byKey(const Key('watchlist_movies_list')), findsOneWidget);

    expect(find.byKey(const Key('watchlist_tv_series_list')), findsOneWidget);
  });

  testWidgets('WatchlistPage should display error message when failed',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistTvSeriesCubit.getWatchlistTvSeries())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesFailed(message: 'Failed to load movies'),
    );

    when(() => mockWatchlistTvSeriesCubit.state).thenReturn(
      WatchlistTvSeriesFailed(message: 'Failed to load tv series'),
    );

    const watchlistPage = WatchlistPage();

    await tester.pumpWidget(makeTestableWidget(watchlistPage));

    await tester.pump();

    expect(find.byKey(const Key('watchlist_movies_failed')), findsOneWidget);
    expect(find.byKey(const Key('watchlist_tv_series_failed')), findsOneWidget);
  });
}
