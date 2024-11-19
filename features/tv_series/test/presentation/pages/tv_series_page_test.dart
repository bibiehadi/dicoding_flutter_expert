import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_page.dart';
import 'package:tv_series/tv_series.dart';

class MockNowPlayingTvSeriesCubit extends MockCubit<NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesCubit {}

class FakeNowPlayingTvSeriesState extends Fake
    implements NowPlayingTvSeriesState {}

class MockPopularTvSeriesCubit extends MockCubit<PopularTvSeriesState>
    implements PopularTvSeriesCubit {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

class MockTopRatedTvSeriesCubit extends MockCubit<TopRatedTvSeriesState>
    implements TopRatedTvSeriesCubit {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingTvSeriesState());
    registerFallbackValue(FakePopularTvSeriesState());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesCubit>.value(
          value: mockNowPlayingTvSeriesCubit,
        ),
        BlocProvider<PopularTvSeriesCubit>.value(
          value: mockPopularTvSeriesCubit,
        ),
        BlocProvider<TopRatedTvSeriesCubit>.value(
          value: mockTopRatedTvSeriesCubit,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  group('now playing tv series test', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final progressFinder =
          find.byKey(const Key('now_playing_tv_series_loading'));
      final centerFinder =
          find.byKey(const Key('now_playing_tv_series_center'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state).thenReturn(
          NowPlayingTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final listViewFinder =
          find.byKey(const Key('now_playing_tv_series_list'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display test with message when Error',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesFailed(message: 'Error message'));

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final textFinder = find.byKey(const Key('now_playing_tv_series_failed'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('popular tv series test', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final progressFinder = find.byKey(const Key('popular_tv_series_loading'));
      final centerFinder = find.byKey(const Key('popular_tv_series_center'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final listViewFinder = find.byKey(const Key('popular_tv_series_list'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display test with message when Error',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesFailed(message: 'Error message'));

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final textFinder = find.byKey(const Key('popular_tv_series_failed'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('top rated tv series test', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final progressFinder =
          find.byKey(const Key('top_rated_tv_series_loading'));
      final centerFinder = find.byKey(const Key('top_rated_tv_series_center'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesFailed(message: 'Error message'));

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state).thenReturn(
          TopRatedTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));

      final listViewFinder = find.byKey(const Key('top_rated_tv_series_list'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display test with message when Error',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvSeriesCubit.fetchNowPlayingTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockNowPlayingTvSeriesCubit.state)
          .thenReturn(NowPlayingTvSeriesFailed(message: 'Error message'));

      when(() => mockPopularTvSeriesCubit.fetchPopularTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockPopularTvSeriesCubit.state)
          .thenReturn(PopularTvSeriesLoading());

      when(() => mockTopRatedTvSeriesCubit.fetchTopRatedTvSeries())
          .thenAnswer((_) async => {});
      when(() => mockTopRatedTvSeriesCubit.state)
          .thenReturn(TopRatedTvSeriesFailed(message: 'Error message'));

      final textFinder = find.byKey(const Key('top_rated_tv_series_failed'));

      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
