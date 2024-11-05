import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display tv series detail data when loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final detailContent = find.byKey(const Key('detail_content'));

    await tester.pumpWidget(
        _makeTestableWidget(const TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loading);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final progressFinder =
        find.byKey(Key('circular_progress_indicator_recommendation'));
    final centerFinder = find.byKey(Key('loading_recommendation'));

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display list view tv series recommendation data when loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final detailContent = find.byKey(Key('list_view_recommendation'));

    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final textFinder = find.byKey(Key('error_message_recommendation'));

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
      tvSeriesId: 81231,
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendation).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(tvSeriesId: 81231)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
