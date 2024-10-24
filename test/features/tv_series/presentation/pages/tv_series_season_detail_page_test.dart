import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_season_detail_page.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_series_season_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesSeasonDetailNotifier])
void main() {
  late MockTvSeriesSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesSeasonDetailNotifier>.value(
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

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSeasonDetailPage(
      seasonId: 1,
      seasonNumber: 1,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesSeasonDetail).thenReturn(TvSeriesSeasonDetail(
      id: 1,
      name: 'Season 1',
      overview: 'Overview',
      posterPath: '/poster.jpg',
      seasonNumber: 1,
      episodes: [],
      voteAverage: 1,
    ));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSeasonDetailPage(
      seasonId: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(
        TvSeriesSeasonDetailPage(seasonId: 1, seasonNumber: 1)));

    expect(textFinder, findsOneWidget);
  });
}
