import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';

class MockPopularTvSeriesCubit extends MockCubit<PopularTvSeriesState>
    implements PopularTvSeriesCubit {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakePopularTvSeriesState());
  });

  setUp(() {
    mockCubit = MockPopularTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchPopularTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state).thenReturn(PopularTvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchPopularTvSeries()).thenAnswer((_) async => {});

    when(() => mockCubit.state)
        .thenReturn(PopularTvSeriesSuccess(tvSeriesData: const <TvSeries>[]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchPopularTvSeries()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenReturn(PopularTvSeriesFailed(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvSeriesPopularPage()));

    expect(textFinder, findsOneWidget);
  });
}
