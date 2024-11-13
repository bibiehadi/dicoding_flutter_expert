import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_now_playing_page.dart';

class MockNowPlayingTvSeriesCubit extends MockCubit<NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesCubit {}

class FakeNowPlayingTvSeriesState extends Fake
    implements NowPlayingTvSeriesState {}

void main() {
  late MockNowPlayingTvSeriesCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingTvSeriesState());
  });

  setUp(() {
    mockCubit = MockNowPlayingTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchNowPlayingTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state).thenReturn(NowPlayingTvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchNowPlayingTvSeries()).thenAnswer((_) async => {});

    when(() => mockCubit.state).thenReturn(
        NowPlayingTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchNowPlayingTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenReturn(NowPlayingTvSeriesFailed(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesNowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}
