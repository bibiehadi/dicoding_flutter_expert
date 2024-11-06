import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:tv_series/presentation/provider/tv_series_popular_notifier.dart';

import 'tv_series_popular_page_test.mocks.dart';

@GenerateMocks([TvSeriesPopularNotifier])
void main() {
  late MockTvSeriesPopularNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesPopularNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesPopularNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPopularPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvSeries).thenReturn(<TvSeries>[]);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPopularPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPopularPage()));

    expect(textFinder, findsOneWidget);
  });
}
