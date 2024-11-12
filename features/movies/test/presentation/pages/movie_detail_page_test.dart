import 'package:core/core.dart';
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
      'Watchlist button should dispay check icon when movie is added to wathclist',
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

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
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

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
