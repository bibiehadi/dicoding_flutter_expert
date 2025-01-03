import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

void main() {
  late MockPopularMoviesCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakePopularMoviesState());
  });

  setUp(() {
    mockCubit = MockPopularMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchPopularMovies()).thenAnswer((_) async => {});
    when(() => mockCubit.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchPopularMovies()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenReturn(PopularMoviesFailed(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display list view tv series recommendation data when loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(PopularMoviesSuccess(moviesData: testMovieList));
    when(() => mockCubit.fetchPopularMovies()).thenAnswer((_) async => {});

    final detailContent = find.byKey(const Key('list_view'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(detailContent, findsOneWidget);
  });
}
