import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_season_detail_page.dart';

class MockSeasonDetailTvSeriesCubit extends MockCubit<SeasonDetailTvSeriesState>
    implements SeasonDetailTvSeriesCubit {}

class FakeSeasonDetailTvSeriesState extends Fake
    implements SeasonDetailTvSeriesState {}

void main() {
  late MockSeasonDetailTvSeriesCubit mockCubit;

  setUp(() {
    mockCubit = MockSeasonDetailTvSeriesCubit();
    registerFallbackValue(FakeSeasonDetailTvSeriesState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailTvSeriesCubit>.value(
        value: mockCubit,
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(SeasonDetailTvSeriesLoading());
    when(() => mockCubit.fetchdetailSeasonTvSeries(1, 1))
        .thenAnswer((_) async => {});

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesSeasonDetailPage(
      seasonId: 1,
      seasonNumber: 1,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(SeasonDetailTvSeriesSuccess(
      tvSeriesData: const TvSeriesSeasonDetail(
        id: 1,
        name: 'Season 1',
        overview: 'Overview',
        posterPath: '/poster.jpg',
        seasonNumber: 1,
        episodes: [],
        voteAverage: 1,
      ),
    ));
    when(() => mockCubit.fetchdetailSeasonTvSeries(1, 1))
        .thenAnswer((_) async => {});

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesSeasonDetailPage(
      seasonId: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(SeasonDetailTvSeriesFailed(message: 'Error'));
    when(() => mockCubit.fetchdetailSeasonTvSeries(1, 1))
        .thenAnswer((_) async => {});

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(
        const TvSeriesSeasonDetailPage(seasonId: 1, seasonNumber: 1)));

    expect(textFinder, findsOneWidget);
  });
}
