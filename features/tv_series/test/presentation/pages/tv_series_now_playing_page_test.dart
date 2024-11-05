import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/pages/tv_series_now_playing_page.dart';
import 'package:tv_series/presentation/provider/tv_series_now_playing_notifier.dart';

import 'tv_series_now_playing_page_test.mocks.dart';

@GenerateMocks([TvSeriesNowPlayingNotifier])
void main() {
  late MockTvSeriesNowPlayingNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesNowPlayingNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesNowPlayingNotifier>.value(
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

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(<TvSeries>[]);
    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}
