import 'dart:convert';

import '../../../../../core/lib/common/constants.dart';
import '../../../../../core/lib/common/exception.dart';
import '../../../../../features/tv_series/lib/data/datasources/remote/tv_series_remote_datasource_impl.dart';
import '../../../../../features/tv_series/lib/data/models/tv_series_detail.dart';
import '../../../../../features/tv_series/lib/data/models/tv_series_response.dart';
import '../../../../../features/tv_series/lib/data/models/tv_series_season_detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  late TvSeriesRemoteDatasourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
    mockHttpClient = MockHttpClient();
    datasource = TvSeriesRemoteDatasourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TvSeries', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_on_the_air.json')))
        .tvSeriesList;

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air'), headers: {
          'Authorization': 'Bearer $ACCESS_TOKEN',
          'accept': 'application/json',
        })).thenAnswer(
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air'), headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $ACCESS_TOKEN'
      })).thenAnswer((_) async => http.Response('Not Found', 404));
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
              Uri.parse('$BASE_URL/tv/popular?language=en-US&page=1'),
              headers: {
                'accept': 'application/json',
                'Authorization': 'Bearer $ACCESS_TOKEN'
              })).thenAnswer((_) async => http.Response(
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
            Uri.parse('$BASE_URL/tv/popular?language=en-US&page=1'),
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer $ACCESS_TOKEN'
            })).thenAnswer((_) async => http.Response('Not Found', 404));

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
              Uri.parse('$BASE_URL/tv/top_rated?language=en-US&page=1'),
              headers: {
                'accept': 'application/json',
                'Authorization': 'Bearer $ACCESS_TOKEN'
              })).thenAnswer((_) async => http.Response(
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
            Uri.parse('$BASE_URL/tv/top_rated?language=en-US&page=1'),
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer $ACCESS_TOKEN'
            })).thenAnswer((_) async => http.Response('Not Found', 404));

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
      final id = 209867;
      final tTvSeriesDetail = TvSeriesDetailModel.fromJson(
          json.decode(readJson('dummy_data/tv_series_detail.json')));

      test(
        "should return tv series detail when the respose code is 200",
        () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$id?language=en-US'), headers: {
            'Authorization': 'Bearer $ACCESS_TOKEN',
            'accept': 'application/json',
          })).thenAnswer((_) async =>
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
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?language=en-US'),
              headers: {
                'accept': 'application/json',
                'Authorization': 'Bearer $ACCESS_TOKEN'
              })).thenAnswer((_) async => http.Response('Not Found', 404));

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

    final id = 209867;

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$id/recommendations?language=en-US&page=1'),
          headers: {
            'Authorization': 'Bearer $ACCESS_TOKEN',
            'accept': 'application/json',
          },
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
        Uri.parse('$BASE_URL/tv/$id/recommendations?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $ACCESS_TOKEN'
        },
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

    final query = 'frieren';

    test(
      'should return list of TvSeries Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?query=$query&language=en-US&page=1'),
          headers: {
            'Authorization': 'Bearer $ACCESS_TOKEN',
            'accept': 'application/json',
          },
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
        Uri.parse('$BASE_URL/search/tv?query=$query&language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $ACCESS_TOKEN'
        },
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
      final id = 209867;
      final seasonNumber = 1;
      final tTvSeriesSeasonDetail = TvSeriesSeasonDetailModel.fromJson(
          json.decode(readJson('dummy_data/tv_series_season_detail.json')));

      test(
          'should return tv series season detail when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?language=en-US'),
            headers: {
              'Authorization': 'Bearer $ACCESS_TOKEN',
              'accept': 'application/json',
            })).thenAnswer((_) async => http.Response(
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
            Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?language=en-US'),
            headers: {
              'Authorization': 'Bearer $ACCESS_TOKEN',
              'accept': 'application/json',
            })).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = datasource.getTvSeriesSeasonDetail(id, seasonNumber);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    },
  );
}
