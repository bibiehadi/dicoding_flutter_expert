import 'package:core/core.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:watchlist/presentation/widgets/watchlist_card.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMoviesCubit extends MockCubit<WatchlistMoviesState>
    implements WatchlistMoviesCubit {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

void main() {
  late MockWatchlistMoviesCubit mockWatchlistMoviesCubit;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMoviesState());
  });

  setUp(() {
    mockWatchlistMoviesCubit = MockWatchlistMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesCubit>(
      create: (context) => mockWatchlistMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('WatchlistPage should display progress when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesLoading(),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('WatchlistPage should display list when data is loaded',
      (WidgetTester tester) async {
    final watchlistMovies = <WatchlistTable>[
      testWatchlistTable,
    ];

    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => watchlistMovies);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesSuccess(watchlistMovies),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(WatchlistCard), findsOneWidget);
  });

  testWidgets('WatchlistPage should display message when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesFailed(message: 'No watchlist movies found'),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.text('No watchlist movies found'), findsOneWidget);
  });

  testWidgets('WatchlistPage should display message when error is occurred',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesCubit.getWatchlistMovies())
        .thenAnswer((_) async => <WatchlistTable>[]);

    when(() => mockWatchlistMoviesCubit.state).thenReturn(
      WatchlistMoviesFailed(message: 'Error occurred'),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
