import 'dart:convert';

import 'package:core/core.dart';

import 'tv_series_remote_datasource.dart';
import '../../models/tv_series_detail.dart';
import '../../models/tv_series_model.dart';
import '../../models/tv_series_response.dart';
import '../../models/tv_series_season_detail.dart';
import 'package:http/http.dart' as http;

class TvSeriesRemoteDatasourceImpl implements TvSeriesRemoteDatasource {
  final http.Client client;

  TvSeriesRemoteDatasourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/on_the_air'), headers: {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client
        .get(Uri.parse('$baseURL/tv/popular?language=en-US&page=1'), headers: {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
        Uri.parse('$baseURL/tv/top_rated?language=en-US&page=1'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json',
        });
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/$id?language=en-US'), headers: {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
        Uri.parse('$baseURL/search/tv?query=$query&language=en-US&page=1'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendationTvSeries(int id) async {
    final response = await client.get(
        Uri.parse('$baseURL/tv/$id/recommendations?language=en-US&page=1'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesSeasonDetailModel> getTvSeriesSeasonDetail(
      int id, int seasonNumber) async {
    final response = await client.get(
        Uri.parse('$baseURL/tv/$id/season/$seasonNumber?language=en-US'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return TvSeriesSeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
