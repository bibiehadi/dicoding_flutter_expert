import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:movies/presentation/bloc/recommendation_state/recommendation_movies_cubit.dart';
import 'package:movies/presentation/bloc/watchlist_detail_movie/watchlist_detail_movie_cubit.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieCubit extends MockCubit<DetailMovieState>
    implements DetailMovieCubit {}

class FakeDetailMovieState extends Fake implements DetailMovieState {}

class MockRecommendationMoviesCubit extends MockCubit<RecommendationMoviesState>
    implements RecommendationMoviesCubit {}

class FakeRecommendationMoviesState extends Fake
    implements RecommendationMoviesState {}

class MockWatchlistDetailMovieCubit extends MockCubit<WatchlistDetailMovieState>
    implements WatchlistDetailMovieCubit {}

class FakeWatchlistDetailMovieState extends Fake
    implements WatchlistDetailMovieState {}

void main() {
  late MockDetailMovieCubit mockDetailMovieCubit;
  late MockWatchlistDetailMovieCubit mockWatchlistCubit;
  late MockRecommendationMoviesCubit mockRecommendationCubit;

  setUpAll(() {
    registerFallbackValue(FakeDetailMovieState());
    registerFallbackValue(FakeWatchlistDetailMovieState());
    registerFallbackValue(FakeRecommendationMoviesState());
  });

  setUp(() {
    mockDetailMovieCubit = MockDetailMovieCubit();
    mockWatchlistCubit = MockWatchlistDetailMovieCubit();
    mockRecommendationCubit = MockRecommendationMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<DetailMovieCubit>.value(
        value: mockDetailMovieCubit,
      ),
      BlocProvider<WatchlistDetailMovieCubit>.value(
        value: mockWatchlistCubit,
      ),
      BlocProvider<RecommendationMoviesCubit>.value(
        value: mockRecommendationCubit,
      ),
    ], child: MaterialApp(home: body));
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));

    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: false, message: ''));

    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dislay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));

    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: true, message: ''));

    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));

    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: false, message: ''));

    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailMovieState(
              isAddedWatchlist: true, message: 'Added to watchlist')
        ]));

    when(() => mockWatchlistCubit.saveToWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));
    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailMovieState(
              isAddedWatchlist: false, message: 'Failed')
        ]));

    when(() => mockWatchlistCubit.saveToWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));

    final watchlistButton = find.byKey(const Key('watchlist_button'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));

    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(
            isAddedWatchlist: true, message: 'Added to watchlist'));

    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailMovieState(
              isAddedWatchlist: false, message: 'Removed from watchlist')
        ]));

    when(() => mockWatchlistCubit.removeFromWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when removed from watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));
    when(() => mockDetailMovieCubit.fetchDetailMovie(1))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(
            isAddedWatchlist: true, message: 'Added to watchlist'));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));
    when(() => mockRecommendationCubit.fetchRecommendationMovies(1))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailMovieState(
              isAddedWatchlist: true, message: 'Failed')
        ]));

    when(() => mockWatchlistCubit.removeFromWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));

    final watchlistButton = find.byKey(const Key('watchlist_button'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Page should display list view tv series recommendation data when loaded',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));
    when(() => mockDetailMovieCubit.fetchDetailMovie(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesSuccess(moviesData: const <Movie>[]));
    when(() => mockRecommendationCubit.fetchRecommendationMovies(81231))
        .thenAnswer((_) async => {});

    final detailContent = find.byKey(const Key('list_view_recommendation'));

    await tester
        .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 81231)));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailMovieCubit.state)
        .thenReturn(DetailMovieSuccess(movieDetail: testMovieDetail));
    when(() => mockDetailMovieCubit.fetchDetailMovie(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationMoviesFailed(message: 'Error message'));
    when(() => mockRecommendationCubit.fetchRecommendationMovies(81231))
        .thenAnswer((_) async => {});

    final textFinder = find.byKey(const Key('error_message_recommendation'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: 81231,
    )));

    expect(textFinder, findsOneWidget);
  });
}
