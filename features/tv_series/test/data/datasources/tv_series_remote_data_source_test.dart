import 'dart:convert';

import 'package:core/core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_datasource_impl.dart';
import 'package:tv_series/data/models/tv_series_detail.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:tv_series/data/models/tv_series_season_detail.dart';

import '../../../../../test/json_reader.dart';
import '../../tv_series_test.mocks.dart';

void main() {
  late TvSeriesRemoteDatasourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    mockHttpClient = MockHttpClient();
    datasource = TvSeriesRemoteDatasourceImpl(client: mockHttpClient);
  });

  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  group('get Now Playing TvSeries', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_on_the_air.json')))
        .tvSeriesList;

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_on_the_air.json'),
            200,
          ),
        );
        // act
        final result = await datasource.getNowPlayingTvSeries();
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test('should throw a ServerExeption when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = datasource.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group(
    'get Popular TvSeries',
    () {
      final tTvSeriesList = TvSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tv_series_popular.json')))
          .tvSeriesList;

      test(
        'should return list of  TvSeries Model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
          )).thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_popular.json'), 200));

          //act
          final result = await datasource.getPopularTvSeries();

          // asert
          expect(result, equals(tTvSeriesList));
        },
      );

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = datasource.getPopularTvSeries();

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    },
  );

  group(
    'get Top Series TvSeries',
    () {
      final tTvSeriesList = TvSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tv_series_top_rated.json')))
          .tvSeriesList;

      test(
        'should return list of  TvSeries Model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
          )).thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_top_rated.json'), 200));

          //act
          final result = await datasource.getTopRatedTvSeries();

          // asert
          expect(result, equals(tTvSeriesList));
        },
      );

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = datasource.getTopRatedTvSeries();

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    },
  );

  group(
    'get detail tvSeries',
    () {
      const int id = 209867;
      final tTvSeriesDetail = TvSeriesDetailModel.fromJson(
          json.decode(readJson('dummy_data/tv_series_detail.json')));

      test(
        "should return tv series detail when the respose code is 200",
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$id?$API_KEY'),
          )).thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series_detail.json'), 200));

          // act
          final result = await datasource.getTvSeriesDetail(id);

          //assert
          expect(result, equals(tTvSeriesDetail));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$id?$API_KEY'),
          )).thenAnswer((_) async => http.Response('Not Found', 404));

          // act
          final call = datasource.getTvSeriesDetail(id);

          //assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group('get Recommendation TvSeries', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendation.json')))
        .tvSeriesList;

    const int id = 209867;

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_recommendation.json'),
            200,
          ),
        );
        // act
        final result = await datasource.getRecommendationTvSeries(id);
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test('should throw a ServerExeption when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = datasource.getRecommendationTvSeries(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TvSeries', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_search.json')))
        .tvSeriesList;

    const String query = 'frieren';

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_search.json'),
            200,
          ),
        );
        // act
        final result = await datasource.searchTvSeries(query);
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test('should throw a ServerExeption when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = datasource.searchTvSeries(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group(
    'Tv Series Season Detail',
    () {
      const id = 209867;
      const seasonNumber = 1;
      final tTvSeriesSeasonDetail = TvSeriesSeasonDetailModel.fromJson(
          json.decode(readJson('dummy_data/tv_series_season_detail.json')));

      test(
          'should return tv series season detail when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'),
        )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/tv_series_season_detail.json'), 200));

        // act
        final result =
            await datasource.getTvSeriesSeasonDetail(id, seasonNumber);
        // assert
        expect(result, equals(tTvSeriesSeasonDetail));
      });

      test(
          'should throws Server Exception when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = datasource.getTvSeriesSeasonDetail(id, seasonNumber);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    },
  );
}
