import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series/recommendation_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTvSeriesCubit extends MockCubit<DetailTvSeriesState>
    implements DetailTvSeriesCubit {}

class FakeDetailTvSeriesState extends Fake implements DetailTvSeriesState {}

class MockRecommendationTvSeriesCubit
    extends MockCubit<RecommendationTvSeriesState>
    implements RecommendationTvSeriesCubit {}

class FakeRecommendationTvSeriesState extends Fake
    implements RecommendationTvSeriesState {}

class MockWatchlistTvSeriesCubit extends MockCubit<WatchlistDetailTvSeriesState>
    implements WatchlistDetailTvSeriesCubit {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistDetailTvSeriesState {}

void main() {
  late MockDetailTvSeriesCubit mockDetailTvSeriesCubit;
  late MockRecommendationTvSeriesCubit mockRecommendationCubit;
  late MockWatchlistTvSeriesCubit mockWatchlistCubit;

  setUp(() {
    mockDetailTvSeriesCubit = MockDetailTvSeriesCubit();
    mockRecommendationCubit = MockRecommendationTvSeriesCubit();
    mockWatchlistCubit = MockWatchlistTvSeriesCubit();
  });

  setUpAll(() {
    registerFallbackValue(FakeDetailTvSeriesState());
    registerFallbackValue(FakeRecommendationTvSeriesState());
    registerFallbackValue(FakeWatchlistTvSeriesState());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesCubit>.value(value: mockDetailTvSeriesCubit),
        BlocProvider<RecommendationTvSeriesCubit>.value(
            value: mockRecommendationCubit),
        BlocProvider<WatchlistDetailTvSeriesCubit>.value(
            value: mockWatchlistCubit),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesLoading());
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display tv series detail data when loaded',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state).thenReturn(
        RecommendationTvSeriesSuccess(tvSeriesList: const <TvSeries>[]));
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final detailContent = find.byKey(const Key('detail_content'));

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesFailed(message: 'Error message'));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final progressFinder = find.byKey(const Key('loading_recommendation'));
    final centerFinder = find.byKey(const Key('center_loading_recommendation'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display list view tv series recommendation data when loaded',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state).thenReturn(
        RecommendationTvSeriesSuccess(tvSeriesList: const <TvSeries>[]));
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final detailContent = find.byKey(const Key('list_view_recommendation'));

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesFailed(message: 'Error message'));
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final textFinder = find.byKey(const Key('error_message_recommendation'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: 'Added to watchlist'));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailTvSeriesState(
              isAddedToWatchlist: true, message: 'Added to watchlist')
        ]));

    when(() => mockWatchlistCubit.addWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => {});

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailTvSeriesState(
              isAddedToWatchlist: false, message: 'Failed')
        ]));

    when(() => mockWatchlistCubit.addWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => {});
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: 'Added to watchlist'));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailTvSeriesState(
              isAddedToWatchlist: false, message: 'Removed from watchlist')
        ]));

    when(() => mockWatchlistCubit.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => {});

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when removed watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesCubit.state)
        .thenReturn(DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail));
    when(() => mockDetailTvSeriesCubit.fetchTvSeriesDetail(81231))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistCubit.state).thenReturn(
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: ''));
    when(() => mockWatchlistCubit.loadWatchlistStatus(81231))
        .thenAnswer((_) async => {});
    when(() => mockRecommendationCubit.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => mockRecommendationCubit.fetchRecommendationTvSeries(81231))
        .thenAnswer((_) async => {});

    whenListen(
        mockWatchlistCubit,
        Stream.fromIterable([
          const WatchlistDetailTvSeriesState(
              isAddedToWatchlist: true, message: 'Failed')
        ]));

    when(() => mockWatchlistCubit.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => {});
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
