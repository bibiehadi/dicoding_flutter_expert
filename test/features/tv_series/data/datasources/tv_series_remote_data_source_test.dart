import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/datasources/remote/tv_series_remote_datasource_impl.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  // const ACCESS_TOKEN = 'bd0dc7e143f32a48c91035c472fbaee4';

  late TvSeriesRemoteDatasourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = TvSeriesRemoteDatasourceImpl(client: mockHttpClient);
  });

  group(
    'get Now Playing TvSeries',
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
}
