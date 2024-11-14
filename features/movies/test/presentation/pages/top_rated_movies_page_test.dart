import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMoviesCubit extends MockCubit<TopRatedMoviesState>
    implements TopRatedMoviesCubit {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

void main() {
  late MockTopRatedMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedMoviesCubit();
    registerFallbackValue(FakeTopRatedMoviesState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>(
      create: (context) {
        return mockCubit;
      },
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async => {});
    when(() => mockCubit.state).thenAnswer((_) => TopRatedMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenAnswer((_) => TopRatedMoviesSuccess(moviesData: const <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async => {});
    when(() => mockCubit.state)
        .thenAnswer((_) => TopRatedMoviesFailed(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display list view tv series recommendation data when loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(TopRatedMoviesSuccess(moviesData: testMovieList));
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async => {});

    final detailContent = find.byKey(const Key('list_view'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(detailContent, findsOneWidget);
  });

  testWidgets('Page should display test with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(TopRatedMoviesFailed(message: 'Error message'));
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async => {});

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
