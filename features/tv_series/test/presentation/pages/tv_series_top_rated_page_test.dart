import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_top_rated_page.dart';
import 'package:tv_series/tv_series.dart';

class MockTopRatedTvSeriesCubit extends MockCubit<TopRatedTvSeriesState>
    implements TopRatedTvSeriesCubit {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriesCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  setUp(() {
    mockCubit = MockTopRatedTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state).thenReturn(TopRatedTvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedTvSeries()).thenAnswer((_) async => {});

    when(() => mockCubit.state)
        .thenReturn(TopRatedTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenReturn(TopRatedTvSeriesFailed(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });
}
